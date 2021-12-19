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
    public partial class TaiXe_TNDH : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbDH_KV = new DataTable();
        DataTable tbCTDH = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
        public TaiXe_TNDH()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void TaiXe_TNDH_Load(object sender, EventArgs e)
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

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void buttonkt_Click(object sender, EventArgs e)
        {
            try
            {
                connection = new SqlConnection(str);
                connection.Open();
                command = connection.CreateCommand();
                command.CommandText = "select DONHANG.MaDonHang, TAIXE.SDT, DONHANG.TongTien, DONHANG.DiaChiGiaoHang from DONHANG,TAIXE where TAIXE.CMND = @CMND and TAIXE.MaTaiXe=DONHANG.MaTaiXe";
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@CMND", tbCMND.Text);
                adapter.SelectCommand = command;
                tbDH_KV.Clear();
                adapter.Fill(tbDH_KV);
                dataGridView4.DataSource = tbDH_KV;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
            try
            {
                connection = new SqlConnection(str);
                connection.Open();
                command = connection.CreateCommand();
                command.CommandText = "select DH_SP.MaSanPham,DH_SP.TenSanPham,DH_SP.SoLuong, DH_SP.DonGia from DH_SP,TAIXE,DONHANG where DONHANG.MaDonHang=DH_SP.MaDonHang and DONHANG.MaTaiXe=TAIXE.MaTaiXe and TAIXE.CMND=@CMND";
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@CMND", tbCMND.Text);
                adapter.SelectCommand = command;
                tbCTDH.Clear();
                adapter.Fill(tbCTDH);
                dataGridView3.DataSource = tbCTDH;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            TaiXe taixe = new TaiXe();
            taixe.ShowDialog();
            this.Close();
        }
    }
}
