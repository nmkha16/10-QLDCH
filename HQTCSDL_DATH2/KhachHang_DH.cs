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
    public partial class KhachHang_DH : Form
    {
        private KhachHang kh;
        private SqlConnection cnn;
        private DataSet dsDT;
        private DataTable cart;
        private string dtID;
        public KhachHang_DH(KhachHang kh, SqlConnection cnn)
        {
            this.kh = kh; 
            this.cnn = cnn;
            InitializeComponent();
            this.FormClosing += KhachHang_DH_FormClosing;
            //set select one row instead of cell
            dataGridView1.AutoGenerateColumns = true;
            dataGridView1.ReadOnly = true;
            dataGridView3.AutoGenerateColumns = true;
            dataGridView3.ReadOnly = true;

            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView1.MultiSelect = false;
            dataGridView1.RowPrePaint += new DataGridViewRowPrePaintEventHandler(dgv_RowPrePaint);
            dataGridView3.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView3.MultiSelect = false;
            dataGridView3.RowPrePaint += new DataGridViewRowPrePaintEventHandler(dgv_RowPrePaint);
            // not allow user resize
            dataGridView1.AllowUserToResizeColumns = false;
            dataGridView1.AllowUserToResizeRows = false;
            dataGridView3.AllowUserToResizeColumns = false;
            dataGridView3.AllowUserToResizeRows = false;
            //populate table
            dsDT = new DataSet();
            string query = "select madt N'Mã đối tác', tendt N'Tên đối tác',thanhpho N'Thành phố',loaivanchuyen N'Loại vận chuyển', SDT N'Số điện thoại'," +
                "Email from doitac";
            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(dsDT);
            dataGridView1.DataSource = dsDT.Tables[0];
            dataGridView1.AutoResizeColumns();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;

            this.cnn.Close();

            // hình thức thanh toán
            comboBox1.DisplayMember = "Text";
            comboBox1.ValueMember = "Value";
            comboBox1.Items.Add(new { Text = "Tiền mặt", Value = "TIENMAT" });
            comboBox1.Items.Add(new { Text = "Thẻ", Value = "THE" });

            textBox1.ReadOnly =true;

            // set data table for cart
            cart = new DataTable();
            cart.Columns.Add("Mã SP", typeof(int));
            cart.Columns.Add("Tên SP", typeof(string));
            cart.Columns.Add("Đơn giá", typeof(int));
            cart.Columns.Add("Số lượng", typeof(int));
            cart.Columns.Add("Thành tiền", typeof(int));
        }

        private void KhachHang_DH_FormClosing(object sender, FormClosingEventArgs e)
        {
            kh.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //populate table
            dtID = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString(); // lấy đối tác ID khi người dùng chọn một row
            DataSet data = new DataSet();
            string query = "select masanpham N'Mã SP', tensanpham N'Tên SP',dongia N'Đơn giá' from sanpham where madt ="+dtID;
            this.cnn.Open();
            SqlDataAdapter adt = new SqlDataAdapter(query, cnn);
            adt.Fill(data);
            dataGridView3.DataSource = data.Tables[0];
            dataGridView3.AutoResizeColumns();
            dataGridView3.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            this.cnn.Close();
        }

        private void dgv_RowPrePaint(object sender, DataGridViewRowPrePaintEventArgs e)
        {
            e.PaintParts &= ~DataGridViewPaintParts.Focus;
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        // khi người dùng chọn 1 sản phẩm, thêm sản phẩm vào bảng cart
        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // kiểm tra mã sản phẩm có trong cart chưa
            bool contains = cart.AsEnumerable().Any(row => Convert.ToInt32(dataGridView3.Rows[e.RowIndex].Cells[0].Value) == row.Field<int>("Mã SP"));
            if (!contains)// không có thì cho phép thêm vào giỏ hàng 
            {
                cart.Rows.Add(dataGridView3.Rows[e.RowIndex].Cells[0].Value, dataGridView3.Rows[e.RowIndex].Cells[1].Value.ToString(),
                    dataGridView3.Rows[e.RowIndex].Cells[2].Value, 1, dataGridView3.Rows[e.RowIndex].Cells[2].Value);
                dataGridView2.DataSource = cart;
                // recalculate total price
                int sum = 0;
                foreach (DataRow row in cart.Rows)
                {
                    sum += Convert.ToInt32(row["Thành tiền"]);
                }
                textBox1.Text = sum.ToString();
            }
        }

        // khi người dùng sửa số lượng sản phẩm trong giỏ hàng, tính lại thành tiền = sl * dg
        private void dataGridView2_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            cart.Rows[e.RowIndex]["Số lượng"] = dataGridView2.Rows[e.RowIndex].Cells[3].Value;
            // recalculate price
            cart.Rows[e.RowIndex]["Thành tiền"] = Convert.ToInt32(dataGridView2.Rows[e.RowIndex].Cells[3].Value) * Convert.ToInt32(dataGridView2.Rows[e.RowIndex].Cells[2].Value);
            // recalculate total price
            int sum = 0;
            foreach (DataRow row in cart.Rows)
            {
                sum += Convert.ToInt32(row["Thành tiền"]);
            }
            textBox1.Text = sum.ToString();
            for (int i = 0; i < dataGridView2.Columns.Count; i++)
                if (i == 3) { 
                    dataGridView2.Columns[i].ReadOnly = false;
                }
                else
                {
                    dataGridView2.Columns[i].ReadOnly = true;
                }
        }

        // bấm nút đặt hàng
        private void button1_Click(object sender, EventArgs e)
        {
            // thêm đơn hàng vào table donhang
            string sp = "exec sp_themdonhang @madt,@mataixe,@makhachhang," +
                "@tongtien,@hinhthucthanhtoan,@diachigiaohang," +
                "@phivanchuyen,@tinhtrangdonhang,@khuvuc";
            SqlCommand query = new SqlCommand(sp, cnn);
            SqlParameter[] param = new SqlParameter[9];
            Random random = new Random();
            param[0] = new SqlParameter("@madt", Convert.ToInt32(dtID));
            param[1] = new SqlParameter("@mataixe", DBNull.Value);
            param[2] = new SqlParameter("@makhachhang", kh.getID());
            param[3] = new SqlParameter("@tongtien", textBox1.Text);
            param[4] = new SqlParameter("@hinhthucthanhtoan", (this.comboBox1.SelectedItem as dynamic).Value);
            param[5] = new SqlParameter("@diachigiaohang", this.kh.getAddr());
            param[6] = new SqlParameter("@phivanchuyen", random.Next(10000, 35000));
            param[7] = new SqlParameter("@tinhtrangdonhang", "CHUAGIAO");
            param[8] = new SqlParameter("@khuvuc", DBNull.Value);
            for (int i = 0; i < param.Length; i++)
            {
                query.Parameters.Add(param[i]);
            }
            this.cnn.Open();
            try
            {
                query.ExecuteNonQuery();
            }
            catch
            {
                MessageBox.Show("Đặt hàng thất bại");
                return;
            }
            finally
            {
                this.cnn.Close();
            }

            // thêm các sản phẩm vào chi tiết đơn hàng
            // lấy đơn hàng mới nhất - vừa mới thêm
            query = new SqlCommand("select top 1 MaDonHang from DONHANG where MaKhachHang =@id  order by MaDonHang desc", cnn);
            SqlParameter param1 = new SqlParameter("@id",kh.getID());
            query.Parameters.Add(param1);
            cnn.Open();
            SqlDataReader reader = query.ExecuteReader();
            string lastestOrderID = null;
            if (!reader.HasRows)
            {
                MessageBox.Show("Không tìm thấy đơn đã được đặt");
                return;
            }
            else
            {
                while (reader.Read())
                {
                    lastestOrderID = reader[0].ToString();
                }
            }
            cnn.Close();
            reader.Close();
            // thêm các sản phẩm
            try
            {
                for (int i = 0; i < dataGridView2.RowCount - 1; i++)
                {
                    query = new SqlCommand("exec proc_DH_SP @madh,@masp,@dongia,@soluong,@thanhtien", cnn);
                    param = new SqlParameter[5];
                    param[0] = new SqlParameter("@madh", lastestOrderID);
                    param[1] = new SqlParameter("@masp", dataGridView2.Rows[i].Cells[0].Value);
                    param[2] = new SqlParameter("@dongia", dataGridView2.Rows[i].Cells[2].Value);
                    param[3] = new SqlParameter("@soluong", dataGridView2.Rows[i].Cells[3].Value);
                    param[4] = new SqlParameter("@thanhtien", dataGridView2.Rows[i].Cells[4].Value);
                    for (int j = 0; j < param.Length; j++)
                    {
                        query.Parameters.Add(param[j]);
                    }
                    cnn.Open();
                    query.ExecuteNonQuery();
                    cnn.Close();
                }
                MessageBox.Show("Đặt hàng thành công");
            }
            catch
            {
                MessageBox.Show("Đặt hàng thất bại");
            }

        }

        // double click vào sản phẩm để xoá
        private void dataGridView2_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            for (int i = cart.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = cart.Rows[i];
                if (i == e.RowIndex)
                    dr.Delete();
            }
            cart.AcceptChanges();

            // recalculate total price
            int sum = 0;
            foreach (DataRow row in cart.Rows)
            {
                sum += Convert.ToInt32(row["Thành tiền"]);
            }
            textBox1.Text = sum.ToString();
        }
    }
}
