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
    public partial class DoiTac_ThemSP : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tableHD = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
        public DoiTac_ThemSP()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            DoiTac_QLSP QLSP = new DoiTac_QLSP();
            QLSP.ShowDialog();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "insert into SANPHAM(MaChiNhanh,MaDT,TenSanPham,DonGia)values(@MaChiNhanh,@MaDT,@TenSanPham,@DonGia)";
            command.Parameters.AddWithValue("@MaChiNhanh", tbmacn.Text);
            command.Parameters.AddWithValue("@MaDT", tbmadt.Text);
            command.Parameters.AddWithValue("@TenSanPham", tbtensp.Text);
            command.Parameters.AddWithValue("@DonGia", tbdongia.Text);
            if (tbmacn.Text == str || tbmadt.Text == str || tbtensp.Text == str || tbdongia.Text == str)
            {
                MessageBox.Show("Hãy điền đầy đủ thông tin");
            }
            else
            {
                try
                {
                    command.ExecuteNonQuery();
                    MessageBox.Show("Thêm Sản Phẩm Thành Công!");
                    this.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Thêm Sản Phẩm không thành công");
                }
            }
        }

        private void DoiTac_ThemSP_Load(object sender, EventArgs e)
        {

        }

        private void tbmacn_TextChanged(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void tbmadt_TextChanged(object sender, EventArgs e)
        {

        }

        private void tbtensp_TextChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void tbdongia_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
