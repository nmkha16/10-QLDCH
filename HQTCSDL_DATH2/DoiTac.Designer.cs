namespace HQTCSDL_DATH2
{
    partial class DoiTac
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
            this.components = new System.ComponentModel.Container();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.LapHD_btn = new System.Windows.Forms.Button();
            this.validate_btn = new System.Windows.Forms.Button();
            this.MST_textbox = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.signup_btn = new System.Windows.Forms.Button();
            this.qLDatVaChuyenHangDataSet = new HQTCSDL_DATH2.QLDatVaChuyenHangDataSet();
            this.qLDatVaChuyenHangDataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDatVaChuyenHangDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDatVaChuyenHangDataSetBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.AutoSize = true;
            this.panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(586, 275);
            this.panel1.TabIndex = 0;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.dataGridView1);
            this.panel2.Controls.Add(this.button3);
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.LapHD_btn);
            this.panel2.Controls.Add(this.validate_btn);
            this.panel2.Controls.Add(this.MST_textbox);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Controls.Add(this.signup_btn);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(586, 275);
            this.panel2.TabIndex = 1;
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(15, 59);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(549, 63);
            this.dataGridView1.TabIndex = 7;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // button3
            // 
            this.button3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button3.Location = new System.Drawing.Point(103, 159);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 41);
            this.button3.TabIndex = 6;
            this.button3.Text = "Quản lý sản phẩm";
            this.button3.UseVisualStyleBackColor = true;
            // 
            // button2
            // 
            this.button2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button2.Location = new System.Drawing.Point(202, 159);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 41);
            this.button2.TabIndex = 5;
            this.button2.Text = "Quản lý đơn hàng";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // LapHD_btn
            // 
            this.LapHD_btn.Location = new System.Drawing.Point(12, 159);
            this.LapHD_btn.Name = "LapHD_btn";
            this.LapHD_btn.Size = new System.Drawing.Size(75, 41);
            this.LapHD_btn.TabIndex = 4;
            this.LapHD_btn.Text = "Lập hợp đồng";
            this.LapHD_btn.UseVisualStyleBackColor = true;
            this.LapHD_btn.Click += new System.EventHandler(this.LapHD_btn_Click);
            // 
            // validate_btn
            // 
            this.validate_btn.Location = new System.Drawing.Point(257, 19);
            this.validate_btn.Name = "validate_btn";
            this.validate_btn.Size = new System.Drawing.Size(68, 20);
            this.validate_btn.TabIndex = 3;
            this.validate_btn.Text = "Kiểm tra";
            this.validate_btn.UseVisualStyleBackColor = true;
            this.validate_btn.Click += new System.EventHandler(this.validate_btn_Click);
            // 
            // MST_textbox
            // 
            this.MST_textbox.Location = new System.Drawing.Point(88, 19);
            this.MST_textbox.Name = "MST_textbox";
            this.MST_textbox.Size = new System.Drawing.Size(163, 20);
            this.MST_textbox.TabIndex = 2;
            this.MST_textbox.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(60, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Mã số thuế";
            // 
            // signup_btn
            // 
            this.signup_btn.Location = new System.Drawing.Point(299, 159);
            this.signup_btn.Name = "signup_btn";
            this.signup_btn.Size = new System.Drawing.Size(75, 41);
            this.signup_btn.TabIndex = 0;
            this.signup_btn.Text = "Đăng ký";
            this.signup_btn.UseVisualStyleBackColor = true;
            // 
            // qLDatVaChuyenHangDataSet
            // 
            this.qLDatVaChuyenHangDataSet.DataSetName = "QLDatVaChuyenHangDataSet";
            this.qLDatVaChuyenHangDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // qLDatVaChuyenHangDataSetBindingSource
            // 
            this.qLDatVaChuyenHangDataSetBindingSource.DataSource = this.qLDatVaChuyenHangDataSet;
            this.qLDatVaChuyenHangDataSetBindingSource.Position = 0;
            // 
            // DoiTac
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(586, 275);
            this.Controls.Add(this.panel1);
            this.Name = "DoiTac";
            this.Text = "DoiTac";
            this.Load += new System.EventHandler(this.DoiTac_Load);
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDatVaChuyenHangDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.qLDatVaChuyenHangDataSetBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button LapHD_btn;
        private System.Windows.Forms.Button validate_btn;
        private System.Windows.Forms.TextBox MST_textbox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button signup_btn;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource qLDatVaChuyenHangDataSetBindingSource;
        private QLDatVaChuyenHangDataSet qLDatVaChuyenHangDataSet;
    }
}