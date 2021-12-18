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
        public Interface() {
            InitializeComponent();
        }

        public Interface(ConnectDB cdb, SqlConnection cnn)
        {
            this.firstForm = cdb;
            InitializeComponent();
            this.Closing += Interface_Closing;
            comboBox1.DisplayMember = "Text";
            comboBox1.ValueMember = "Value";
            comboBox1.Items.Add(new { Text = "Đối tác", Value = "Đối tác" });
            comboBox1.Items.Add(new { Text = "Khách hàng", Value = "Khách hàng" });
            comboBox1.Items.Add(new { Text = "Tài xế", Value = "Nhân viên" });
            comboBox1.Items.Add(new { Text = "Quản trị", Value = "Quản trị" });
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

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string curItem = (this.comboBox1.SelectedItem as dynamic).Value;
            if (curItem == "Khách hàng" || curItem == "Tài xế" || curItem == "Đối tác")
            {
                this.textBox1.Enabled = false;
                this.textBox2.Enabled = false;
            }
            else { this.textBox1.Enabled = true; this.textBox2.Enabled = true; }

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
    }
}
