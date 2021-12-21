namespace HQTCSDL_DATH2
{
    partial class DoiTac_SuaSP
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
            this.label1 = new System.Windows.Forms.Label();
            this.textBoxMasp = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.textBoxdg = new System.Windows.Forms.TextBox();
            this.textBoxtensp = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(44, 46);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(91, 16);
            this.label1.TabIndex = 0;
            this.label1.Text = "Mã Sản Phẩm";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // textBoxMasp
            // 
            this.textBoxMasp.Location = new System.Drawing.Point(177, 46);
            this.textBoxMasp.Name = "textBoxMasp";
            this.textBoxMasp.Size = new System.Drawing.Size(221, 22);
            this.textBoxMasp.TabIndex = 2;
            this.textBoxMasp.TextChanged += new System.EventHandler(this.textBoxMasp_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(44, 128);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(0, 16);
            this.label3.TabIndex = 3;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(44, 94);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(96, 16);
            this.label4.TabIndex = 4;
            this.label4.Text = "Tên Sản Phẩm";
            // 
            // textBoxdg
            // 
            this.textBoxdg.Location = new System.Drawing.Point(177, 141);
            this.textBoxdg.Name = "textBoxdg";
            this.textBoxdg.Size = new System.Drawing.Size(100, 22);
            this.textBoxdg.TabIndex = 5;
            // 
            // textBoxtensp
            // 
            this.textBoxtensp.Location = new System.Drawing.Point(177, 94);
            this.textBoxtensp.Name = "textBoxtensp";
            this.textBoxtensp.Size = new System.Drawing.Size(100, 22);
            this.textBoxtensp.TabIndex = 6;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(44, 147);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(55, 16);
            this.label5.TabIndex = 7;
            this.label5.Text = "Đơn Giá";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(252, 213);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(146, 23);
            this.button1.TabIndex = 8;
            this.button1.Text = "Sửa sản phẩm";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(47, 213);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 9;
            this.button2.Text = "Hủy";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // DoiTac_SuaSP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(458, 272);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.textBoxtensp);
            this.Controls.Add(this.textBoxdg);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.textBoxMasp);
            this.Controls.Add(this.label1);
            this.Name = "DoiTac_SuaSP";
            this.Text = "DoiTac_SuaSP";
            this.Load += new System.EventHandler(this.DoiTac_SuaSP_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBoxMasp;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBoxdg;
        private System.Windows.Forms.TextBox textBoxtensp;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
    }
}