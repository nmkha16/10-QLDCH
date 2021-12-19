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
    public partial class KhachHang_XDH : Form
    {
        private KhachHang KH;
        private SqlConnection cnn;
        private DataSet detail = new DataSet();
        public KhachHang_XDH(KhachHang _KH, SqlConnection _cnn)
        {
            InitializeComponent();
            this.KH = _KH;
            this.cnn = _cnn;
            this.FormClosing += KhachHang_XDH_FormClosing;
            dataGridView4.AutoGenerateColumns = true;
            dataGridView4.ReadOnly = true;
            dataGridView3.AutoGenerateColumns = true;
            dataGridView3.ReadOnly = true;
            //set select entire row
            dataGridView4.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView4.MultiSelect = false;
            dataGridView4.RowPrePaint += new DataGridViewRowPrePaintEventHandler(dgv_RowPrePaint);
            dataGridView3.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView3.MultiSelect = false;
            // not allow user resize
            dataGridView4.AllowUserToResizeColumns = false;
            dataGridView4.AllowUserToResizeRows = false;
            // populate table
            //Console.WriteLine(this.KH.getID());
            DataSet data = new DataSet();
            string query = "select madonhang N'Mã đơn hàng', diachigiaohang N'Địa chỉ giao hàng'" +
                ",phivanchuyen N'Phí vận chuyển',tongtien N'Tổng tiền', hinhthucthanhtoan N'Hình thức thanh toán'," +
                "tinhtrangdonhang N'Tình trạng đơn hàng' from donhang where makhachhang=" +
                        this.KH.getID();
            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(data);
            dataGridView4.DataSource = data.Tables[0];
            dataGridView4.AutoResizeColumns();
            dataGridView4.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            this.cnn.Close();

        }

        private void dgv_RowPrePaint(object sender, DataGridViewRowPrePaintEventArgs e)
        {
            e.PaintParts &= ~DataGridViewPaintParts.Focus;
        }

        private void KhachHang_XDH_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.cnn.Close();
            this.KH.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            this.detail.Clear();
            string orderID = dataGridView4.Rows[e.RowIndex].Cells[0].Value.ToString();
            string query = "select madonhang N'Mã ĐH', masanpham N'Mã SP',tensanpham N'Tên SP',dongia N'Đơn giá'," +
                "soluong N'SoLuong',thanhtien N'ThanhTien' from dh_sp where madonhang = "+orderID;

            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(detail);

            dataGridView3.DataSource = detail.Tables[0];

            dataGridView3.AutoResizeColumns();
            dataGridView3.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            this.cnn.Close();
            
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
