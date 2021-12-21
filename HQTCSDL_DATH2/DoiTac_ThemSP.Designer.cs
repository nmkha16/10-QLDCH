namespace HQTCSDL_DATH2
{
    partial class DoiTac_ThemSP
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
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.tbmacn = new System.Windows.Forms.TextBox();
            this.tbmadt = new System.Windows.Forms.TextBox();
            this.tbtensp = new System.Windows.Forms.TextBox();
            this.tbdongia = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(39, 46);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(90, 16);
            this.label2.TabIndex = 1;
            this.label2.Text = "Mã Chi Nhánh";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(39, 89);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(76, 16);
            this.label3.TabIndex = 2;
            this.label3.Text = "Mã Đối Tác";
            this.label3.Click += new System.EventHandler(this.label3_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(39, 134);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(96, 16);
            this.label4.TabIndex = 3;
            this.label4.Text = "Tên Sản Phẩm";
            this.label4.Click += new System.EventHandler(this.label4_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(39, 177);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(55, 16);
            this.label5.TabIndex = 4;
            this.label5.Text = "Đơn Giá";
            this.label5.Click += new System.EventHandler(this.label5_Click);
            // 
            // tbmacn
            // 
            this.tbmacn.Location = new System.Drawing.Point(166, 40);
            this.tbmacn.Name = "tbmacn";
            this.tbmacn.Size = new System.Drawing.Size(228, 22);
            this.tbmacn.TabIndex = 6;
            this.tbmacn.TextChanged += new System.EventHandler(this.tbmacn_TextChanged);
            // 
            // tbmadt
            // 
            this.tbmadt.Location = new System.Drawing.Point(166, 83);
            this.tbmadt.Name = "tbmadt";
            this.tbmadt.Size = new System.Drawing.Size(228, 22);
            this.tbmadt.TabIndex = 7;
            this.tbmadt.TextChanged += new System.EventHandler(this.tbmadt_TextChanged);
            // 
            // tbtensp
            // 
            this.tbtensp.Location = new System.Drawing.Point(166, 128);
            this.tbtensp.Name = "tbtensp";
            this.tbtensp.Size = new System.Drawing.Size(228, 22);
            this.tbtensp.TabIndex = 8;
            this.tbtensp.TextChanged += new System.EventHandler(this.tbtensp_TextChanged);
            // 
            // tbdongia
            // 
            this.tbdongia.Location = new System.Drawing.Point(166, 171);
            this.tbdongia.Name = "tbdongia";
            this.tbdongia.Size = new System.Drawing.Size(228, 22);
            this.tbdongia.TabIndex = 9;
            this.tbdongia.TextChanged += new System.EventHandler(this.tbdongia_TextChanged);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(244, 253);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(150, 23);
            this.button1.TabIndex = 10;
            this.button1.Text = "Thêm Sản Phẩm";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(42, 253);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(122, 23);
            this.button2.TabIndex = 11;
            this.button2.Text = "Hủy";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // DoiTac_ThemSP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(454, 306);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tbdongia);
            this.Controls.Add(this.tbtensp);
            this.Controls.Add(this.tbmadt);
            this.Controls.Add(this.tbmacn);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Name = "DoiTac_ThemSP";
            this.Text = "DoiTac_ThemSP";
            this.Load += new System.EventHandler(this.DoiTac_ThemSP_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbmacn;
        private System.Windows.Forms.TextBox tbmadt;
        private System.Windows.Forms.TextBox tbtensp;
        private System.Windows.Forms.TextBox tbdongia;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
    }
}