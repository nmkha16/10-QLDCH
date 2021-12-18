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
    public partial class KhachHang_XDH : Form
    {
        private KhachHang KH;
        private SqlConnection cnn;
        public KhachHang_XDH(KhachHang KH, SqlConnection cnn)
        {
            InitializeComponent();
            this.KH = KH;
            this.cnn = cnn;
            this.FormClosing += KhachHang_XDH_FormClosing;
            // populate table
            DataSet data = new DataSet();
            string query = "select madonhang, diachigiaohang,phivanchuyen,tongtien, hinhthucthanhtoan,tinhtrangdonhang from donhang where madonhang=" +
                        this.KH.getID();
            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(data);
            //this.cnn.Close();
            dataGridView4.DataSource = data;
            this.cnn.Close();

        }

        private void KhachHang_XDH_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.KH.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
