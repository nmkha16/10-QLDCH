USE [QLDatVaChuyenHang]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_TONGTIEN] ON [dbo].[DH_SP]
FOR INSERT, UPDATE
AS
BEGIN
	update DonHang
	set TongTien = (
		SELECT SUM(DH_SP.ThanhTien)
		FROM DH_SP
		WHERE DONHANG.MaDonHang = DH_SP.MaDonHang	
	) + DONHANG.PhiVanChuyen
END

GO
Create trigger [dbo].[trg_SOCHINHANH] on [dbo].[ChiNhanh]
FOR INSERT, UPDATE, Delete
AS
Begin
	update DOITAC
	set SoChiNhanh = (
	SELECT COUNT(CHINHANH.MaChiNhanh) from CHINHANH
	where CHINHANH.MaDT = DOITAC.MaDT
	)
END

GO
CREATE TRIGGER [dbo].[trg_ThanhTien_TenSP] on [dbo].[DH_SP]
FOR INSERT, UPDATE, DELETE
AS
Begin
	Begin
	update DH_SP
	set ThanhTien = (
		Select SANPHAM.DonGia from SANPHAM
		where SANPHAM.MaSanPham = DH_SP.MaSanPham
		) * DH_SP.SoLuong
	End
	Begin
	update DH_SP
	set TenSanPham = (
		Select SANPHAM.TenSanPham from SANPHAM
		where SANPHAM.MaSanPham = DH_SP.MaSanPham
		)
	End
END



