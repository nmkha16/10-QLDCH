USE QLDatVaChuyenHang

--Đối tác
CREATE LOGIN DoiTac
    WITH PASSWORD = 'DoiTac';
GO
CREATE USER DoiTac FOR LOGIN DoiTac
GO


exec sp_addrole 'Role_DoiTac'
exec sp_addrolemember 'Role_DoiTac','DoiTac'

--Tài xế
CREATE LOGIN TaiXe
    WITH PASSWORD = 'TaiXe';
GO
CREATE USER TaiXe FOR LOGIN TaiXe
GO
exec sp_addrole 'Role_TaiXe'
exec sp_addrolemember 'Role_TaiXe','TaiXe'

--Sản phẩm
CREATE LOGIN SanPham
    WITH PASSWORD = 'SanPham';
GO
CREATE USER SanPham FOR LOGIN SanPham
GO
exec sp_addrole 'Role_SanPham'
exec sp_addrolemember 'Role_SanPham','SanPham'


--Đơn hàng
CREATE LOGIN DonHang
    WITH PASSWORD = 'DonHang';
GO
CREATE USER DonHang FOR LOGIN DonHang
GO
-- Add role khach hang
exec sp_addrole 'Role_DonHang'
exec sp_addrolemember 'Role_DonHang','DonHang'



-- DT thêm xóa sửa thông tin SP
GRANT Select, Insert, Delete, Update
on SANPHAM
to Role_DoiTac

--DT xem thông tin DH và cập nhật tình trạng DH
GRANT Select, Update 
on DONHANG
to Role_DoiTac

-- TX theo dõi đơn hàng và cập nhật tình trạng DH
GRANT Select, Update
on DONHANG
to Role_TaiXe


--------------------------------
----------KHÁCH HÀNG----------

-- Các quyền của khách hàng:
--		select on SANPHAM
--		select on DONHANG
--		select on KHACHHANG
--      select on GIOHANG

-- Add KhachHang login account
CREATE LOGIN KhachHang
	WITH PASSWORD = 'ThuongDe';
GO
CREATE USER KhachHang FOR LOGIN KhachHang
GO

-- Add role khach hang
exec sp_addrole 'Role_KhachHang'
exec sp_addrolemember 'Role_KhachHang','KhachHang'

--SELECT ON SANPHAM
GRANT SELECT
ON OBJECT::SANPHAM
TO Role_KhachHang

-- SELECT ON DON HANG
GRANT SELECT
ON OBJECT::DONHANG
to Role_KhachHang

--SELECT ON GIOHANG
GRANT SELECT
ON OBJECT::GIOHANG
to Role_KhachHang

-- SELECT ON DOITAC
GRANT SELECT
ON OBJECT::DOITAC(TenDT, ThanhPho, Quan, SoChiNhanh, LoaiVanChuyen, SDT, Email)
TO Role_KhachHang


----------NHÂN VIÊN----------

-- Các quyền của nhân viên:
--		select, update, insert on HOPDONG
--		select on DOITAC

-- Add NhanVien login account
CREATE LOGIN NhanVien
	WITH PASSWORD = 'Sasuke';
GO
CREATE USER NhanVien FOR LOGIN NhanVien
GO

-- Add role nhan vien
exec sp_addrole 'Role_NhanVien'
exec sp_addrolemember 'Role_NhanVien','NhanVien'

--select, insert, update on HOPDONG
GRANT SELECT 
ON OBJECT::HOPDONG
TO Role_NhanVien

--select on DOITAC
GRANT SELECT 
ON OBJECT::DOITAC
TO Role_NhanVien


----------ADMINISTRATOR----------

--Create Administrator login account
CREATE LOGIN Administrator
	WITH PASSWORD = 'meowmeow';
GO
CREATE USER Administrator FOR LOGIN Administrator
GO

--Add role administrator
exec sp_addrole 'Role_Administrator'
exec sp_addrolemember 'Role_Administrator','Administrator'

--Cấp toàn quyền thao tác trên database cho Administrator
--	Vì cú pháp "GRANT ALL..." bị lỗi "The ALL permission is deprecated and maintained only for compatibility. 
--	It DOES NOT imply ALL permissions defined on the entity." nên sẽ cấp từng quyền cho Administrator
GRANT INSERT, SELECT, UPDATE, DELETE, REFERENCES, BACKUP DATABASE, 
	BACKUP LOG, CREATE DATABASE, CREATE DEFAULT, CREATE FUNCTION, 
	CREATE PROCEDURE,CREATE RULE, CREATE TABLE, CREATE VIEW 
TO Role_Administrator

