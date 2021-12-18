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
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connectionString;
            SqlConnection cnn;
            // build connection string to sql
            connectionString = @"Data Source =";
            connectionString += sv_name.Text + ";Initial Catalog=" + db_name.Text + ";Integrated Security=True;";
            //System.Diagnostics.Debug.WriteLine(connectionString);
            try
            {
                cnn = new SqlConnection(connectionString);
                cnn.Open();
                //this.Hide();
                MessageBox.Show("Connected");
                // open new form Interface()
                this.Hide();
                Interface interface1 = new Interface(this,cnn);
                interface1.Show();
                
                //cnn.Close();
            }
            catch
            {// do nothing }

            }
        }

        private void sv_name_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
