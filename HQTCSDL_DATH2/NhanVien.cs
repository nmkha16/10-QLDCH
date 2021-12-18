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
    public partial class NhanVien : Form
    {
        private Interface itf;
        private SqlConnection cnn;
        public NhanVien()
        {
            InitializeComponent();
        }
        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.itf.Show();
        }

    }
}
