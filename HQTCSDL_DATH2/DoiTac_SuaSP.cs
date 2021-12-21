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
    public partial class DoiTac_SuaSP : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbmaDT = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
        public DoiTac_SuaSP()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBoxMasp_TextChanged(object sender, EventArgs e)
        {


        }

        private void DoiTac_SuaSP_Load(object sender, EventArgs e)
        {
            try
            {
                connection = new SqlConnection(str);
                connection.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void button1_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "Update SANPHAM set TenSanPham=@TenSanPham, DonGia=@DonGia  where SANPHAM.MaSanPham = @MaSanPham";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@TenSanPham", textBoxtensp.Text);
            command.Parameters.AddWithValue("@DonGia", textBoxdg.Text);
            command.Parameters.AddWithValue("@MaSanPham", textBoxMasp.Text);
            if (textBoxtensp.Text == str || textBoxdg.Text == str || textBoxMasp.Text == str )
            {
                MessageBox.Show("Hãy điền đầy đủ thông tin");
            }
            else
            {
                try
                {
                    command.ExecuteNonQuery();
                    MessageBox.Show("Sửa sản phẩm Thành Công!");
                    this.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Sửa sản phẩm không thành công");
                }
            }
        }
    }
}
