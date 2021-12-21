using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace HQTCSDL_DATH2
{
    public partial class Admin_QL : Form
    {
        private Interface itf;
        private SqlConnection cnn;
        public Admin_QL(Interface itf, SqlConnection cnn)
        {
            this.cnn = cnn;
            this.itf = itf;
            InitializeComponent();
            this.Closing += Admin_QL_Closing; ;
            DisplayData();
            
        }

        private void Admin_QL_Closing(object sender, CancelEventArgs e)
        {
            this.itf.Show();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string HoTen = textBox1.Text;
            string ID = textBox2.Text;
            int ID1 = Int32.Parse(ID);
            string PassWord = textBox3.Text;
            string NgaySinh = textBox4.Text;

            SqlCommand sc = new SqlCommand("EXEC TaoTaiKhoan '" + HoTen + "'," + ID + ",'" + PassWord + "','" + NgaySinh + "'", cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Tạo tài khoản thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();
        }

        private void DisplayData()
        {
            cnn.Open();
            DataTable data = new DataTable();
            SqlDataAdapter adapt = new SqlDataAdapter("SELECT * FROM ADMINISTRATOR", cnn);
            adapt.Fill(data);
            dataGridView1.DataSource = data;
            cnn.Close();
        }

        private void ClearData()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string ID = textBox2.Text;
            int ID1 = Int32.Parse(ID);
            SqlCommand sc = new SqlCommand("EXEC KhoaTK " + ID1, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Khóa tài khoản thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string ID = textBox2.Text;
            int ID1 = Int32.Parse(ID);
            SqlCommand sc = new SqlCommand("EXEC MoTK " + ID1, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Mở tài khoản thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string ID = textBox2.Text;
            int ID1 = Int32.Parse(ID);
            SqlCommand sc = new SqlCommand("EXEC XoaTK " + ID1, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Xóa tài khoản thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();
        }
    }
}
