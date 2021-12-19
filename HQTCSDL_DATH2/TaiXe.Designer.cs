namespace HQTCSDL_DATH2
{
    partial class TaiXe
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
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.DT_bt = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.validate_btn = new System.Windows.Forms.Button();
            this.textBoxTaixe = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.signup_btn = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dataGridView1);
            this.panel1.Controls.Add(this.DT_bt);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.validate_btn);
            this.panel1.Controls.Add(this.textBoxTaixe);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.signup_btn);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Margin = new System.Windows.Forms.Padding(4);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(620, 277);
            this.panel1.TabIndex = 1;
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(-9, 64);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(626, 150);
            this.dataGridView1.TabIndex = 6;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // DT_bt
            // 
            this.DT_bt.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DT_bt.Location = new System.Drawing.Point(247, 236);
            this.DT_bt.Margin = new System.Windows.Forms.Padding(4);
            this.DT_bt.Name = "DT_bt";
            this.DT_bt.Size = new System.Drawing.Size(100, 28);
            this.DT_bt.TabIndex = 5;
            this.DT_bt.Text = "Doanh thu";
            this.DT_bt.UseVisualStyleBackColor = true;
            this.DT_bt.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(60, 235);
            this.button1.Margin = new System.Windows.Forms.Padding(4);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(100, 28);
            this.button1.TabIndex = 4;
            this.button1.Text = "Tiếp nhận";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // validate_btn
            // 
            this.validate_btn.Location = new System.Drawing.Point(484, 20);
            this.validate_btn.Margin = new System.Windows.Forms.Padding(4);
            this.validate_btn.Name = "validate_btn";
            this.validate_btn.Size = new System.Drawing.Size(100, 25);
            this.validate_btn.TabIndex = 3;
            this.validate_btn.Text = "Kiểm tra";
            this.validate_btn.UseVisualStyleBackColor = true;
            this.validate_btn.Click += new System.EventHandler(this.validate_btn_Click);
            // 
            // textBoxTaixe
            // 
            this.textBoxTaixe.Location = new System.Drawing.Point(117, 23);
            this.textBoxTaixe.Margin = new System.Windows.Forms.Padding(4);
            this.textBoxTaixe.Name = "textBoxTaixe";
            this.textBoxTaixe.Size = new System.Drawing.Size(322, 22);
            this.textBoxTaixe.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(57, 27);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 16);
            this.label1.TabIndex = 1;
            this.label1.Text = "CMND";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // signup_btn
            // 
            this.signup_btn.Location = new System.Drawing.Point(443, 236);
            this.signup_btn.Margin = new System.Windows.Forms.Padding(4);
            this.signup_btn.Name = "signup_btn";
            this.signup_btn.Size = new System.Drawing.Size(100, 28);
            this.signup_btn.TabIndex = 0;
            this.signup_btn.Text = "Đăng ký";
            this.signup_btn.UseVisualStyleBackColor = true;
            this.signup_btn.Click += new System.EventHandler(this.signup_btn_Click);
            // 
            // TaiXe
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(620, 277);
            this.Controls.Add(this.panel1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "TaiXe";
            this.Text = "TaiXe";
            this.Load += new System.EventHandler(this.TaiXe_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button DT_bt;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button validate_btn;
        private System.Windows.Forms.TextBox textBoxTaixe;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button signup_btn;
        private System.Windows.Forms.DataGridView dataGridView1;
    }
}