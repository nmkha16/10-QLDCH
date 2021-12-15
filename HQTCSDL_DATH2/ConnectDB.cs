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
    public partial class ConnectDB : Form
    {
        public ConnectDB()
        {

            InitializeComponent();
            db_name.Text = "QLDatVaChuyenHang";
            user.Text = "sa";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connectionString;
            SqlConnection cnn;
            connectionString = @"Data Source =";
            connectionString += sv_name.Text + ";Initial Catalog=" + db_name.Text + ";User ID=" + user.Text + ";Password=" + pass.Text;
            System.Diagnostics.Debug.WriteLine(connectionString);
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            MessageBox.Show("Connected");
            cnn.Close();
        }
    }
}
