namespace HQTCSDL_DATH2
{
    partial class TaiXe_DoanhThu
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
            this.dataGridViewdoanhthu = new System.Windows.Forms.DataGridView();
            this.madonhang_1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.diachi = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.phivanchuyen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tinhtranggiaohang = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.panel1 = new System.Windows.Forms.Panel();
            this.button1 = new System.Windows.Forms.Button();
            this.tbCMND = new System.Windows.Forms.TextBox();
            this.CMND = new System.Windows.Forms.Label();
            this.splitter1 = new System.Windows.Forms.Splitter();
            this.label1 = new System.Windows.Forms.Label();
            this.button2 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewdoanhthu)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dataGridViewdoanhthu
            // 
            this.dataGridViewdoanhthu.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridViewdoanhthu.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewdoanhthu.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.madonhang_1,
            this.diachi,
            this.phivanchuyen,
            this.tinhtranggiaohang});
            this.dataGridViewdoanhthu.Location = new System.Drawing.Point(16, 114);
            this.dataGridViewdoanhthu.Margin = new System.Windows.Forms.Padding(4);
            this.dataGridViewdoanhthu.Name = "dataGridViewdoanhthu";
            this.dataGridViewdoanhthu.RowHeadersVisible = false;
            this.dataGridViewdoanhthu.RowHeadersWidth = 51;
            this.dataGridViewdoanhthu.Size = new System.Drawing.Size(619, 264);
            this.dataGridViewdoanhthu.TabIndex = 5;
            this.dataGridViewdoanhthu.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridViewdoanhthu_CellContentClick);
            // 
            // madonhang_1
            // 
            this.madonhang_1.HeaderText = "Mã đơn hàng";
            this.madonhang_1.MinimumWidth = 6;
            this.madonhang_1.Name = "madonhang_1";
            this.madonhang_1.Width = 125;
            // 
            // diachi
            // 
            this.diachi.HeaderText = "Địa chỉ giao hàng";
            this.diachi.MinimumWidth = 6;
            this.diachi.Name = "diachi";
            this.diachi.Width = 125;
            // 
            // phivanchuyen
            // 
            this.phivanchuyen.HeaderText = "Phí vận chuyển";
            this.phivanchuyen.MinimumWidth = 6;
            this.phivanchuyen.Name = "phivanchuyen";
            this.phivanchuyen.Width = 125;
            // 
            // tinhtranggiaohang
            // 
            this.tinhtranggiaohang.HeaderText = "Tình trạng giao hàng";
            this.tinhtranggiaohang.MinimumWidth = 6;
            this.tinhtranggiaohang.Name = "tinhtranggiaohang";
            this.tinhtranggiaohang.Width = 125;
            // 
            // panel1
            // 
            this.panel1.AutoSize = true;
            this.panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panel1.Controls.Add(this.button2);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.tbCMND);
            this.panel1.Controls.Add(this.CMND);
            this.panel1.Controls.Add(this.splitter1);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Margin = new System.Windows.Forms.Padding(4);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(644, 384);
            this.panel1.TabIndex = 6;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(438, 71);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 7;
            this.button1.Text = "Kiểm Tra";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // tbCMND
            // 
            this.tbCMND.Location = new System.Drawing.Point(127, 71);
            this.tbCMND.Name = "tbCMND";
            this.tbCMND.Size = new System.Drawing.Size(257, 22);
            this.tbCMND.TabIndex = 6;
            // 
            // CMND
            // 
            this.CMND.AutoSize = true;
            this.CMND.Location = new System.Drawing.Point(36, 71);
            this.CMND.Name = "CMND";
            this.CMND.Size = new System.Drawing.Size(47, 16);
            this.CMND.TabIndex = 5;
            this.CMND.Text = "CMND";
            // 
            // splitter1
            // 
            this.splitter1.Location = new System.Drawing.Point(0, 0);
            this.splitter1.Margin = new System.Windows.Forms.Padding(4);
            this.splitter1.Name = "splitter1";
            this.splitter1.Size = new System.Drawing.Size(4, 384);
            this.splitter1.TabIndex = 4;
            this.splitter1.TabStop = false;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(153, 27);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(297, 29);
            this.label1.TabIndex = 0;
            this.label1.Text = "Doanh thu các đơn đã giao";
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(543, 70);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 8;
            this.button2.Text = "Quay lại";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // TaiXe_DoanhThu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(644, 384);
            this.Controls.Add(this.dataGridViewdoanhthu);
            this.Controls.Add(this.panel1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "TaiXe_DoanhThu";
            this.Text = "TaiXeDoanhThu";
            this.Load += new System.EventHandler(this.TaiXe_DoanhThu_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewdoanhthu)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridViewdoanhthu;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Splitter splitter1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridViewTextBoxColumn madonhang_1;
        private System.Windows.Forms.DataGridViewTextBoxColumn diachi;
        private System.Windows.Forms.DataGridViewTextBoxColumn phivanchuyen;
        private System.Windows.Forms.DataGridViewTextBoxColumn tinhtranggiaohang;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox tbCMND;
        private System.Windows.Forms.Label CMND;
        private System.Windows.Forms.Button button2;
    }
}