namespace HQTCSDL_DATH2
{
    partial class DoiTac_QLDH
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel1 = new System.Windows.Forms.Panel();
            this.dataGridView4 = new System.Windows.Forms.DataGridView();
            this.madonhang = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sodienthoai = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tongtien = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.diachigiaohang = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.phivanchuyen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView4)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.AutoSize = true;
            this.panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panel1.Controls.Add(this.comboBox1);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.dataGridView4);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(503, 306);
            this.panel1.TabIndex = 0;
            // 
            // dataGridView4
            // 
            this.dataGridView4.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridView4.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView4.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.madonhang,
            this.sodienthoai,
            this.tongtien,
            this.diachigiaohang,
            this.phivanchuyen});
            this.dataGridView4.Location = new System.Drawing.Point(12, 57);
            this.dataGridView4.Name = "dataGridView4";
            this.dataGridView4.RowHeadersVisible = false;
            this.dataGridView4.Size = new System.Drawing.Size(479, 237);
            this.dataGridView4.TabIndex = 1;
            // 
            // madonhang
            // 
            this.madonhang.HeaderText = "Mã đơn hàng";
            this.madonhang.Name = "madonhang";
            // 
            // sodienthoai
            // 
            this.sodienthoai.HeaderText = "Số điện thoại";
            this.sodienthoai.Name = "sodienthoai";
            // 
            // tongtien
            // 
            this.tongtien.HeaderText = "Tổng tiền";
            this.tongtien.Name = "tongtien";
            // 
            // diachigiaohang
            // 
            this.diachigiaohang.HeaderText = "Địa chỉ giao hàng";
            this.diachigiaohang.Name = "diachigiaohang";
            // 
            // phivanchuyen
            // 
            this.phivanchuyen.HeaderText = "Phí vận chuyển";
            this.phivanchuyen.Name = "phivanchuyen";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(35, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(129, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Tình trạng giao hàng";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(310, 21);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 4;
            this.button1.Text = "Cập nhật";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // comboBox1
            // 
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Items.AddRange(new object[] {
            "CHUAGIAO",
            "DAGIAO"});
            this.comboBox1.Location = new System.Drawing.Point(170, 23);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(121, 21);
            this.comboBox1.TabIndex = 5;
            // 
            // DoiTac_QLDH
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(503, 306);
            this.Controls.Add(this.panel1);
            this.Name = "DoiTac_QLDH";
            this.Text = "DoiTac_QLDH";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView4)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dataGridView4;
        private System.Windows.Forms.DataGridViewTextBoxColumn madonhang;
        private System.Windows.Forms.DataGridViewTextBoxColumn sodienthoai;
        private System.Windows.Forms.DataGridViewTextBoxColumn tongtien;
        private System.Windows.Forms.DataGridViewTextBoxColumn diachigiaohang;
        private System.Windows.Forms.DataGridViewTextBoxColumn phivanchuyen;
    }
}