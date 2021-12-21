namespace HQTCSDL_DATH2
{
    partial class Interface
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
            this.id_lbl = new System.Windows.Forms.Label();
            this.login_btn = new System.Windows.Forms.Button();
            this.pass_lbl = new System.Windows.Forms.Label();
            this.Role_box = new System.Windows.Forms.ComboBox();
            this.ID_box = new System.Windows.Forms.TextBox();
            this.Password_box = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.Back_btn = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // id_lbl
            // 
            this.id_lbl.AutoSize = true;
            this.id_lbl.Location = new System.Drawing.Point(30, 46);
            this.id_lbl.Name = "id_lbl";
            this.id_lbl.Size = new System.Drawing.Size(18, 13);
            this.id_lbl.TabIndex = 0;
            this.id_lbl.Text = "ID";
            this.id_lbl.Click += new System.EventHandler(this.label1_Click);
            // 
            // login_btn
            // 
            this.login_btn.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.login_btn.Location = new System.Drawing.Point(143, 98);
            this.login_btn.Name = "login_btn";
            this.login_btn.Size = new System.Drawing.Size(70, 30);
            this.login_btn.TabIndex = 0;
            this.login_btn.Text = "Đăng nhập";
            this.login_btn.UseVisualStyleBackColor = true;
            this.login_btn.Click += new System.EventHandler(this.button1_Click);
            // 
            // pass_lbl
            // 
            this.pass_lbl.AutoSize = true;
            this.pass_lbl.Location = new System.Drawing.Point(30, 72);
            this.pass_lbl.Name = "pass_lbl";
            this.pass_lbl.Size = new System.Drawing.Size(52, 13);
            this.pass_lbl.TabIndex = 1;
            this.pass_lbl.Text = "Mật khẩu";
            this.pass_lbl.Click += new System.EventHandler(this.pass_lbl_Click);
            // 
            // Role_box
            // 
            this.Role_box.FormattingEnabled = true;
            this.Role_box.Location = new System.Drawing.Point(99, 12);
            this.Role_box.Name = "Role_box";
            this.Role_box.Size = new System.Drawing.Size(104, 21);
            this.Role_box.TabIndex = 1;
            this.Role_box.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // ID_box
            // 
            this.ID_box.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ID_box.Location = new System.Drawing.Point(99, 46);
            this.ID_box.Name = "ID_box";
            this.ID_box.Size = new System.Drawing.Size(169, 20);
            this.ID_box.TabIndex = 2;
            this.ID_box.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // Password_box
            // 
            this.Password_box.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.Password_box.Location = new System.Drawing.Point(99, 72);
            this.Password_box.Name = "Password_box";
            this.Password_box.PasswordChar = '*';
            this.Password_box.Size = new System.Drawing.Size(169, 20);
            this.Password_box.TabIndex = 3;
            this.Password_box.TextChanged += new System.EventHandler(this.textBox2_TextChanged);
            // 
            // panel1
            // 
            this.panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panel1.Controls.Add(this.Back_btn);
            this.panel1.Controls.Add(this.Password_box);
            this.panel1.Controls.Add(this.ID_box);
            this.panel1.Controls.Add(this.Role_box);
            this.panel1.Controls.Add(this.pass_lbl);
            this.panel1.Controls.Add(this.login_btn);
            this.panel1.Controls.Add(this.id_lbl);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(330, 149);
            this.panel1.TabIndex = 4;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // Back_btn
            // 
            this.Back_btn.Location = new System.Drawing.Point(12, 10);
            this.Back_btn.Name = "Back_btn";
            this.Back_btn.Size = new System.Drawing.Size(70, 23);
            this.Back_btn.TabIndex = 5;
            this.Back_btn.Text = "Trở về";
            this.Back_btn.UseVisualStyleBackColor = true;
            this.Back_btn.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // Interface
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(330, 149);
            this.Controls.Add(this.panel1);
            this.Name = "Interface";
            this.Text = "Interface";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label id_lbl;
        private System.Windows.Forms.Button login_btn;
        private System.Windows.Forms.Label pass_lbl;
        private System.Windows.Forms.ComboBox Role_box;
        private System.Windows.Forms.TextBox ID_box;
        private System.Windows.Forms.TextBox Password_box;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button Back_btn;
    }
}

