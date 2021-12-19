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
        private DoiTac_LHD lhd;
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

        private void TaoHD_btn_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string NDD = DoiTac_LHD_NDD.Text;
            string TTKH = DoiTac_LHP_TTKH.Text;
            string PHH = DoiTac_LHD_PHH.Text;
            int PHH1 = Int32.Parse(PHH);
            string NHH = DoiTac_LHD_NHH.Text;
            string PTHH = DoiTac_LHD_PTHH.Text;
            int PTHH1 = Int32.Parse(PTHH);

            SqlCommand sc = new SqlCommand("EXEC SP_TaoHopDong '" + NDD + "','" + TTKH + "'," + PHH1 + ",'" + NHH + "'," + PTHH1, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Lập hợp đồng thành công!!");
            this.cnn.Close();


        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click_2(object sender, EventArgs e)
        {

        }
    }
}
