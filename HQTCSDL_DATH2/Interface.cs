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
    public partial class Interface : Form
    {
        private ConnectDB firstForm;
        ConnectDB cdb;
        SqlConnection cnn;
        public Interface() {
            InitializeComponent();
        }

        public Interface(ConnectDB cdb, SqlConnection cnn)
        {
            this.cnn = cnn;
            this.cdb = cdb;
            this.firstForm = cdb;
            InitializeComponent();
            this.Closing += Interface_Closing;
            Role_box.DisplayMember = "Text";
            Role_box.ValueMember = "Value";
            Role_box.Items.Add(new { Text = "Đối tác", Value = "Đối tác" });
            Role_box.Items.Add(new { Text = "Khách hàng", Value = "Khách hàng" });
            Role_box.Items.Add(new { Text = "Tài xế", Value = "Nhân viên" });
            Role_box.Items.Add(new { Text = "Quản trị", Value = "Quản trị" });
        }

        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.firstForm.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            DoiTac DT1 = new DoiTac(cdb, cnn);
            this.Hide();
            DT1.ShowDialog();

        }

        /*
         *Tắt 2 input box khi chọn role phù hợp 
         */ 
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string curItem = (this.Role_box.SelectedItem as dynamic).Value;
            if (curItem == "Khách hàng" || curItem == "Tài xế" || curItem == "Đối tác")
            {
                this.ID_box.Enabled = false;
                this.Password_box.Enabled = false;
            }
            else { this.ID_box.Enabled = true; this.Password_box.Enabled = true; }

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pass_lbl_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.Close();
            this.firstForm.Show();
        }
    }
}
