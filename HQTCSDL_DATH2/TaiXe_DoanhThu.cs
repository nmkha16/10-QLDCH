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
    }
}
