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
    public partial class DoiTac : Form
    {
        private Interface itf;
        private SqlConnection cnn;
        public DoiTac(Interface itf, SqlConnection cnn)
        {
            InitializeComponent();
            this.Closing += Interface_Closing;
            this.cnn = cnn;
            this.itf = itf;

        }

        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.Close();
            this.itf.Show();
        }

        private void validate_btn_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = KiemTraDoiTac().Tables[0];
        }

        DataSet KiemTraDoiTac()
        {
            DataSet data = new DataSet();
            
            string query = "EXEC SP_KiemTraDoiTac @MST =" + MST_textbox.Text;
            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(data);
            this.cnn.Close();


            return data;

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
