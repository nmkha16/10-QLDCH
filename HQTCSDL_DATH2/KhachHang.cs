using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace HQTCSDL_DATH2
{
    public partial class KhachHang : Form
    {
        private SqlConnection cnn;
        private Interface ift;
        private string currentID;
        private Boolean status = false;
        public KhachHang(Interface ift, SqlConnection cnn)
        {
            this.FormBorderStyle = FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            InitializeComponent();
            this.ift = ift;
            this.cnn = cnn;
            this.FormClosing += KhachHang_FormClosing;
            textBox1.Text = "6594506166";
        }

        //method to get currentID
        public string getID() { return this.currentID; }
        // method to get address
        public string getAddr()
        {
            SqlCommand query = new SqlCommand("select diachi from khachhang where makhachhang =@id", cnn);
            SqlParameter param = new SqlParameter("@id", this.getID());
            query.Parameters.Add(param);
            this.cnn.Open();
            SqlDataReader reader = query.ExecuteReader();
            //this.cnn.Close();
            if (!reader.HasRows)
            {
                reader.Close();
                this.cnn.Close();
                return null;
            }
            else
            {
                while (reader.Read()) { 
                    
                    string result = reader[0].ToString();
                    reader.Close();
                    this.cnn.Close();
                    return result;             
                }
            }
            
            return null;
        }

        private void KhachHang_FormClosing(object sender, FormClosingEventArgs e)
        {

            this.ift.Show();
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void signup_btn_Click(object sender, EventArgs e)
        {
            this.Hide();
            KhachHang_DK dk = new KhachHang_DK(this, cnn);
            dk.Show();
        }

        // nút kiểm tra
        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("select makhachhang,hoten from khachhang where sdt =@phone", cnn);
            SqlParameter param = new SqlParameter("@phone", textBox1.Text);
            //param.ParameterName = "@phone";
            //param.Value = textBox1.Text;
            query.Parameters.Add(param);
            this.cnn.Open();
            SqlDataReader reader = query.ExecuteReader();
            //this.cnn.Close();
            if (!reader.HasRows)
            {
                MessageBox.Show("Không tìm thấy khách hàng");
            }
            else
            {
                while (reader.Read())
                {
                    MessageBox.Show("Chào khách hàng " + reader[1].ToString());
                    this.currentID = reader[0].ToString();
                    status = true;
                }
            }
            reader.Close();
            this.cnn.Close();
        }
        // nút xem đơn hàng
        private void button2_Click(object sender, EventArgs e)
        {
            if (status)
            {
                this.Hide();
                KhachHang_XDH xdh = new KhachHang_XDH(this, cnn);
                xdh.Show();
            }
        }

        // nút đặt hàng
        private void button1_Click_1(object sender, EventArgs e)
        {
            if (status)
            {
                this.Hide();
                KhachHang_DH dh = new KhachHang_DH(this, cnn);
                dh.Show();
            }
        }
    }
}
