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
    public partial class TaiXe : Form
    {
        private Interface itf;
        private SqlConnection cnn;
        //private DoiTac dt;
        public TaiXe()
        {
            InitializeComponent();
        }

        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.itf.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void signup_btn_Click(object sender, EventArgs e)
        {
            this.Hide();
            TaiXe_DK taixe = new TaiXe_DK();
            taixe.ShowDialog();
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            TaiXe_DoanhThu taixe = new TaiXe_DoanhThu();
            taixe.ShowDialog();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            TaiXe_TNDH taixe = new TaiXe_TNDH();
            taixe.ShowDialog();
            this.Close();
        }
    }
}
