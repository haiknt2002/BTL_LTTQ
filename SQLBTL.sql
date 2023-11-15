use [BTL_LTTQ]
go
CREATE OR ALTER TRIGGER trg_UpdatePriceAfterDiscount
ON [dbo].[SelectedItem]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	-- Tính toán PriceAfterDiscount trước
    UPDATE si
    SET si.PriceAfterDiscount =
        CASE
			WHEN d.DiscountType = N'Khuyến mãi theo % giá bán' THEN CAST(it.Price AS decimal(10, 2)) - (CAST(it.Price AS decimal(10, 2)) * CAST(d.DiscountPercent AS decimal(10, 2)) / 100.0)
			WHEN d.DiscountType = N'Giảm giá trực tiếp' THEN CAST(it.Price AS decimal(10, 2)) - CAST(d.DiscountPriceAmount AS decimal(10, 2))
			ELSE CAST(it.Price AS decimal(10, 2))
		END
    FROM [dbo].[SelectedItem] si
    INNER JOIN INSERTED i ON si.Item_ID = i.Item_ID
    INNER JOIN [dbo].[Item] it ON si.Item_ID = it.Item_ID
    INNER JOIN [dbo].[Discount] d ON it.Discount_ID = d.Discount_ID;

	-- Tính toán TotalAmount sau
	UPDATE si
    SET si.TotalAmount = CAST(si.PriceAfterDiscount AS decimal(10, 2)) * ISNULL(si.NumberOfSelectedItem, 0)
    FROM [dbo].[SelectedItem] si
    INNER JOIN INSERTED i ON si.Item_ID = i.Item_ID;
	------------------------------------------------------
	 -- Tính tổng số lượng item trong giỏ hàng dựa trên PriceAfterDiscount
    UPDATE c
    SET c.TotalItem = (
        SELECT SUM(si.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] si
    )
    FROM [dbo].[Cart] c

	-- Tính tổng tiền
    UPDATE c
    SET c.TotalAmount = (
        SELECT SUM(si.PriceAfterDiscount)
        FROM [dbo].[SelectedItem] si
    )
    FROM [dbo].[Cart] c

    -- Tính tổng khuyến mãi
    UPDATE c
    SET c.TotalDiscountAmount = (
        SELECT SUM(it.Price - si.PriceAfterDiscount)
        FROM [dbo].[SelectedItem] si
			INNER JOIN [dbo].[Item] it ON si.Item_ID = it.Item_ID
    )
    FROM [dbo].[Cart] c
END;


--INSERT INTO SelectedItem (NumberOfSelectedItem, PriceAfterDiscount, Item_ID) VALUES (5, 0, 4)

go
-- trigger cart
CREATE OR ALTER TRIGGER trg_CalculateCartTotal
ON [dbo].[Cart]
AFTER INSERT, UPDATE
AS
BEGIN
	--DECLARE @Cart_ID INT;

 --   SELECT @Cart_ID = Cart_ID FROM INSERTED

    -- Tính tổng số lượng item trong giỏ hàng dựa trên PriceAfterDiscount
    UPDATE c
    SET c.TotalItem = (
        SELECT SUM(si.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] si
    )
    FROM [dbo].[Cart] c

	-- Tính tổng tiền
    UPDATE c
    SET c.TotalAmount = (
        SELECT SUM(si.NumberOfSelectedItem * si.PriceAfterDiscount)
        FROM [dbo].[SelectedItem] si
    )
    FROM [dbo].[Cart] c

    -- Tính tổng khuyến mãi
    UPDATE c
    SET c.TotalDiscountAmount = (
        SELECT SUM((it.Price - si.PriceAfterDiscount) * si.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] si
			INNER JOIN [dbo].[Item] it ON si.Item_ID = it.Item_ID
    )
    FROM [dbo].[Cart] c
	--WHERE c.Cart_ID = @Cart_ID;

END;
go
--- tạo procedure tính hàng tồn
CREATE OR ALTER PROCEDURE UpdateItemInventory
AS
BEGIN
    -- Cập nhật số lượng tồn cho từng mặt hàng trong bảng [Item]
    UPDATE it
    SET it.Quantity = it.Quantity - ISNULL((
        SELECT SUM(sel.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] as sel
        WHERE sel.Item_ID = it.Item_ID
    ), 0)
    FROM [dbo].[Item] AS it;

	-- update inventory
	UPDATE inven
	SET inven.Inven_number = it.Quantity
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID

		-- update Inven_sold_quantity
	UPDATE inven
	SET inven.Inven_sold_quantity = inven.Inven_sold_quantity + ISNULL((
        SELECT SUM(sel.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] as sel
        WHERE sel.Item_ID = it.Item_ID
    ), 0)
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID	

	-- update Inven_sold_revenue
	UPDATE inven
	SET inven.Inven_sold_revenue = isnull((inven.Inven_sold_quantity * it.Price), 0)
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID
	WHERE it.Item_ID = inven.Item_ID
END;
go
-- trigger bill when to create bill to copy createTime to dateBill from Inventory table
--create or alter trigger inven_dateBill 
--on [dbo].[Bill]
--after insert
--as
--begin
--	declare @dateTime date
--	select @dateTime = i.CreateTime from inserted i
--	-- update dateBill
--	update inven
--	set inven.dateBill = @dateTime
--	from [dbo].[Inventory] as inven
--end

--select cus.Customer_ID, cus.FullName, count(*) as times, sum(b.TotalItem) as quantity,sum(b.TotalAmount) as total
--from (([dbo].[Bill] as b
--	join [dbo].[Cart] as c on c.Cart_ID = b.Cart_ID)
--	join [dbo].[Customer] as cus on cus.Customer_ID = c.Customer_ID)
--group by cus.Customer_ID, cus.FullName