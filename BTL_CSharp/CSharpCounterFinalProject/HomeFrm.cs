using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows.Forms;
using Excel = Microsoft.Office.Interop.Excel;

namespace CSharpCounterFinalProject
{
    public partial class HomeFrm : Form
    {
        // Declare and constructor global variable in class to use DataBaseProcess
        Classes.DataBaseProcess dtBase = new Classes.DataBaseProcess();
        public HomeFrm()
        {
            InitializeComponent();
            CenterToScreen();
        }

        // add new item 
        private async void BtnAddNewClick(object sender, EventArgs e)
        {
            Boolean childViewClosed = false;
            if (sender.Equals(btnAddNewItem))
            {
                var childView = new AddEditItemFrm();
                childView.FormClosed += (s, ev) => {
                    childViewClosed = true;
                };
                childView.Show();

                while (!childViewClosed)
                {
                    Application.DoEvents();
                }

                DisplayItems();
            }
        }

        private void TblBillCellClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.RowIndex >= 0 && e.ColumnIndex == tblBill.Columns["outFile"].Index)
            {
                DataGridViewRow row = tblBill.Rows[e.RowIndex];
                string Bill_Id = row.Cells["Bill_ID"].Value.ToString();             //ma hd
                string CusName = row.Cells["FullNameBill"].Value.ToString();             //ten kh
                string staffName = row.Cells["StaffName"].Value.ToString();           //ten nv
                string CreatedTime = row.Cells["CreateTimeBill"].Value.ToString();         //thoi gian tao
                string numberItems = row.Cells["TotalItem"].Value.ToString();         //so luong hang
                string a = row.Cells["SubTotal"].Value.ToString();                   //null
                string KM = row.Cells["TotalDiscountAmount"].Value.ToString();                  //km
                string totoalPrice = row.Cells["TotalAmount"].Value.ToString();         //tong tien
                string status = row.Cells["Status"].Value.ToString();              //trang thai
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                Excel.Application exApp = new Excel.Application();
                Excel.Workbook exBook = exApp.Workbooks.Add(Excel.XlWBATemplate.xlWBATWorksheet);
                Excel.Worksheet exSheet = (Excel.Worksheet)exBook.Worksheets[1];
                Excel.Range tenTruong = (Excel.Range)exSheet.Cells[1, 1]; //Đưa con trỏ vào ô A1
                tenTruong.Range["A1:D1"].MergeCells = true;
                tenTruong.Range["A1"].Value = "CỬA HÀNG TẠP HÓA VĂN HẢI";
                tenTruong.Range["A2"].Value = "Địa chỉ: số 3 - Cầu Giấy - Hà Nội";
                tenTruong.Range["A3"].Value = "Điện thoại: 0329990540";
                tenTruong.Range["c5:f5"].MergeCells = true;
                tenTruong.Range["C5:F5"].Font.Size = 18;
                tenTruong.Range["C5:F5"].Font.Color = System.Drawing.Color.Red;
                tenTruong.Range["C5"].Value = "HÓA ĐƠN BÁN";
                tenTruong.Range["A7"].Value = "Mã HĐ: " + Bill_Id;
                tenTruong.Range["A8"].Value = "Khách hàng: " + CusName;
                tenTruong.Range["A9"].Value = "Nhân viên: " + staffName;
                tenTruong.Range["A10"].Value = "Thời gian tạo: " + CreatedTime;
                tenTruong.Range["A11"].Value = "Số lượng sản phẩm: " + numberItems;
                tenTruong.Range["A12"].Value = "Khuyến mãi: " + KM;
                tenTruong.Range["A13"].Value = "Thành tiền: " + totoalPrice;
                tenTruong.Range["A14"].Value = "Trạng thái: " + status;

                exSheet.Name = "HoaDonBan";
                exBook.Activate();
                if (saveFileDialog.ShowDialog() == DialogResult.OK)
                    exBook.SaveAs(saveFileDialog.FileName.ToString());
                exApp.Quit();
            }
        }

        // update, delete discount
        private void TblDiscountCellClick(object sender, DataGridViewCellEventArgs e)
        {
            Boolean childViewClosed = false;
            if (e.RowIndex >= 0 && e.ColumnIndex == tblDiscount.Columns["tblDiscountEdit"].Index)
            {
                DataGridViewRow row = tblDiscount.Rows[e.RowIndex];
                string discount_ID = row.Cells["Discount_ID"].Value.ToString();
                string name = row.Cells["NameDiscount"].Value.ToString();
                DateTime startTime = DateTime.Parse(row.Cells["StartTime"].Value.ToString());
                DateTime endTime = DateTime.Parse(row.Cells["EndTime"].Value.ToString());
                string type = row.Cells["DiscountType"].Value.ToString();
                int percent = int.Parse(row.Cells["DiscountPercent"].Value.ToString());
                int priceAmount = int.Parse(row.Cells["DiscountPriceAmount"].Value.ToString());
                int minPrice = int.Parse(row.Cells["MinPriceToUseDiscount"].Value.ToString());

                var childView = new AddEditDiscountFrm("Cập Nhật", discount_ID, name, startTime, endTime, type, percent, priceAmount, minPrice);
                childView.FormClosed += (s, ev) => {
                    childViewClosed = true;
                };
                childView.Show();
                while (!childViewClosed)
                {
                    Application.DoEvents();
                }
                DisplayItems();
            }
            else if (e.RowIndex >= 0 && e.ColumnIndex == tblDiscount.Columns["tblDiscountRemove"].Index)
            {
                var title = "Xác nhận xóa";
                var msg = "Bạn có chắc chắn muốn xóa bản ghi này hay không?";
                var ans = ShowComfirmDialog(msg, title);
                DataGridViewRow row = tblDiscount.Rows[e.RowIndex];
                string discount_ID = row.Cells["Discount_ID"].Value.ToString();
                if (ans == DialogResult.Yes)
                {
                    string sql = "";
                    sql = "DELETE FROM Discount WHERE Discount_ID = N'" + discount_ID + "'";
                    dtBase.DataChange(sql);
                    MessageBox.Show("Xóa thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                DisplayItems();
            }
        }

        // update, delete customer
        private void TblCustomerCellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0 && e.ColumnIndex == tblCustomer.Columns["tblCustomerEdit"].Index)
            {
                DataGridViewRow row = tblCustomer.Rows[e.RowIndex];
                string customer_ID = row.Cells["Customer_ID"].Value.ToString();
                string fullName = row.Cells["FullName"].Value.ToString();
                DateTime birthDate = DateTime.Parse(row.Cells["BirthDate"].Value.ToString());
                string address = row.Cells["Address"].Value.ToString();
                string phone = row.Cells["PhoneNumber"].Value.ToString();
                string customerType = row.Cells["CustomerType"].Value.ToString();
                int point = int.Parse(row.Cells["Point"].Value.ToString());
                DateTime createTime = DateTime.Parse(row.Cells["CreateTime"].Value.ToString());
                string email = row.Cells["Email"].Value.ToString();

                var childView = new AddEditCustomerFrm("Cập Nhật", customer_ID, fullName, birthDate, address, phone, customerType, point, createTime, email);
                childView.Show();
            }
            else if (e.RowIndex >= 0 && e.ColumnIndex == tblCustomer.Columns["tblCustomerRemove"].Index)
            {
                var title = "Xác nhận xóa";
                var msg = "Bạn có chắc chắn muốn xóa bản ghi này hay không?";
                var ans = ShowComfirmDialog(msg, title);
                DataGridViewRow row = tblCustomer.Rows[e.RowIndex];
                string customer_ID = row.Cells["Customer_ID"].Value.ToString();
                if (ans == DialogResult.Yes)
                {
                    string sql = "";
                    sql = "DELETE FROM Customer WHERE Customer_ID = N'" + customer_ID + "'";
                    dtBase.DataChange(sql);
                    MessageBox.Show("Xóa thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }

        }

        // update, delete item
        private void TblItemCellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0 && e.ColumnIndex == tblItem.Columns["tblItemEdit"].Index)
            {
                DataGridViewRow row = tblItem.Rows[e.RowIndex];
                int item_ID = int.Parse(row.Cells["Item_ID"].Value.ToString());
                string itemName = row.Cells["ItemName"].Value.ToString();
                string itemType = row.Cells["ItemType"].Value.ToString();
                int quantity = int.Parse(row.Cells["Quantity"].Value.ToString());
                string brand = row.Cells["Brand"].Value.ToString();
                DateTime releaseDate = DateTime.Parse(row.Cells["ReleaseDate"].Value.ToString());
                int price = int.Parse(row.Cells["Price"].Value.ToString());
                string discount = row.Cells["Name"].Value.ToString();
                string image = row.Cells["Image"].Value.ToString();

                var childView = new AddEditItemFrm("Cập Nhật", item_ID, itemName, itemType, quantity, brand, releaseDate, price, discount, image);
                childView.Show();
            }
            else if (e.RowIndex >= 0 && e.ColumnIndex == tblItem.Columns["tblItemRemove"].Index)
            {
                var title = "Xác nhận xóa";
                var msg = "Bạn có chắc chắn muốn xóa bản ghi này hay không?";
                var ans = ShowComfirmDialog(msg, title);
                DataGridViewRow row = tblItem.Rows[e.RowIndex];
                int item_ID = int.Parse(row.Cells["Item_ID"].Value.ToString());
                if (ans == DialogResult.Yes)
                {
                    string sql = "";
                    sql = "DELETE FROM Item WHERE Item_ID = N'" + item_ID + "'";
                    dtBase.DataChange(sql);
                    MessageBox.Show("Xóa thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        private DialogResult ShowComfirmDialog(string msg, string title)
        {
            return MessageBox.Show(msg, title, MessageBoxButtons.YesNo, MessageBoxIcon.Question);
        }



        // sort item
        private void SortItemHandler(object sender, EventArgs e)
        {
            if (radioSortItemByPriceASC.Checked)
            {
                tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                                                       "ORDER BY Price");
            }
            else if (radioSortItemByPriceDESC.Checked)
            {
                tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                                                       "ORDER BY Price DESC");
            }
            else if (radioSortItemByQuantity.Checked)
            {
                tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                                                       "ORDER BY Quantity DESC");
            }
            else if (radioSortItemByProductDate.Checked)
            {
                tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                                                       "ORDER BY item.ReleaseDate");
            }
            else if (radioSortItemByName.Checked)
            {
                tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                                                       "ORDER BY ItemName");
            }
        }

        private void ComboSearchItemSelectefIndexChanged(object sender, EventArgs e)
        {
            switch (comboSearchItem.SelectedIndex)
            {
                case 0:
                case 2:
                case 3:
                    txtSearchItem.Enabled = true;
                    numericItemFrom.Enabled = false;
                    numericItemTo.Enabled = false;
                    break;
                case 1:
                case 4:
                    txtSearchItem.Enabled = false;
                    numericItemFrom.Enabled = true;
                    numericItemTo.Enabled = true;
                    break;
                default:
                    break;
            }



        }


        // search stat
        private void BtnSearchStatClick(object sender, EventArgs e)
        {
            //dtpStart.Enabled = false;
            //dtpEnd.Enabled = false;
            //nudStat.Enabled = false;
            if (comboStat.SelectedIndex == -1)
            {
                var msg = "Vui lòng chọn tiêu chí tìm kiếm để tiếp tục";
                var title = "Lỗi dữ liệu";
                MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (comboStat.SelectedIndex == 0) //  Các mặt hàng có danh thu tốt nhất
            {
                string sql = "select it.Item_ID, it.ItemName, inven.Inven_sold_quantity, inven.Inven_sold_revenue  " +
                             "from [dbo].[Item] as it " +
                             "join [dbo].[Inventory] as inven on inven.Item_ID = it.Item_ID " +
                             "order by inven.Inven_sold_revenue desc";
                tblStatItem.DataSource = dtBase.DataReader(sql);
            }
            else if (comboStat.SelectedIndex == 1) // Các khách hàng mua nhiều hàng nhất
            {
                string sql = "select cus.Customer_ID, cus.FullName, count(*) as times, sum(b.TotalItem) as quantity,sum(b.TotalAmount) as total " +
                             "from (([dbo].[Bill] as b " +
                             "join [dbo].[Cart] as c on c.Cart_ID = b.Cart_ID) " +
                             "join [dbo].[Customer] as cus on cus.Customer_ID = c.Customer_ID) " +
                             "group by cus.Customer_ID, cus.FullName " +
                             "order by quantity desc";
                tblStatCustomer.DataSource = dtBase.DataReader(sql);
            }
            else if (comboStat.SelectedIndex == 2) // Những ngày của tháng bán được nhiều hàng nhất
            {

                tbl_month_bestsold.Columns["Month_bestsold"].DataPropertyName = "CreateTime";
                var month = nudMonth.Value;
                string sql = "SELECT top 1 with ties b.CreateTime " +
                             "from [dbo].[Bill] as b " +
                             "where month(b.CreateTime) = " + month + " order by b.TotalAmount desc";
                tbl_month_bestsold.DataSource = dtBase.DataReader(sql);
            }
            else if (comboStat.SelectedIndex == 3) // Danh thu theo tháng của năm cho trước
            {
                tbl_revenue_month.Columns["revenue_month"].DataPropertyName = "revenue_month";
                var year = nudYear.Value;
                var month = nudMonth.Value;
                string sql = "select isnull(sum(b.TotalAmount), 0) as revenue_month " +
                             "from [dbo].[Bill] as b " +
                             "where month(b.CreateTime) = " + month + " and year(b.CreateTime) = " + year;
                tbl_revenue_month.DataSource = dtBase.DataReader(sql);
            }
            else if (comboStat.SelectedIndex == 4) // Danh thu theo ngày của tháng cho trước
            {
                tbl_revenue_month.Columns["revenue_month"].DataPropertyName = "revenue_month";
                var day = nudDay.Value;
                var month = nudMonth.Value;
                string sql = "select isnull(sum(b.TotalAmount), 0) as revenue_month " +
                             "from [dbo].[Bill] as b " +
                             "where month(b.CreateTime) = " + month + " and day(b.CreateTime) = " + day;
                tbl_revenue_month.DataSource = dtBase.DataReader(sql);
            }
        }
        // search bill by customer's choice
        private void BtnSearchBillClick(object sender, EventArgs e)
        {
            if (comboSearchBill.SelectedIndex == -1)
            {
                var msg = "Vui lòng chọn tiêu chí tìm kiếm để tiếp tục";
                var title = "Lỗi dữ liệu";
                MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (comboSearchBill.SelectedIndex == 0) //  Tìm theo số lượng hàng
            {
                var name = txtSearchBill.Text;
                string sql = "SELECT b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal,  " +
                             "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                             "FROM (([dbo].[Cart] AS c " +
                             "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                             "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                             "WHERE b.TotalItem LIKE (N'%" + name + "%')";
                tblBill.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchBill.SelectedIndex == 1) // Tìm theo tên khách hàng.
            {
                var name = txtSearchBill.Text;
                string sql = "SELECT b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal,  " +
                             "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                             "FROM (([dbo].[Cart] AS c " +
                             "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                             "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                             "WHERE cus.FullName LIKE (N'%" + name + "%')";
                tblBill.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchBill.SelectedIndex == 2) // Tìm theo trạng thái hóa đơn.
            {
                var name = txtSearchBill.Text;
                string sql = "SELECT b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal,  " +
                             "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                             "FROM (([dbo].[Cart] AS c " +
                             "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                             "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                             "WHERE b.Status LIKE (N'%" + name + "%')";
                tblBill.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchBill.SelectedIndex == 3) // Tìm theo tên nhân viên
            {
                var name = txtSearchBill.Text;
                string sql = "SELECT b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal,  " +
                             "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                             "FROM (([dbo].[Cart] AS c " +
                             "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                             "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                             "WHERE b.StaffName LIKE (N'%" + name + "%')";
                tblBill.DataSource = dtBase.DataReader(sql);
            }
        }

        // search discount by customer's choice
        private void BtnSearchDiscountClick(object sender, EventArgs e)
        {
            if (comboSearchDiscount.SelectedIndex == -1)
            {
                var msg = "Vui lòng chọn tiêu chí tìm kiếm để tiếp tục";
                var title = "Lỗi dữ liệu";
                MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (comboSearchDiscount.SelectedIndex == 0) // Tên khuyến mãi gần đúng
            {
                var name = txtSearchDiscount.Text;
                string sql = "SELECT d.Discount_ID ,d.Name, d.StartTime, d.EndTime, d.DiscountType, d.DiscountPercent, d.DiscountPriceAmount " +
                                    "FROM Discount as d " +
                                    "WHERE d.Name LIKE (N'%" + name + "%')";
                tblDiscount.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchDiscount.SelectedIndex == 1) // Mã khuyến mãi
            {
                var name = txtSearchDiscount.Text;
                string sql = "SELECT d.Discount_ID ,d.Name, d.StartTime, d.EndTime, d.DiscountType, d.DiscountPercent, d.DiscountPriceAmount " +
                                    "FROM Discount as d " +
                                    "WHERE d.Discount_ID LIKE (N'%" + name + "%')";
                tblDiscount.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchDiscount.SelectedIndex == 2) // Loại khuyến mãi
            {
                var name = txtSearchDiscount.Text;
                string sql = "SELECT d.Discount_ID ,d.Name, d.StartTime, d.EndTime, d.DiscountType, d.DiscountPercent, d.DiscountPriceAmount " +
                                    "FROM Discount as d " +
                                    "WHERE d.DiscountType LIKE (N'%" + name + "%')";
                tblDiscount.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchDiscount.SelectedIndex == 3) // Số tiền KM
            {
                var name = txtSearchDiscount.Text;
                string sql = "SELECT d.Discount_ID ,d.Name, d.StartTime, d.EndTime, d.DiscountType, d.DiscountPercent, d.DiscountPriceAmount " +
                                    "FROM Discount as d " +
                                    "WHERE d.DiscountPriceAmount LIKE (N'%" + name + "%')";
                tblDiscount.DataSource = dtBase.DataReader(sql);
            }
        }

        // search customer by customer's choice
        private void BtnSearchCustomerClick(object sender, EventArgs e)
        {
            if (comboSearchCustomer.SelectedIndex == -1)
            {
                var msg = "Vui lòng chọn tiêu chí tìm kiếm để tiếp tục";
                var title = "Lỗi dữ liệu";
                MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (comboSearchCustomer.SelectedIndex == 0) // ten khach hang gan dung
            {
                var name = txtSearchCustomer.Text;
                string sql = "SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                    "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                    "FROM Customer AS customer " +
                                    "WHERE customer.FullName LIKE (N'%" + name + "%')" +
                                    " and Email not in (select Email from [dbo].[Customer] where Email = N'admin')";
                tblCustomer.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchCustomer.SelectedIndex == 1) // ma khach hang
            {
                var name = txtSearchCustomer.Text;
                string sql = "SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                    "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                    "FROM Customer AS customer " +
                                    "WHERE customer.Customer_ID LIKE (N'%" + name + "%')" +
                                    " and Email not in (select Email from [dbo].[Customer] where Email = N'admin')";
                tblCustomer.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchCustomer.SelectedIndex == 2) // loai khach hang
            {
                var name = txtSearchCustomer.Text;
                string sql = "SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                    "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                    "FROM Customer AS customer " +
                                    "WHERE customer.CustomerType LIKE (N'%" + name + "%')" +
                                    " and Email not in (select Email from [dbo].[Customer] where Email = N'admin')";
                tblCustomer.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchCustomer.SelectedIndex == 3) // dia chi
            {
                var name = txtSearchCustomer.Text;
                string sql = "SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                    "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                    "FROM Customer AS customer " +
                                    "WHERE customer.Address LIKE (N'%" + name + "%')" +
                                    " and Email not in (select Email from [dbo].[Customer] where Email = N'admin')";
                tblCustomer.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchCustomer.SelectedIndex == 4) // so dien thoai
            {
                var name = txtSearchCustomer.Text;
                string sql = "SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                    "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                    "FROM Customer AS customer " +
                                    "WHERE customer.PhoneNumber LIKE (N'%" + name + "%')" +
                                    " and Email not in (select Email from [dbo].[Customer] where Email = N'admin')";
                tblCustomer.DataSource = dtBase.DataReader(sql);
            }
        }


        // search item by customer's choice
        private void BtnSearchItemClick(object sender, EventArgs e)
        {
            if (comboSearchItem.SelectedIndex == -1)
            {
                var msg = "Vui lòng chọn tiêu chí tìm kiếm để tiếp tục";
                var title = "Lỗi dữ liệu";
                MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else if (comboSearchItem.SelectedIndex == 0)
            {
                var name = txtSearchItem.Text;
                string sql = "SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                             "FROM Item AS item " +
                             "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                             "WHERE item.ItemName LIKE (N'%" + name + "%')";

                tblItem.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchItem.SelectedIndex == 1)
            {
                int from = (int)numericItemFrom.Value;
                int to = (int)numericItemTo.Value;
                if (from > to)
                {
                    MessageBox.Show($"{from} không nhỏ hơn {to}", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                string sql = "SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                             "FROM Item AS item " +
                             "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                             "WHERE item.Price BETWEEN " + from + " AND " + to;

                tblItem.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchItem.SelectedIndex == 2) // loai mat hang
            {
                var name = txtSearchItem.Text;
                string sql = "SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                             "FROM Item AS item " +
                             "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                             "WHERE item.ItemType LIKE (N'%" + name + "%')";

                tblItem.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchItem.SelectedIndex == 3) // hang
            {
                var name = txtSearchItem.Text;
                string sql = "SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                             "FROM Item AS item " +
                             "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                             "WHERE item.Brand LIKE (N'%" + name + "%')";

                tblItem.DataSource = dtBase.DataReader(sql);
            }
            else if (comboSearchItem.SelectedIndex == 4)
            {
                int from = (int)numericItemFrom.Value;
                int to = (int)numericItemTo.Value;
                if (from > to)
                {
                    MessageBox.Show($"{from} không nhỏ hơn {to}", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                string sql = "SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name " +
                             "FROM Item AS item " +
                             "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID " +
                             "WHERE item.Quantity BETWEEN " + from + " AND " + to;

                tblItem.DataSource = dtBase.DataReader(sql);
            }
        }

        // refresh button
        private void BtnRefreshClick(object sender, EventArgs e)
        {
            if (sender.Equals(btnFreshItem))
            {
                //tblItem.Clear();
                comboSearchItem.SelectedIndex = -1;
                numericItemFrom.Value = 0;
                numericItemTo.Value = 0;
                txtSearchItem.Text = "";
                //display items again
                DisplayItems();
            }
            else if (sender.Equals(btnRefreshCustomer))
            {
                comboSearchCustomer.SelectedIndex = -1;
                txtSearchCustomer.Text = "";
                //display items again
                DisplayCustomers();
            }
            else if (sender.Equals(btnRefreshDiscount))
            {
                comboSearchDiscount.SelectedIndex = -1;
                txtSearchDiscount.Text = "";
                //display discount again
                DisplayDiscount();
            }
            else if (sender.Equals(btnRefreshBill))
            {
                txtSearchBill.Text = "";
                comboSearchBill.SelectedIndex = -1;
                //display bill again
                DisplayBill();
            }
        }

        // sort customer
        private void RadioSortCustomerCheckedChanged(object sender, EventArgs e)
        {

            if (radioSortCustomerByName.Checked)
            {
                tblCustomer.DataSource = dtBase.DataReader("SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                                       "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                                       "FROM Customer AS customer " +
                                                       "where customer.Email not in (select Email from [dbo].[Customer] where Email = N'admin') " +
                                                       "ORDER BY customer.Fullname");
            }
            else if (radioSortCustomerById.Checked)
            {
                tblCustomer.DataSource = dtBase.DataReader("SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                                       "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                                       "FROM Customer AS customer " +
                                                       "where customer.Email not in (select Email from [dbo].[Customer] where Email = N'admin') " +
                                                       "ORDER BY customer.Customer_ID");
            }
            else if (radioSortCustomerByPoint.Checked)
            {
                tblCustomer.DataSource = dtBase.DataReader("SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                                       "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                                       "FROM Customer AS customer " +
                                                       "where customer.Email not in (select Email from [dbo].[Customer] where Email = N'admin') " +
                                                       "ORDER BY customer.Point");
            }
            else if (radioSortCustomerByCreatedDate.Checked)
            {
                tblCustomer.DataSource = dtBase.DataReader("SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                                       "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                                       "FROM Customer AS customer " +
                                                       "where customer.Email not in (select Email from [dbo].[Customer] where Email = N'admin') " +
                                                       "ORDER BY customer.CreateTime");
            }
            else if (radioSortCustomerByBirthDate.Checked)
            {
                tblCustomer.DataSource = dtBase.DataReader("SELECT customer.Customer_ID, customer.FullName, customer.BirthDate, customer.Address," +
                                                       "customer.PhoneNumber, customer.CustomerType, customer.Point, customer.CreateTime, customer.Email " +
                                                       "FROM Customer AS customer " +
                                                       "where customer.Email not in (select Email from [dbo].[Customer] where Email = N'admin') " +
                                                       "ORDER BY customer.BirthDate");
            }
        }
        // display add or edit customer
        private void BtnAddNewCustomerClick(object sender, EventArgs e)
        {
            var childView = new AddEditCustomerFrm();
            childView.Show();
        }

        // display discount
        private void BtnAddNewDiscountClick(object sender, EventArgs e)
        {
            var childView = new AddEditDiscountFrm();
            childView.Show();
        }

        // display bill 
        private void BtnAddNewBillClick(object sender, EventArgs e)
        {
            var createdBillView = new AddEditBillFrm();
            createdBillView.Show();
        }

        // load form
        private void HomeFrm_Load(object sender, EventArgs e)
        {
            // Display Item
            DisplayItems();
            // Display Customer
            DisplayCustomers();
            // Display Discount
            DisplayDiscount();

            // Display Bill
            DisplayBill();

            // Display stat item
            DisplayStatItem();

            // Display stat customer
            DisplayStatCustomer();
        }
        private void DisplayCustomers()
        {
            tblCustomer.Columns["Customer_ID"].DataPropertyName = "Customer_ID";
            tblCustomer.Columns["FullName"].DataPropertyName = "FullName";
            tblCustomer.Columns["BirthDate"].DataPropertyName = "BirthDate";
            tblCustomer.Columns["Address"].DataPropertyName = "Address";
            tblCustomer.Columns["PhoneNumber"].DataPropertyName = "PhoneNumber";
            tblCustomer.Columns["CustomerType"].DataPropertyName = "CustomerType";
            tblCustomer.Columns["Point"].DataPropertyName = "Point";
            tblCustomer.Columns["CreateTime"].DataPropertyName = "CreateTime";
            tblCustomer.Columns["Email"].DataPropertyName = "Email";
            // Display customer
            tblCustomer.DataSource = dtBase.DataReader("SELECT Customer_ID, FullName, BirthDate, Address, PhoneNumber, CustomerType, Point, CreateTime, Email " +
                                                       "FROM Customer " +
                                                       "where Email not in (select Email from [dbo].[Customer] where Email = N'admin')");
        }

        private void DisplayItems()
        {
            tblItem.Columns["Item_ID"].DataPropertyName = "Item_ID";
            tblItem.Columns["ItemName"].DataPropertyName = "ItemName";
            tblItem.Columns["ItemType"].DataPropertyName = "ItemType";
            tblItem.Columns["Quantity"].DataPropertyName = "Quantity";
            tblItem.Columns["Brand"].DataPropertyName = "Brand";
            tblItem.Columns["ReleaseDate"].DataPropertyName = "ReleaseDate";
            tblItem.Columns["Price"].DataPropertyName = "Price";
            tblItem.Columns["Name"].DataPropertyName = "Name";
            tblItem.Columns["Image"].DataPropertyName = "Image";
            // Display customer
            tblItem.DataSource = dtBase.DataReader("SELECT item.Item_ID, item.ItemName, item.ItemType, item.Quantity, item.Brand, item.ReleaseDate, item.Price, discount.Name, item.Image " +
                                                       "FROM Item AS item " +
                                                       "JOIN Discount AS discount ON item.Discount_ID = discount.Discount_ID");
        }

        private void DisplayDiscount()
        {
            tblDiscount.Columns["Discount_ID"].DataPropertyName = "Discount_ID";
            tblDiscount.Columns["NameDiscount"].DataPropertyName = "Name";
            tblDiscount.Columns["StartTime"].DataPropertyName = "StartTime";
            tblDiscount.Columns["EndTime"].DataPropertyName = "EndTime";
            tblDiscount.Columns["DiscountType"].DataPropertyName = "DiscountType";
            tblDiscount.Columns["DiscountPercent"].DataPropertyName = "DiscountPercent";
            tblDiscount.Columns["DiscountPriceAmount"].DataPropertyName = "DiscountPriceAmount";
            tblDiscount.Columns["MinPriceToUseDiscount"].DataPropertyName = "MinPriceToUseDiscount";
            // Display discount
            tblDiscount.DataSource = dtBase.DataReader("SELECT d.Discount_ID, d.Name, d.StartTime, d.EndTime, d.DiscountType, " +
                                                       "d.DiscountPercent, d.DiscountPriceAmount, d.MinPriceToUseDiscount " +
                                                       "FROM Discount AS d ");
        }

        ///////////////////////////////////////////////////////////////////////////////////
        /// phan nay lien quan toi hoa don

        // display bill
        private void DisplayBill()
        {
            tblBill.Columns["Bill_ID"].DataPropertyName = "Bill_ID";
            tblBill.Columns["FullNameBill"].DataPropertyName = "FullName";
            tblBill.Columns["StaffName"].DataPropertyName = "StaffName";
            tblBill.Columns["CreateTimeBill"].DataPropertyName = "CreateTime";
            tblBill.Columns["TotalItem"].DataPropertyName = "TotalItem";
            tblBill.Columns["SubTotal"].DataPropertyName = "SubTotal";
            tblBill.Columns["TotalDiscountAmount"].DataPropertyName = "TotalDiscountAmount";
            tblBill.Columns["TotalAmount"].DataPropertyName = "TotalAmount";
            tblBill.Columns["Status"].DataPropertyName = "Status";
            // Display bill
            tblBill.DataSource = dtBase.DataReader("SELECT top 18 b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal, " +
                                                   "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                                                   "FROM (([dbo].[Cart] AS c " +
                                                   "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                                                   "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                                                   "where day(b.CreateTime) = day(GETDATE()) and month(b.CreateTime) = month(GETDATE()) and year(b.CreateTime) = year(GETDATE())" +
                                                   "ORDER BY b.CreateTime DESC");
        }

        // display stat
        private void DisplayStatItem()
        {
            tblStatItem.Columns["inven_id"].DataPropertyName = "Item_ID";
            tblStatItem.Columns["inven_name"].DataPropertyName = "ItemName";
            tblStatItem.Columns["inven_quantity"].DataPropertyName = "Inven_sold_quantity";
            tblStatItem.Columns["inven_revenue"].DataPropertyName = "Inven_sold_revenue";

            tblStatItem.DataSource = dtBase.DataReader("select it.Item_ID , it.ItemName, inven.Inven_sold_quantity, inven.Inven_sold_revenue " +
                                                   "from [dbo].[Inventory] as inven " +
                                                   "join [dbo].[Item] as it on it.Item_ID = inven.Item_ID");
        }

        private void DisplayStatCustomer()
        {
            tblStatCustomer.Columns["stat_customer_Id"].DataPropertyName = "Customer_ID";
            tblStatCustomer.Columns["stat_customer_name"].DataPropertyName = "FullName";
            tblStatCustomer.Columns["stat_customer_times"].DataPropertyName = "times";
            tblStatCustomer.Columns["stat_customer_quantity"].DataPropertyName = "quantity";
            tblStatCustomer.Columns["stat_customer_total"].DataPropertyName = "total";

            tblStatCustomer.DataSource = dtBase.DataReader("select cus.Customer_ID, cus.FullName, count(*) as times, sum(b.TotalItem) as quantity, sum(b.TotalAmount) as total " +
                                                   "from (([dbo].[Bill] as b " +
                                                   "join [dbo].[Cart] as c on c.Cart_ID = b.Cart_ID) " +
                                                   "join [dbo].[Customer] as cus on cus.Customer_ID = c.Customer_ID) " +
                                                   "group by cus.Customer_ID, cus.FullName");
        }


        // menutrip
        private void MenuItemViewTabClick(object sender, EventArgs e)
        {
            if (sender.Equals(mItemTab))
            {
                tabControl1.SelectedIndex = 0;
            }
            else if (sender.Equals(mCustomerTab))
            {

                tabControl1.SelectedIndex = 1;
            }
            else if (sender.Equals(mDiscountTab))
            {

                tabControl1.SelectedIndex = 2;
            }
            else if (sender.Equals(mBillTab))
            {

                tabControl1.SelectedIndex = 3;
            }
        }

        private void MenuAddView(object sender, EventArgs e)
        {
            if (sender.Equals(mAddItem))
            {
                tabControl1.SelectedIndex = 0;
                var children = new AddEditItemFrm();
                children.Show();
            }
            else if (sender.Equals(mAddCustomer))
            {

                tabControl1.SelectedIndex = 1;
                var children = new AddEditCustomerFrm();
                children.Show();
            }
            else if (sender.Equals(mAddDiscount))
            {
                tabControl1.SelectedIndex = 2;
                var children = new AddEditDiscountFrm();
                children.Show();
            }
            else if (sender.Equals(mAddBill))
            {
                tabControl1.SelectedIndex = 3;
                var children = new AddEditBillFrm();
                children.Show();
            }
        }

        // close app
        private void BtnCloseApp(object sender, EventArgs e)
        {
            Close();
        }

        // chart
        private void BtnCreateChartColumnClick(object sender, EventArgs e)
        {
            ChartTable child = new ChartTable(tblStatItem, tblStatCustomer);
            child.Show();
        }
        private void BtnCreateChartPieClick(object sender, EventArgs e)
        {
            ChartPie child = new ChartPie(tblStatItem, tblStatCustomer);
            child.Show();
        }

        // xuat hoa don
        private void BtnSaveExcel(object sender, EventArgs e)
        {
            Excel.Application exApp = new Excel.Application();
            Excel.Workbook exBook = exApp.Workbooks.Add(Excel.XlWBATemplate.xlWBATWorksheet);
            Excel.Worksheet exSheet = (Excel.Worksheet)(Excel.Range)exBook.Worksheets[1];
            Excel.Range exRange = (Excel.Range)exSheet.Cells[1, 1];

            exRange.Font.Size = 15;
            exRange.Font.Bold = true;
            exRange.Font.Color = Color.Blue;
            exRange.Value = "CỬA HẢNG TẠP HÓA HÒA BÌNH";

            Excel.Range dc = (Excel.Range)exSheet.Cells[2, 1];
            dc.Value = "Số 14 - Huỳnh Thúc Kháng - Đống Đa - Hà Nội";

            exSheet.Range["D4"].Font.Size = 20;
            exRange.Font.Bold = true;
            exRange.Font.Color = Color.Red;
            exRange.Value = "HÓA ĐƠN BÁN";
        }
        private void btnInHD_Click(object sender, EventArgs e)
        {
            Excel.Application excelApp = new Excel.Application();
            Excel.Workbook workbook = excelApp.Workbooks.Add();
            Excel.Worksheet worksheet = (Excel.Worksheet)workbook.Worksheets[1];

            // Bắt đầu từ dòng 1, cột 1 (A1)
            int row = 1;
            int col = 1;

            // Ghi dữ liệu từ DataGridView (hoặc bất kỳ nguồn dữ liệu nào) vào Excel
            foreach (DataGridViewRow dgvRow in tblBill.Rows)
            {
                col = 1;
                foreach (DataGridViewCell cell in dgvRow.Cells)
                {
                    if (cell.Value != null)
                    {
                        worksheet.Cells[row, col] = cell.Value.ToString();
                    }
                    col++;
                }
                row++;
            }

            // Lưu tệp Excel
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "Excel Files|*.xlsx";
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                workbook.SaveAs(saveFileDialog.FileName);
                excelApp.Quit();
            }
        }

        private void btnInHDClick(object sender, EventArgs e)
        {
            SaveFileDialog file = new SaveFileDialog();
            Excel.Application exApp = new Excel.Application();
            Excel.Workbook exBook = exApp.Workbooks.Add(Excel.XlWBATemplate.xlWBATWorksheet);
            Excel.Worksheet exSheet = (Excel.Worksheet)exBook.Worksheets[1];
            Excel.Range tenTruong = (Excel.Range)exSheet.Cells[1, 1]; //Đưa con trỏ vào ô A1
            //Đưa dữ liệu vào file Excel
            tenTruong.Range["A1:D1"].MergeCells = true;
            tenTruong.Range["A1"].Value = "CỬA HÀNG TẠP HÓA VĂN HẢI";
            tenTruong.Range["A1"].ColumnWidth = 20;
            tenTruong.Range["A2"].Value = "Địa chỉ: số 3 - Cầu Giấy - Hà Nội";
            tenTruong.Range["A3"].Value = "Điện thoại: 0329990540";
            tenTruong.Range["c5:f5"].MergeCells = true;
            tenTruong.Range["C5:F5"].Font.Size = 18;
            tenTruong.Range["C5:F5"].Font.Color = System.Drawing.Color.Red;
            tenTruong.Range["C5"].Value = "HÓA ĐƠN BÁN";

            tenTruong.Range["D10"].ColumnWidth = 20;
            tenTruong.Range["A10"].ColumnWidth = 18;
            tenTruong.Range["B10"].ColumnWidth = 18;
            tenTruong.Range["C10"].ColumnWidth = 20;
            tenTruong.Range["E10"].ColumnWidth = 14;
            tenTruong.Range["F10"].ColumnWidth = 14;
            tenTruong.Range["G10"].ColumnWidth = 17;
            tenTruong.Range["H10"].ColumnWidth = 18;
            tenTruong.Range["I10"].ColumnWidth = 18;

            tenTruong.Range["A10"].Value = " Mã hóa đơn ";
            tenTruong.Range["B10"].Value = " Tên khách hàng ";
            tenTruong.Range["C10"].Value = " Tên nhân viên ";
            tenTruong.Range["D10"].Value = " Thời gian tạo hóa đơn ";
            tenTruong.Range["E10"].Value = " Tổng SP ";
            tenTruong.Range["F10"].Value = " Tạm tính ";
            tenTruong.Range["G10"].Value = " Tổng khuyến mái ";
            tenTruong.Range["H10"].Value = " Tổng tiền ";
            tenTruong.Range["I10"].Value = " Trạng thái ";
            int hang = 10;

            DataTable tblChiTiet = dtBase.DataReader("SELECT b.Bill_ID, cus.FullName, b.StaffName, b.CreateTime, b.TotalItem, b.SubTotal, " +
                                                   "b.TotalDiscountAmount, b.TotalAmount, b.Status " +
                                                   "FROM (([dbo].[Cart] AS c " +
                                                   "JOIN [dbo].[Bill] AS b ON b.Cart_ID = c.Cart_ID) " +
                                                   "JOIN [dbo].[Customer] AS cus ON cus.Customer_ID = c.Customer_ID) " +
                                                   "where b.Status = N'Đã thanh toán'");
            float tongtien = 0;
            for (int i = 0; i < tblChiTiet.Rows.Count; i++)
            {
                hang++;
                tenTruong.Range["A" + hang.ToString()].Value = tblChiTiet.Rows[i]["Bill_ID"];
                tenTruong.Range["B" + hang.ToString()].Value = tblChiTiet.Rows[i]["FullName"];
                tenTruong.Range["C" + hang.ToString()].Value = tblChiTiet.Rows[i]["StaffName"];
                tenTruong.Range["D" + hang.ToString()].Value = ((DateTime)tblChiTiet.Rows[i]["CreateTime"]).ToString("yyyy-MM-dd HH:mm:ss");
                tenTruong.Range["E" + hang.ToString()].Value = tblChiTiet.Rows[i]["TotalItem"];
                tenTruong.Range["F" + hang.ToString()].Value = tblChiTiet.Rows[i]["SubTotal"];
                tenTruong.Range["G" + hang.ToString()].Value = tblChiTiet.Rows[i]["TotalDiscountAmount"];
                tenTruong.Range["H" + hang.ToString()].Value = tblChiTiet.Rows[i]["TotalAmount"];
                tenTruong.Range["I" + hang.ToString()].Value = tblChiTiet.Rows[i]["Status"];
                tongtien += tenTruong.Range["H" + hang.ToString()].Value;

            }
            tenTruong.Range["J10"].ColumnWidth = 20;
            tenTruong.Range["J10"].Font.Color =Color.Red;
            tenTruong.Range["J10"].Font.Size = 18;
            tenTruong.Range["J10"].Value = "Tổng tiền: " + tongtien;

            exSheet.Name = "HoaDonBan";
            exBook.Activate();
            if (file.ShowDialog() == DialogResult.OK)
                exBook.SaveAs(file.FileName.ToString());
            exApp.Quit();
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }
    }
}
