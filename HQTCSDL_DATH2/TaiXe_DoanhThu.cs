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
    public partial class TaiXe_DoanhThu : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbDoanhthu = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
       
        public TaiXe_DoanhThu()
        {
            InitializeComponent();
        }
       
        private void TaiXe_DoanhThu_Load(object sender, EventArgs e)
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

        private void dataGridViewdoanhthu_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                connection = new SqlConnection(str);
                connection.Open();
                command = connection.CreateCommand();
                command.CommandText = "select DONHANG.MaDonHang, DONHANG.DiaChiGiaoHang, DONHANG.PhiVanChuyen, DONHANG.TinhTrangDonHang from DONHANG, TAIXE where TAIXE.CMND = @CMND and TAIXE.MaTaiXe = DONHANG.MaTaiXe";
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@CMND", tbCMND.Text);
                adapter.SelectCommand = command;
                tbDoanhthu.Clear();
                adapter.Fill(tbDoanhthu);
                dataGridViewdoanhthu.DataSource = tbDoanhthu;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            TaiXe taixe = new TaiXe();
            taixe.ShowDialog();
            this.Close();
        }
    }
}
