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
    public partial class NhanVien : Form
    {
        private Interface itf;
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbNV = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
        public NhanVien()
        {
            InitializeComponent();
        }
        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.itf.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from HOPDONG where HOPDONG.MaDT= @MaDT";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@MaDT", tbmadoitac.Text);
            adapter.SelectCommand = command;
            tbNV.Clear();
            adapter.Fill(tbNV);
            dataGridViewDT.DataSource = tbNV;
        }

        private void NhanVien_Load(object sender, EventArgs e)
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

        private void button1_Click_1(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "DECLARE @TinhTrangKichHoat_HopDong varchar(3) + SET @TinhTrangKichHoat_HopDong = 'NO' + IF @TinhTrangKichHoat_HopDong = 'NO' update HOPDONG set TinhTrangKichHoat = 'YES' where HOPDONG.MaDT = @MaDT ";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@MaDT", tbmadoitac.Text);
            adapter.SelectCommand = command;
            tbNV.Clear();
            adapter.Fill(tbNV);
            dataGridViewDT.DataSource = tbNV;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "Select HOPDONG.TinhTrangKichHoat from HOPDONG where HOPDONG.MaDT= @MaDT";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@MaDT", tbmadoitac.Text);
            adapter.SelectCommand = command;
            tbNV.Clear();
            adapter.Fill(tbNV);
            dataGridViewDT.DataSource = tbNV;
        }
    }
}
