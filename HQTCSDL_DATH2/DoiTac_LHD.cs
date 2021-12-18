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
    public partial class DoiTac_LHD : Form
    {
        private DoiTac dt;
        private SqlConnection cnn;
        //private DoiTac_LHD lhd;
        public DoiTac_LHD()
        {
            InitializeComponent();
        }
        
        public DoiTac_LHD(DoiTac dt, SqlConnection cnn)
        {
            this.cnn = cnn;
            this.dt = dt;
         
            InitializeComponent();
            this.Closing += DoiTac_LHD_Closing;
            
        }

        private void DoiTac_LHD_Closing(object sender, CancelEventArgs e)
        {
            this.dt.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Back_btn_Click(object sender, EventArgs e)
        {
            this.Close();
            this.dt.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }
    }
}
