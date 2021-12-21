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
    public partial class DoiTac : Form
    {
        private Interface itf;
        private SqlConnection cnn;
        public DoiTac(Interface itf, SqlConnection cnn)
        {
            InitializeComponent();
            this.Closing += Interface_Closing;
            this.cnn = cnn;
            this.itf = itf;
  
        }

        private void Interface_Closing(object sender, CancelEventArgs e)
        {
            this.itf.Show();
        }

        private void validate_btn_Click(object sender, EventArgs e)
        {
            if (MST_textbox.Text.Length == 0)
            {
                MessageBox.Show("Vui lòng nhập mã số thuế");
                this.Hide();
                DoiTac DT1 = new DoiTac(itf, cnn);
                DT1.ShowDialog();
            }
            else
                dataGridView1.DataSource = KiemTraDoiTac().Tables[0];
        }

        DataSet KiemTraDoiTac()
        {
            DataSet data = new DataSet();  
            string query = "SELECT * FROM DOITAC WHERE MaSoThue =" + MST_textbox.Text;


            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(data);
            this.cnn.Close();

            return data;

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void LapHD_btn_Click(object sender, EventArgs e)
        {
            
            this.Hide();

            DoiTac_LHD LHD = new DoiTac_LHD(this, cnn);
            LHD.ShowDialog();
        }

        private void DoiTac_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (MST_textbox.Text == "")
            {
                MessageBox.Show("Vui lòng nhập Mã số Thuế");
            }
            else
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT COUNT(*) FROM DOITAC WHERE MaSoThue = "
                       + MST_textbox.Text.ToString(), cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows[0][0].ToString() == "1")
                {
                    this.Hide();
                    DoiTac_QLDH QLDH = new DoiTac_QLDH(this, cnn, MST_textbox.Text);
                    QLDH.ShowDialog();
                    
                }
                else MessageBox.Show("Vui lòng nhập Mã số thuế hợp lệ để quản lý đơn hàng!!");
            }
        }

        private void signup_btn_Click(object sender, EventArgs e)
        {
            this.Hide();
            DoiTac_DK DK = new DoiTac_DK(this, cnn);
            DK.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            DoiTac_QLSP QLSP = new DoiTac_QLSP();
            QLSP.ShowDialog();
        }
    }
}
