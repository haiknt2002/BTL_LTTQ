using CSharpCounterFinalProject.ViewCustomer;
using System;
using System.Data;
using System.Windows.Forms;

namespace CSharpCounterFinalProject.Sign
{
    public partial class SignIn : Form
    {
        // Declare and constructor global variable in class to use DataBaseProcess
        Classes.DataBaseProcess dtBase = new Classes.DataBaseProcess();

        string message = "";
        public SignIn()
        {
            InitializeComponent();
            CenterToScreen();
        }

        private void BtnHuyClick(object sender, EventArgs e)
        {
            Close();
        }

        private void BtnDangNhapCkick(object sender, EventArgs e)
        {
            string username = txtName.Text;
            string password = txtPassword.Text;
            if(!string.IsNullOrEmpty(this.message))
            {
                this.Message(message);
                message = "";
                return;
            }
            if(username == "admin" && password == "admin")
            {
                try
                {
                    string sql = "SELECT * FROM customer WHERE userName = N'" + username + "' AND passWord = N'" + password + "'";
                    dtBase.DataReader(sql);
                    MessageBox.Show("Đăng nhập thành công!");
                    var childView = new HomeFrm();
                    childView.Name = username;
                    childView.Show();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Thông tin đăng nhập sai!");
                }
            }else
            {
                DataTable dataTable = new DataTable();
                string sql = "SELECT * FROM customer WHERE userName = N'" + username + "' AND passWord = N'" + password + "'";
                dataTable = dtBase.DataReader(sql);
                if (dataTable.Rows.Count > 0)
                {
                    MessageBox.Show("Đăng nhập thành công!");
                    //var childView = new CustomerView(username, password);
                    var childView = new HomeCustomerView(username);
                    childView.Name = username;
                    childView.Show();
                }
                else
                {
                    MessageBox.Show("Thông tin đăng nhập sai!");
                    return;
                }
            }
        }

        private void BtnSignUpClick(object sender, EventArgs e)
        {
            var childView = new SignUp();
            childView.Show();
        }

        private void SignIn_Load(object sender, EventArgs e)
        {

        }

        private void txtName_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text))
            {
                this.message += "Tên đăng nhập không được để trống!\n";
            }
        }

        private void Message(string message)
        {
            MessageBox.Show(message);
        }

        private void txtPassword_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtPassword.Text))
            {
                this.message += "Mật khẩu không được để trống!\n";
            }
        }
    }
}
