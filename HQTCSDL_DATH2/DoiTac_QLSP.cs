using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HQTCSDL_DATH2
{
    public partial class DoiTac_QLSP : Form
    {
        private DoiTac dt;
        private SqlConnection cnn;
        public DoiTac_QLSP(DoiTac dt, SqlConnection cnn)
        {
            InitializeComponent();
            this.FormClosing += DoiTac_QLSP_FormClosing; 
            this.dt = dt;
            this.cnn = cnn;
            DisplayData();
        }

        private void DoiTac_QLSP_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.dt.Show();
        }

        private void DisplayData()
        {
            cnn.Open();
            DataTable data = new DataTable();
            SqlDataAdapter adapt = new SqlDataAdapter("SELECT MaSanPham, TenSanPham, DonGia FROM SANPHAM", cnn);
            adapt.Fill(data);
            dataGridView1.DataSource = data;
            cnn.Close();
        } 

        private void ClearData()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";

        }
        private void DoiTac_QLSP_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string TenSP = textBox1.Text;
            string DonGia = textBox2.Text;
            int DonGia1 = Int32.Parse(DonGia);

            SqlCommand sc = new SqlCommand("EXEC ThemSanPham '" + TenSP + "'," + DonGia, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Thêm sản phẩm thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string MaSP = textBox3.Text;
            int MaSP1 = Int32.Parse(MaSP);
            string TenSP = textBox1.Text;
            string DonGia = textBox2.Text;
            int DonGia1 = Int32.Parse(DonGia);

            SqlCommand sc = new SqlCommand("EXEC SuaSanPham "+ MaSP1 + ",'" + TenSP + "'," + DonGia, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Sửa sản phẩm thành công!!");
            this.cnn.Close();
            DisplayData();
            ClearData();
        }
    }
}
