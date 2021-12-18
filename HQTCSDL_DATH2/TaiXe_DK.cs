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
    public partial class TaiXe_DK : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tableHD = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";

        void LoadDataTaiXe() {
            command = connection.CreateCommand();
        }
        public TaiXe_DK()
        {
            InitializeComponent();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "insert into TAIXE(CMND,HoTen,SDT,DiaChi,BienSoXe,Email,SoTaiKhoanNganHang,KhuVucDangKy)values(@CMND,@HoTen,@SDT,@DiaChi,@BienSoXe,@Email,@SoTaiKhoanNganHang,@KhuVucDangKy)";
            command.Parameters.AddWithValue("@CMND", textBox4.Text);
            command.Parameters.AddWithValue("@SDT", textBox2.Text);
            command.Parameters.AddWithValue("@DiaChi", textBox3.Text);
            command.Parameters.AddWithValue("@HoTen", textBox1.Text);
            command.Parameters.AddWithValue("@BienSoXe", textBox5.Text);
            command.Parameters.AddWithValue("@Email", textBox7.Text);
            command.Parameters.AddWithValue("@SoTaiKhoanNganHang", textBox6.Text);
            command.Parameters.AddWithValue("@KhuVucDangKy", comboBox1.Text);
            if (textBox1.Text == str || textBox2.Text == str || textBox3.Text == str || textBox4.Text == str || textBox5.Text == str || textBox6.Text == str || textBox7.Text == str || comboBox1.Text == str) {
                MessageBox.Show("Hãy điền đầy đủ thông tin");
            }
            else
            {
                try
                {
                    command.ExecuteNonQuery();
                    MessageBox.Show("Đăng Ký Thành Công!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Đăng ký không thành công");
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();    
            TaiXe taixe = new TaiXe();  
            taixe.ShowDialog();
            this.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            command.CommandText = "Select TaiXe.KhuVucDangKy from TaiXe";
        }
    }
}
