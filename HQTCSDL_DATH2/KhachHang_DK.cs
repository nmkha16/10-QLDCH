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
    public partial class KhachHang_DK : Form
    {
        private KhachHang kh;
        private SqlConnection cnn;
        public KhachHang_DK(KhachHang kh, SqlConnection cnn)
        {
            InitializeComponent();
            this.cnn = cnn;
            this.kh = kh;
            this.FormClosing += KhachHang_DK_FormClosing;

        }      

        private void KhachHang_DK_FormClosing(object sender, FormClosingEventArgs e)
        {
            kh.Show();
        }

        // nút huỷ
        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            this.kh.Show();
        }

        // nút đăng ký
        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("insert into khachhang(hoten,sdt,diachi,email) values (@hoten,@sdt,@diachi,@email)", cnn);
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@hoten", textBox1.Text);
            param[1] = new SqlParameter("@sdt",textBox2.Text);
            param[2] = new SqlParameter("@diachi",textBox3.Text);
            param[3] = new SqlParameter("@email",textBox4.Text);
            for (int i = 0; i < param.Length; i++)
            {
                query.Parameters.Add(param[i]);
            }
            this.cnn.Open();
            try
            {
                query.ExecuteNonQuery();
                MessageBox.Show("Khách hàng "+textBox1.Text + " đăng ký thành công");
            }
            catch
            {
                MessageBox.Show("Đăng ký khách hàng thất bại");
            }
            finally
            {
                this.cnn.Close();
            }
        }
    }
}
