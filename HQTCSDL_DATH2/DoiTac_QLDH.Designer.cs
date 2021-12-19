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
            this.TTDH_comboBox = new System.Windows.Forms.ComboBox();
            this.Update_btn = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.dataGridView_TTDH = new System.Windows.Forms.DataGridView();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_TTDH)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.AutoSize = true;
            this.panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panel1.Controls.Add(this.TTDH_comboBox);
            this.panel1.Controls.Add(this.Update_btn);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.dataGridView_TTDH);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(702, 306);
            this.panel1.TabIndex = 0;
            // 
            // TTDH_comboBox
            // 
            this.TTDH_comboBox.FormattingEnabled = true;
            this.TTDH_comboBox.Items.AddRange(new object[] {
            "CHUAGIAO",
            "DAGIAO"});
            this.TTDH_comboBox.Location = new System.Drawing.Point(170, 23);
            this.TTDH_comboBox.Name = "TTDH_comboBox";
            this.TTDH_comboBox.Size = new System.Drawing.Size(121, 21);
            this.TTDH_comboBox.TabIndex = 5;
            // 
            // Update_btn
            // 
            this.Update_btn.Location = new System.Drawing.Point(310, 21);
            this.Update_btn.Name = "Update_btn";
            this.Update_btn.Size = new System.Drawing.Size(75, 23);
            this.Update_btn.TabIndex = 4;
            this.Update_btn.Text = "Cập nhật";
            this.Update_btn.UseVisualStyleBackColor = true;
            this.Update_btn.Click += new System.EventHandler(this.Update_btn_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(35, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(130, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Tình trạng giao hàng";
            // 
            // dataGridView_TTDH
            // 
            this.dataGridView_TTDH.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView_TTDH.Location = new System.Drawing.Point(12, 57);
            this.dataGridView_TTDH.Name = "dataGridView_TTDH";
            this.dataGridView_TTDH.RowHeadersVisible = false;
            this.dataGridView_TTDH.Size = new System.Drawing.Size(677, 237);
            this.dataGridView_TTDH.TabIndex = 1;
            // 
            // DoiTac_QLDH
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(702, 306);
            this.Controls.Add(this.panel1);
            this.Name = "DoiTac_QLDH";
            this.Text = "DoiTac_QLDH";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_TTDH)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox TTDH_comboBox;
        private System.Windows.Forms.Button Update_btn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dataGridView_TTDH;
    }
}