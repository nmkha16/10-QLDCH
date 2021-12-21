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
    public partial class DoiTac_QLSP : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbmaDT = new DataTable();
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";
        public DoiTac_QLSP()
        {
            InitializeComponent();
        }

        private void DoiTac_QLSP_Load(object sender, EventArgs e)
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

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            DoiTac_ThemSP ThemSP = new DoiTac_ThemSP();
            ThemSP.ShowDialog();
            this.Close();

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void button3_Click_1(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "select SANPHAM.MaSanPham,SANPHAM.MaChiNhanh,SANPHAM.MaDT,SANPHAM.TenSanPham,SANPHAM.DonGia from SANPHAM, DOITAC where SANPHAM.MaDT = DOITAC.MaDT and SANPHAM.MaDT = @MaDT";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@MaDT", textBox1.Text);
            adapter.SelectCommand = command;
            tbmaDT.Clear();
            adapter.Fill(tbmaDT);
            dataGridViewxemsp.DataSource = tbmaDT;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            DoiTac_SuaSP SuaSP = new DoiTac_SuaSP();
            SuaSP.ShowDialog();
            this.Close();
        }
    }
}
