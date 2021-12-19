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
        DataTable tbTaiXe = new DataTable();
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
    }
}
