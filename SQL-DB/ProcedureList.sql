﻿--Tao HD
CREATE PROCEDURE SP_TaoHopDong(@MaHD int,@NguoiDaiDien char(30),@TinhTrangKichHoat char (3),@PhiHoaHong int,@NgayHetHan date,@PhanTramHoaHong int)
AS
BEGIN
 INSERT INTO HOPDONG(MaHD,NguoiDaiDien,TinhTrangKichHoat,PhiHoaHong,NgayHetHan,PhanTramHoaHong)
 VALUES (@MaHD,@NguoiDaiDien,@TinhTrangKichHoat,@PhiHoaHong,@NgayHetHan,@PhanTramHoaHong)
END
GO
--SuaSanPham
CREATE PROCEDURE SP_SuaSanPham(@MaSanPham int,@MaChiNhanh int,@MaDT int,@TenSanPham char(30),@DonGia int)
AS
BEGIN
	UPDATE SANPHAM
	SET MaChiNhanh=@MaChiNhanh,
		MaDT=@MaDT,
		TenSanPham=@TenSanPham,
		DonGia=@DonGia
	WHERE MaSanPham=@MaSanPham
END
GO
--DangKyTaiXe
CREATE PROCEDURE SP_DangKyTaiXe(@MaTaiXe int,@CMND int,@HoTen char(30),@SDT int,@DiaChi char(30),@BienSoXe char(30),@KhuVucHoatDong char(30),@Email char(30),@SoTaiKhoanNganHang int,@PhiThueChan char(30),@KhuVucDangKy char(3))
AS
BEGIN
	INSERT INTO TAIXE(MaTaiXe,CMND,HoTen,SDT,DiaChi,BienSoXe,KhuVucHoatDong,Email,SoTaiKhoanNganHang,PhiThueChan,KhuVucDangKy)
	VALUES(@MaTaiXe,@CMND,@HoTen,@SDT,@DiaChi,@BienSoXe,@KhuVucHoatDong,@Email,@SoTaiKhoanNganHang,@PhiThueChan,@KhuVucDangKy)
END
GO


--DangKyDoiTac
--DROP PROC SP_DangKyDoiTa
GO
CREATE PROC SP_DangKyDoiTac(@MaSoThue int, @TenDT varchar(50), @NguoiDaiDien varchar(50), @ThanhPho varchar(50), 
							@Quan varchar(50), @SoChiNhanh int, @SoDonTrongNgay int, @LoaiVanChuyen char(20), @SDT char(10), @Email char(50))
AS 
BEGIN
	INSERT INTO DOITAC (MaSoThue, TenDT, NguoiDaiDien, ThanhPho, Quan, SoChiNhanh, SoDonTrongNgay, LoaiVanChuyen, SDT, Email)
				VALUES (@MaSoThue, @TenDT, @NguoiDaiDien, @ThanhPho, @Quan, @SoChiNhanh, @SoDonTrongNgay, @LoaiVanChuyen, @SDT, @Email)
END


--TaiKyHopDong
--DROP PROC SP_TaiKyHopDong
GO
CREATE PROC SP_TaiKyHopDong(@MaHD int)
AS
BEGIN
	UPDATE HOPDONG 
	SET TinhTrangKichHoat = 'YES'
	WHERE @MaHD = MaHD
	UPDATE HOPDONG
	SET NgayHetHan = DATEADD(YEAR, 2, HOPDONG.NgayHetHan)
	WHERE @MaHD = MaHD
END


--ThemSanPham
--DROP PROC SP_ThemSanPham
GO 
CREATE PROC SP_ThemSanPham(@MaChiNhanh int,  @MaDT int, @TenSanPham varchar(50), @PhiSanPham int) 
AS
BEGIN
	INSERT INTO SANPHAM(MaChiNhanh, MaDT, TenSanPham, PhiSanPham)
				VALUES (@MaChiNhanh, @MaDT, @TenSanPham, @PhiSanPham)
END


--XemDonHang
--DROP PROC SP_XemDonHang
GO 
CREATE PROC SP_XemDonHang(@MaDH int)
AS
BEGIN
	SELECT * FROM DONHANG WHERE MaDonHang = @MaDH
END

--DangKyKhachHang
--DROP PROC SP_DangKyKhachHang
GO 
CREATE PROC SP_DangKyKhachHang(@HoTen varchar(50), @SDT char(10), @DiaChi varchar(100), @Email char(50))
AS 
BEGIN
	INSERT INTO KHACHHANG(HoTen, SDT, DiaChi, Email)
				VALUES (@HoTen, @SDT, @DiaChi, @Email)
END

--XemDSDonHangDaGiao
--DROP PROC SP_XemDSDonHangDaGiao
GO 
CREATE PROC SP_XemDSDonHangDaGiao
AS
BEGIN
	SELECT * FROM DONHANG 
	WHERE TinhTrangDonHang = 'DAGIAO'
END

--SuaSanPham
--DROP PROC SP_SuaSanPham
GO
CREATE PROC SP_SuaSanPham(@MaSanPham int, @MaChiNhanh int, @MaDT int, @TenSanPham varchar(50), @PhiSanPham int)
AS
BEGIN
	UPDATE SANPHAM
	SET MaChiNhanh = @MaChiNhanh,
		MaDT = @MaDT,
		TenSanPham = @TenSanPham,
		PhiSanPham = @PhiSanPham
	WHERE MaSanPham = @MaSanPham
END

--DangKyChiNhanh
CREATE PROCEDURE SP_DangKyChiNhanh(@MaChiNhanh int,@MaDT int,@DiaChi char (50))
AS
BEGIN
 INSERT INTO CHINHANH(MaChiNhanh,MaDT,DiaChi)
 VALUES (@MaChiNhanh,@MaDT,@DiaChi)
END

GO
--XemDSHopDong
CREATE PROCEDURE SP_XemDSHopDong
AS
BEGIN
	SELECT * FROM HOPDONG
END
GO
--XoaSanPham
CREATE PROCEDURE SP_XoaSanPham(@MaSanPham int,@MaChiNhanh int,@MaDT int)
AS
BEGIN
	DELETE SANPHAM(MaSanPham,MaChiNhanh,MaDT)
END
GO
--CapNhatDonHang
CREATE PROCEDURE SP_CapNhatDonHang(@MaDonHang int,@TinhTrangDonHang char(20))
AS
BEGIN
	UPDATE DONHANG
	SET TinhTrangDonHang = @TinhTrangDonHang
	WHERE MaDonHang = @MaDonHang
END
GO
--XemDSDoiTac
CREATE PROCEDURE SP_XemDSDoiTac
AS
BEGIN
	SELECT * FROM DOITAC
END
GO
--DuyetHopDong
CREATE PROCEDURE SP_DuyetHopDong(@MaHD int,@TinhTrangKichHoat char(10))
AS
BEGIN
	UPDATE HOPDONG
	SET TinhTrangKichHoat = @TinhTrangKichHoat
	WHERE MaHD = @MaHD
END
GO
