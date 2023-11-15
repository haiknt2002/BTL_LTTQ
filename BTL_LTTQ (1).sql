--create database BTL_LTTQ
USE [BTL_LTTQ]
GO

/****** Object:  Table [dbo].[Bill]    Script Date: 10/5/2023 23:50:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Bill](
	[Bill_ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[SubTotal] [float] NULL,
	[Status] [nvarchar](50) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[StaffName] [nvarchar](50) NULL,
	[Cart_ID] [int] NOT NULL,
	[TotalDiscountAmount] [float] NULL,
	[TotalAmount] [float] NULL,
	[TotalItem] [int] NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[Bill_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO





USE [BTL_LTTQ]
GO

/****** Object:  Table [dbo].[Cart]    Script Date: 10/5/2023 23:50:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cart](
	[Cart_ID] [int] IDENTITY(1,1) NOT NULL,
	[TotalItem] [int] NULL,
	[TotalDiscountAmount] [float] NULL,
	[TotalAmount] [float] NULL,
	[Customer_ID] [int] NOT NULL,
	[SelectedItem_ID] [int] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[Cart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [BTL_LTTQ]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 10/5/2023 23:50:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[Customer_ID] [int] NOT NULL,
	[BirthDate] [datetime] NULL,
	[Address] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[CustomerType] [nvarchar](50) NULL,
	[Point] [int] NULL,
	[CreateTime] [datetime] NULL,
	[Email] [nvarchar](50) NULL,
	[FullName] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [BTL_LTTQ]
GO

/****** Object:  Table [dbo].[Discount]    Script Date: 10/5/2023 23:50:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Discount](
	[Discount_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[DiscountType] [nvarchar](50) NULL,
	[DiscountPercent] [int] NULL,
	[DiscountPriceAmount] [int] NULL,
	[MinPriceToUseDiscount] [int] NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[Discount_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [BTL_LTTQ]
GO

/****** Object:  Table [dbo].[Item]    Script Date: 10/5/2023 23:50:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Item](
	[Item_ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](50) NULL,
	[ItemType] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Brand] [nvarchar](50) NULL,
	[ReleaseDate] [datetime] NULL,
	[Price] [int] NULL,
	[Discount_ID] [int] NOT NULL,
	[Image] nvarchar(100) not null default '',
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Inventory (
    Inventory_id INT PRIMARY KEY IDENTITY(1,1),
    Item_ID INT,
    Inven_number INT,
	Inven_sold_revenue decimal(18, 2),
	Inven_sold_quantity int,
	dateBill [datetime] NULL,
    FOREIGN KEY (Item_ID) REFERENCES Item (Item_ID)
);

/****** Object:  Table [dbo].[SelectedItem]    Script Date: 10/5/2023 23:50:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SelectedItem](
	[SelectedItem_ID] [int] IDENTITY(1,1) NOT NULL,
	[NumberOfSelectedItem] [int] NULL,
	[PriceAfterDiscount] [int] NULL,
	[Item_ID] [int] NOT NULL,
	[TotalAmount] decimal(10,2) NULL,
 CONSTRAINT [PK_SelectedItem] PRIMARY KEY CLUSTERED 
(
	[SelectedItem_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--tao khoa phu --------------------------------------------------------------


ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Cart] FOREIGN KEY([Cart_ID])
REFERENCES [dbo].[Cart] ([Cart_ID])
GO

ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Cart]
GO


ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO

ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Customer]
GO

ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_SelectedItem] FOREIGN KEY([SelectedItem_ID])
REFERENCES [dbo].[SelectedItem] ([SelectedItem_ID])
GO

ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_SelectedItem]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Discount] FOREIGN KEY([Discount_ID])
REFERENCES [dbo].[Discount] ([Discount_ID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Discount]
GO

USE [BTL_LTTQ]
GO

ALTER TABLE [dbo].[SelectedItem]  WITH CHECK ADD  CONSTRAINT [FK_SelectedItem_Item] FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Item] ([Item_ID])
GO

ALTER TABLE [dbo].[SelectedItem] CHECK CONSTRAINT [FK_SelectedItem_Item]
GO



--insert values-------------------------------------------

INSERT INTO [dbo].[Discount] ([Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount])
VALUES
	( 'Back to School', '2023-09-01', '2023-09-30', N'Không áp dụng', 5, 50000, 150000),
    ( 'Black Friday', '2023-11-25', '2023-11-27', N'Giảm giá trực tiếp', 6, 100000,3000000),
    ( 'Tet Holiday', '2024-01-20', '2024-01-25', N'Khuyến mãi theo % giá bán', 10 ,150000, 1500000),
    ( 'Summer Sale', '2023-06-15', '2023-07-15', N'Không áp dụng', 3, 80000, 1800000),
    ( 'Christmas Special', '2023-12-10', '2023-12-25', N'Khuyến mãi theo % giá bán', 5, 100000, 2500000),
    ( 'Teacher''s Day', '2023-11-15', '2023-11-25', N'Giảm giá trực tiếp', 4, 45000, 2000000);

INSERT INTO [dbo].[Item] ([ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image])
VALUES
	( N'Snack Swing', N'Đồ ăn', 100, N'Oishi', '2023-06-15', 10000, 1, ''),
	( N'Cocacola', N'Đồ uống', 100, N'Coca', '2023-07-10', 12000, 6, ''),
	( N'Bột canh', N'Gia vị', 50, N'Quảng Tĩnh', '2023-09-11', 14000, 1, ''),
	( N'Mì chính', N'Gia vị', 50, N'Quảng Tĩnh', '2023-09-11', 14000, 3, ''),
	( N'Mì tôm', N'Đồ ăn', 120, N'Brinks', '2023-10-16', 5000, 4, ''),
	( N'Socala thanh', N'Đồ ăn', 75, N'Hershey''s', '2023-08-20', 15000, 2, ''),
	( N'Green Tea', N'Đồ uống', 90, N'Teavana', '2023-07-25', 18000, 5, ''),
	( N'Muối', N'Gia vị', 40, N'Văn Hải', '2023-09-05', 5000, 3, ''),
	( N'Tiêu đen', N'Gia vị', 45, N'Văn Hải', '2023-10-10', 6000, 6, ''),
	( N'Chanh muối', N'Đồ uống', 60, N'Phương Nam', '2023-07-05', 7000, 4, '')

INSERT INTO [dbo].[Inventory] ([Item_ID], [Inven_number])
VALUES
	(1, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1)

INSERT INTO [dbo].[Customer]
([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password])
VALUES
	(045678901, '1993-11-08', N'Đà Nẵng', '0956781234', N'Khách mua lẻ', 60, '2022-07-22', 'thanh045678901234@gmail.com', N'Lê Thanh', N'thanhle1234', '123456'),
	(056789012, '1980-09-17', N'Hà Nội', '0865432109', N'Khách mua buôn', 85, '2022-12-15', 'hoang056789012345@gmail.com', N'Phạm Văn Hoàng', N'hoangpham1234', '123456'),
	(067890123, '1995-03-25', N'TP HCM', '0978901234', N'Khách mua lẻ', 70, '2022-06-30', 'my067890123456@gmail.com', N'Nguyễn Thị Mỹ', N'nguyenmy1234', '123456'),
	(078901234, '1987-02-14', N'Đà Lạt', '0823456789', N'Khách mua buôn', 110, '2022-11-28', 'thien078901234567@gmail.com', N'Nguyễn Văn Thiện', N'thiennguyen', '123456'),
	(089012345, '1991-06-10', N'Hà Nội', '0987651234', N'Khách mua lẻ', 55, '2022-10-01', 'phuong089012345678@gmail.com', N'Nguyễn Thị Phương', N'phuongnguyen', '123456'),
	(090123456, '1983-04-12', N'Hải Phòng', '0934567890', N'Khách mua buôn', 95, '2022-09-18', 'trung090123456789@gmail.com', N'Vũ Trọng Trung', N'vutrung1234', '123456'),
	(012345678, '1994-08-19', N'Đà Nẵng', '0956789123', N'Khách mua lẻ', 80, '2022-08-14', 'linh012345678900@gmail.com', N'Phạm Thị Linh', N'phamlinh1234', '123456'),
	(023456789, '1982-12-31', N'TP HCM', '0887654321', N'Khách mua buôn', 125, '2022-07-10', 'nam023456789012@gmail.com', N'Nguyễn Văn Nam', N'namnguyen1234', '123456'),
	(034567890, '1990-07-06', N'Hà Nội', '0967890123', N'Khách mua lẻ', 70, '2022-12-05', 'hien034567890123@gmail.com', N'Nguyễn Thị Hiền', N'hiennguyen1234', '123456'),
	(045678902, '1986-05-28', N'Nha Trang', '0856789012', N'Khách mua buôn', 115, '2022-11-19', 'tuan045678901234@gmail.com', N'Phan Văn Tuấn', N'tuanpham1234', '123456'),
	(027203003, '1999-05-20', N'Hà Nội', '0354857894', N'Khách mua buôn', 100, '2022-10-25', 'hai027203003102@gmail.com', N'Nguyễn Văn Hải', N'hainguyen1234', '123456'),
	(023201485, '1984-07-11', N'TP HCM', '0995412241', N'Khách mua lẻ', 50, '2022-11-05', 'bich023201485621@gmail.com', N'Trần Thị Bích', N'tranbich1234', '123456'),
	(023201286, '1984-07-11', N'TP HCM', '0995412241', N'Khách mua lẻ', 0, '2022-11-05', 'admin', N'admin', 'admin', 'admin');

