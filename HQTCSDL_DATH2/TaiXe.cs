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
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable tbTaiXe = new DataTable();
        
        string str = @"Data Source=(local);Initial Catalog=QLDatVaChuyenHang;Integrated Security=True";

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
            TaiXe_DoanhThu taixe = new TaiXe_DoanhThu(textBoxTaixe.Text);
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

        private void TaiXe_Load(object sender, EventArgs e)
        {
            try
            {
                connection = new SqlConnection(str);
                connection.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void validate_btn_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "select * from TaiXe Where TaiXe.CMND = @CMND";
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@CMND", textBoxTaixe.Text);
            adapter.SelectCommand = command;
            tbTaiXe.Clear();
            adapter.Fill(tbTaiXe);
            dataGridView1.DataSource = tbTaiXe;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
