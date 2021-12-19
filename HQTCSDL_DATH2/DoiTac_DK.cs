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
    public partial class DoiTac_DK : Form
    {
        private DoiTac dt;
        private SqlConnection cnn;
        public DoiTac_DK()
        {
            InitializeComponent();
        }

        public DoiTac_DK(DoiTac dt, SqlConnection cnn)
        {
            this.cnn = cnn;
            this.dt = dt;

            InitializeComponent();
            this.Closing += DoiTac_DK_Closing; ;
        }

        private void DoiTac_DK_Closing(object sender, CancelEventArgs e)
        {
            this.dt.Show();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.cnn.Open();
            string MST = textBox1.Text;
            int MST1 = Int32.Parse(MST);
            string NDD = textBox2.Text;
            string TP = textBox3.Text;
            string Quan = textBox4.Text; 
            string SCN = textBox5.Text;
            int SCN1 = Int32.Parse(SCN);
            string SD = textBox6.Text;
            int SD1 = Int32.Parse(SD);
            string Email = textBox7.Text;
            string PTHH = textBox8.Text;
            int PTHH1 = Int32.Parse(PTHH);

            SqlCommand sc = new SqlCommand("EXEC SP_DangKyDoiTac '" + MST1 + "','" 
                                                                  + NDD + "', '" 
                                                                  + TP + "', '" 
                                                                  + Quan + "'," 
                                                                  + SCN1 + ", "
                                                                  + SD1 + ", '"
                                                                  + Email +"', "
                                                                  + PTHH1, cnn);
            sc.ExecuteNonQuery();
            MessageBox.Show("Đăng ký đối tác thành công!!");
            this.cnn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            this.dt.Show();
        }
    }
}
