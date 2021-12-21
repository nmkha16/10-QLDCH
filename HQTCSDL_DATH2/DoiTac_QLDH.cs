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
    public partial class DoiTac_QLDH : Form
    {
        private DoiTac dt;
        private SqlConnection cnn;
        //private string TTDH;
        private string MaDH;
        public DoiTac_QLDH(DoiTac dt, SqlConnection cnn)
        {
            InitializeComponent();
            this.FormClosing += DoiTac_QLDH_FormClosing;
            this.dt = dt;
            this.cnn = cnn;
            DisplayData();
        }

        private void DoiTac_QLDH_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.dt.Show();
        }

        private void DisplayData()
        {
            cnn.Open();
            DataTable data = new DataTable();
            SqlDataAdapter adapt = new SqlDataAdapter("SELECT MaDonHang, MaKhachHang, TinhTrangDonHang, DiaChiGiaoHang, PhiVanChuyen, TongTien FROM DONHANG", cnn);
            adapt.Fill(data);
            dataGridView_TTDH.DataSource = data;
            cnn.Close();
        }
        //Clear Data  
        private void ClearData()
        {
            TTDH_comboBox.Text = "";
        }

        private void Update_btn_Click(object sender, EventArgs e)
        {
            if (TTDH_comboBox.Text != "")
            {
                string TinhTrang = TTDH_comboBox.Text;
                string MaDH = textBox1.Text;
                int MaDH1 = Int32.Parse(MaDH);
                SqlCommand cmd = new SqlCommand("UPDATE DONHANG SET TinhTrangDonHang = '" + TinhTrang + "' WHERE MaDonHang = " + MaDH1 , cnn);
                cnn.Open();
               
                cmd.ExecuteNonQuery();
                cnn.Close();
                MessageBox.Show("Updated Successfully");
                DisplayData();
                ClearData();
            }
            else
            {
                MessageBox.Show("Hãy chọn tình trạng đơn hàng muốn cập nhật!!");
            }

        }

        private void dataGridView_TTDH_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            MaDH = dataGridView_TTDH.Rows[e.RowIndex].Cells[0].Value.ToString();
            //txt_Name.Text = dataGridView_TTDH.Rows[e.RowIndex].Cells[1].Value.ToString();
            TTDH_comboBox.Text = dataGridView_TTDH.Rows[e.RowIndex].Cells[2].Value.ToString();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
