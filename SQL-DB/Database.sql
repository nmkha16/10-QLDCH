go
create database QLDatVaChuyenHang
go
use QLDatVaChuyenHang

--drop database QLDatVaChuyenHang 


-- Tạo table cho đối tác
create table DOITAC(
	MaDT int not null identity(1,1) primary key,
	MaSoThue int,
	TenDT varchar(50),
	NguoiDaiDien varchar(50),
	ThanhPho varchar(50),
	Quan varchar(50),
	SoChiNhanh int,
	SoDonTrongNgay int,
	LoaiVanChuyen char(20),
	SDT char(10),
	PhanTramHoaHong int,
	Email char(50),
	Unique (MaSoThue)
	)

-- Tạo table cho chi nhánh
create table CHINHANH(
	MaChiNhanh int not null identity(1,1),
	MaDT int,
	DiaChi varchar(100)
	unique (DiaChi),
	primary key (MaChiNhanh, MaDT)
)

-- Tạo table cho hợp đồng
create table HOPDONG(
	MaHD int not null identity(1,1) primary key,
	MaSoThue int,
	MaDT int,
	NguoiDaiDien varchar(50),
	TinhTrangKichHoat char(10),
	PhiHoaHong int,
	NgayHetHan date,
	PhanTramHoaHong int
)

-- Tạo table cho HD_DT
create table HD_DT(
	MaHD int,
	MaDT int,
	MaChiNhanh int
)

-- Tạo table cho Khách hàng
create table KHACHHANG(
	MaKhachHang int not null identity(1,1) primary key,
	HoTen varchar(50),
	SDT char(10),
	DiaChi varchar(100),
	Email char(50)
)

-- Tạo table cho sản phẩm
create table SANPHAM(
	MaSanPham int not null identity(1,1) primary key,
	MaChiNhanh int,
	MaDT int,
	TenSanPham varchar(50),
	DonGia int
)


-- Tạo table cho đơn hàng
create table DONHANG(
	MaDonHang int not null identity(1,1) primary key,
	MaDT int,
	MaTaiXe int,
	MaKhachHang int,
	TongTien int,
	HinhThucThanhToan char(10),
	DiaChiGiaoHang varchar(100),
	PhiVanChuyen int,
	TinhTrangDonHang char(10),
	KhuVuc varchar(50)
)

-- Tạo table cho DH_SP
create table DH_SP(
	MaDonHang int,
	MaSanPham int,
	TenSanPham varchar(50),
	SoLuong int,
	ThanhTien int
)

-- Tạo table cho tài xế
create table TAIXE(
	MaTaiXe int not null identity(1,1) primary key,
	CMND int,
	HoTen varchar(50),
	SDT char(10),
	DiaChi varchar(100),
	BienSoXe char(20),
	KhuVucHoatDong varchar(50),
	Email char(50),
	SoTaiKhoanNganHang char(20),
	PhiThueChan int,
	KhuVucDangKy varchar(50),
	unique(CMND)
)

-- Tạo table cho admin
create table Administrator(
	UserID int not null identity(1,1) primary key,
	HoTen varchar(50),
	Password char(20),
	NgaySinh date,
	TinhTrang char(10)
	)

-- Tạo table cho Nhân viên
create table NHANVIEN(
	MaNV int not null identity(1,1) primary key,
	HoTen varchar(50),
	Password char(20),
	NgaySinh date,
	TinhTrang char(10)
)

---- tạo table cho thông báo
--create table THONGBAO(
--	MaNV char(10),
--	MaSoThue char(10),
--	MaDT char(10),
--	foreign key (MaNV) references NHANVIEN(MaNV),
--	foreign key(MaSoThue) references HOPDONG(MaSoThue),
--	foreign key (MaDT) references DOITAC(MaDT)
--)

-- tạo khoá ngoại CHINHANH.MADT -> DOITAC.MADT
alter table CHINHANH
	add constraint FK_CN_MADT_DT_MADT foreign key (MaDT)
	references DOITAC(MaDT)

-- tạo khoá ngoại HD_DT.MaHD -> HOPDONG.MaHD
alter table HD_DT
	add constraint FK_HD_DT_MAHD_HD_MAHD foreign key (MaHD)
	references HOPDONG(MaHD)

-- tạo khoá ngoại HOPDONG.MaSoThue -> DOITAC.MaSoThue
alter table HOPDONG
	add constraint FK_HD_MAST_DT_MAST foreign key (MaSoThue)
	references DOITAC(MaSoThue)

-- tạo khoá ngoại HOPDONG.MaDT -> DOITAC.MaDT
alter table HOPDONG
	add constraint FK_HD_MADT_DT_MADT foreign key(MaDT)
	references DOITAC(MaDT)

-- tạo khoá ngoại HD_DT.MaChiNhanh -> ChiNhanh.MaChiNhanh
alter table HD_DT
	add constraint FK_HD_DT_MACHINHANH_CN_MACHINHANH foreign key(MaChiNhanh,MaDT)
	references ChiNhanh(MaChiNhanh,MaDT)
	

-- tạo khoá ngoại SANPHAM.MaChiNhanh -> CHINHANH.MaChiNhanh
alter table SANPHAM
	add constraint FK_SP_MACHINHANH_CN_MACHINHANH foreign key (MaChiNhanh,MaDT)
	references CHINHANH(MaChiNhanh,MaDT)

-- tạo khoá ngoại SANPHAM.MaDT -> DOITAC.MaDT
--alter table SANPHAM
--	add constraint FK_SP_MADT_DT_MADT foreign key (MaDT)
--	references DOITAC(MaDT)

-- tạo khoá ngoại DonHang.MaDT -> DoiTac.MaDT
alter table DonHang
	add constraint FK_DH_MADT_DT_MADT foreign key(MaDT)
	references DoiTac(MaDT)

-- tạo khoá ngoại DonHang.MaTaiXe -> TaiXe.MaTaiXe
alter table DonHang
	add constraint FK_DH_MATAIXE_TX_MATAIXE foreign key(MaTaiXe)
	references TaiXe(MaTaiXe)

-- tạo khoá ngoại DonHang.MaKhachHang -> KhachHang.MaKhachHang
alter table DonHang
	add constraint FK_DH_MAKHACHHANG_KH_MAKHACHHANG foreign key(MaKhachHang)
	references KhachHang(MaKhachHang)


-- tạo khoá ngoại DH_Sp.MaDonHang -> DONHANG.MaDonHang
alter table DH_SP
	add constraint FK_DH_SP_MADONHANG_DH_MADONHANG foreign key(MaDonHang)
	references DONHANG(MaDonHang)

-- tạo khoá ngoại DH_SP.MaSanPham -> SanPham.MaSanPham
alter table DH_SP
	add constraint FK_DH_SP_MASANPHAM_SP_MASANPHAM foreign key (MaSanPham)
	references SanPham(MaSanPham)


--data
USE [QLDatVaChuyenHang]
GO
SET IDENTITY_INSERT [dbo].[DOITAC] ON 
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (1, 9445056, N'Raptinedgicator WorldWide ', N'Jarrod James', N'West Bromwich', N'Cockburnspath', 0, 76, N'NUOCUONG            ', N'8313111863', 13, N'ltpdugd640@lvld.le-avl.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (2, 8068358, N'Ciptumonower  ', N'Kimberley Faulkner', N'Portsmouth', N'Nine Elms', 0, 73, N'THUCPHAM            ', N'1921766186', 3, N'cajn13@hmhfad.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (3, 8647955, N'Advenentor  ', N'Gwendolyn Peck', N'Cambridge', N'Llandudno', 0, 192, N'NUOCUONG            ', N'3604219376', 1, N'gtis.fpndkrtrf@kucjtgqpk.qtedwr.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (4, 8067334, N'Rapvenefin Direct Corp.', N'Melanie Stevens', N'Manchester', N'Ellon', 2, 158, N'DUNGCU              ', N'9301437115', 6, N'vpkkdim.zdrqhzfrkh@mscfcov.zmzsli.net             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (5, 1547052, N'Emhupan  ', N'Lance Payne', N'St Helens', N'Highbury', 0, 86, N'NUOCUONG            ', N'9505776493', 11, N'zquxz4@itzmmk.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (6, 5960857, N'Trurobar Holdings ', N'Alison Boyd', N'Telford', N'Linton on-Swale', 0, 79, N'DIENTU              ', N'9278706151', 14, N'ixifb.mbmeze@prtmnm.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (7, 5602322, N'Lomerin International Company', N'Whitney Sims', N'Leicester', N'Lostwithiel', 1, 110, N'DUNGCU              ', N'2201151111', 13, N'rnpfbhla.savhtpagme@siknjvtx.fbuqrl.com           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (8, 9453077, N'Supmunanazz  ', N'Jaime Hines', N'Blackpool', N'Bournemouth', 1, 51, N'NUOCUONG            ', N'1414406673', 10, N'eplowm.ixemhzbx@gvoyp.raly-q.org                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (9, 2139130, N'Wintumin  Company', N'Lee Lloyd', N'Swindon', N'Newent', 0, 184, N'DIENTU              ', N'9407483018', 5, N'nriptsvw095@gaxhx.rafzdx.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (10, 2037924, N'Inpebonax  Inc', N'Lindsey Ritter', N'Huddersfield', N'Ventnor', 0, 142, N'DIENTU              ', N'3546813765', 12, N'ykrwazqr693@wrsghfy.idxupa.com                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (11, 5507045, N'Uppeban  ', N'Alan Mccoy', N'Walsall', N'Chislehurst', 2, 147, N'THUCPHAM            ', N'2452649646', 14, N'vawork4@ntqyvj.jhlqnu.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (12, 9272442, N'Monkilegin Holdings ', N'Demond May', N'Colchester', N'Prestatyn', 1, 79, N'DIENTU              ', N'9870752070', 10, N'hrceapw.ynuul@vdpkis.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (13, 7722753, N'Varkilin Direct Company', N'Lakeisha Shelton', N'Nottingham', N'Uttoxeter', 2, 80, N'DUNGCU              ', N'9632619357', 6, N'larhdemb.cklgczqe@gpuxsg.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (14, 2913779, N'Inpickax  ', N'Jocelyn Cooley', N'Slough', N'Dukinfield', 0, 87, N'DUNGCU              ', N'3476260044', 14, N'eoxpmzt.plqm@kjfspbqu.xevvft.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (15, 4548184, N'Zeevenanan Direct ', N'Emma Conley', N'Bristol', N'Shildon', 0, 63, N'DUNGCU              ', N'1309549245', 5, N'jcwz8@dcbsdnu.jomoeh.com                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (16, 9778132, N'Trutanefin Direct ', N'Alana Gill', N'Leeds', N'Oldham', 3, 189, N'THUCPHAM            ', N'0828188844', 13, N'srhey.aphjphyvh@yotmtrbmv.bgduhd.net              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (17, 4790542, N'Trujubilex WorldWide ', N'Clayton Reyes', N'Eastbourne', N'Dymock', 3, 55, N'THUCPHAM            ', N'1369944373', 7, N'phoj.dweebmsfid@agxqdlxyx.bogbd-.net              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (18, 4635266, N'Untumazz Holdings ', N'Andre Walker', N'Manchester', N'Queenborough', 1, 196, N'THUCPHAM            ', N'7794670055', 13, N'noqs@kjmx.ajhcmy.net                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (19, 1290671, N'Upcadedantor International ', N'Sheila Shea', N'Colchester', N'Wimborne', 0, 34, N'DIENTU              ', N'7212326668', 2, N'dmzdutpx.smipvkix@gaolakbfz.ratukb.com            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (20, 3778508, N'Hapsapplower  ', N'Katherine Odom', N'Northampton', N'Rhosgoch', 0, 118, N'DUNGCU              ', N'9862073496', 11, N'ocxylb.pmoxupxu@xnbksj.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (21, 9360517, N'Surnipistor  ', N'Lisa Clark', N'Swindon', N'Newport Pagnell', 2, 188, N'DIENTU              ', N'5656666315', 5, N'pqtnettu@pmrquprb.bdyxhd.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (22, 9949872, N'Trubanackistor WorldWide Group', N'Catherine Weber', N'Bournemouth', N'Ripon', 3, 70, N'THUCPHAM            ', N'5381794033', 15, N'dknalm0@eafzo.mkwlqc.net                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (23, 6910914, N'Parwerentor WorldWide ', N'Jo Dorsey', N'Cambridge', N'Alton', 0, 91, N'THUCPHAM            ', NULL, 13, N'wmmu.orhfn@cznzrg.net                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (24, 3072344, N'Fropickex WorldWide ', N'Marlene Delacruz', N'Blackpool', N'Wigton', 1, 144, N'DIENTU              ', N'3729754128', 11, N'dwek@-mhuco.net                                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (25, 7393091, N'Adwerpistor  ', N'Ismael Wiggins', N'Kingston upon Hull', N'Dagenham', 1, 108, N'THUCPHAM            ', N'5025150356', 12, N'wmmfm.muhj@myvvztqh.g-vmgs.org                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (26, 2712669, N'Redimedistor Direct ', N'Marc Boyer', N'Oldham', N'March', 3, 181, N'THUCPHAM            ', N'3016349457', 13, N'dpaw864@rpal.wonlzd.net                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (27, 2127397, N'Happebackover Direct Group', N'Stacie Mercer', N'Poole', N'Hindhead', 1, 55, N'DIENTU              ', N'2425326579', 11, N'jmfljzm81@lit-dn.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (28, 6678880, N'Winrobex International ', N'Emma Madden', N'Middlesbrough', N'Cleator', 3, 108, N'DIENTU              ', N'3211200928', 5, N'pugpn.ftyztq@-jglxp.com                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (29, 8289167, N'Klinipinantor  Corp.', N'Dominick O''Connell', N'Bradford', N'Ibstock', 1, 31, N'THOITRANG           ', N'7391309202', 13, N'wqwlf.vqmqtsy@jtanyd.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (30, 3009232, N'Lomfropicator  ', N'Clayton Riley', N'Northampton', N'Cairndow', 2, 163, N'THUCPHAM            ', N'7456113267', 3, N'ystqw11@zqemkhc.g-sxan.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (31, 7496580, N'Adglibiman International Company', N'Sheryl Huang', N'Slough', N'Brockenhurst', 1, 181, N'THOITRANG           ', N'2152593073', 15, N'dowtspdm895@orowff.qgvutt.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (32, 1057879, N'Adhupopazz  ', N'Wallace Bean', N'York', N'Westcliff-on-Sea', 1, 112, N'NUOCUONG            ', N'4281274529', 5, N'rcka3@jnsajm.vgmdfm.net                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (33, 9572523, N'Truquestonover International ', N'Sean Leonard', N'Nottingham', N'Morpeth', 0, 104, N'DUNGCU              ', N'5592762405', 10, N'wwxpyxv63@mszfjx.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (34, 7301208, N'Rapquestimazz International Corp.', N'Sonny Patton', N'Manchester', N'Brandon', 1, 60, N'THOITRANG           ', N'7149659768', 4, N'nhhur.gboejee@tjtnel.zspinn.net                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (35, 6766596, N'Cipquestan  ', N'Salvador Cortez', N'West Bromwich', N'Barnes', 2, 160, N'DIENTU              ', N'6139429315', 13, N'pfpj.ugyjdf@jkihimad.mayhbb.com                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (36, 6126050, N'Parpickexor International ', N'Ericka Tyler', N'Sheffield', N'Boat of Garten', 0, 64, N'THOITRANG           ', N'8584037008', 5, N'sdsp8@ycvdaf.org                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (37, 6455848, N'Hapmunaquin  ', N'Shari Branch', N'Birmingham', N'Surbiton', 2, 118, N'THOITRANG           ', N'9033020653', 1, N'jfagf@chqhsdhk.bjpdvn.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (38, 6969346, N'Unpickedicator  Corp.', N'Marshall Le', N'Telford', N'Forfar', 4, 152, N'THOITRANG           ', N'8549799044', 12, N'oxiumvs.wpsnr@ymmetf.net                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (39, 8743711, N'Klibanupazz Direct ', N'Nikki Gill', N'Manchester', N'Doncaster', 1, 137, N'NUOCUONG            ', N'1635236816', 3, N'tqdvee79@ckplxu.net                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (40, 5729918, N'Endtanor International ', N'Stuart Powers', N'Southend-on-Sea', N'Benfleet', 0, 68, N'NUOCUONG            ', N'6715539691', 14, N'srwknmg253@-vrxhn.com                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (41, 1955034, N'Qwiglibefover International ', N'Laura Cruz', N'Colchester', N'Peterlee', 1, 71, N'DIENTU              ', N'8477023582', 9, N'xpuyzmwa@vcush.yamnjn.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (42, 8954251, N'Endbanover Holdings ', N'Tomas Welch', N'Derby', N'Ludlow', 1, 53, N'THUCPHAM            ', N'9822349497', 15, N'kuuamlt.gqpnt@ypcf.yazppp.com                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (43, 9285905, N'Pardudistor International ', N'Kristy Arias', N'Liverpool', N'Merriott', 0, 159, N'THOITRANG           ', N'4473419384', 8, N'jggxq224@fhnbsd.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (44, 4562421, N'Truwerpedgicator WorldWide ', N'Monica Mccarty', N'Northampton', N'Ivybridge', 2, 150, N'DUNGCU              ', N'0850434596', 1, N'npulv78@wizk.jrxqis.com                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (45, 2762608, N'Emtumar International ', N'Claude Hammond', N'York', N'Chiswick', 2, 75, N'NUOCUONG            ', N'6743723590', 13, N'igtqnwxl@lucfq.kxqxpf.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (46, 6825539, N'Zeepebupar Holdings Inc', N'Andres Sutton', N'Bolton', N'Leamington Spa', 0, 78, N'DIENTU              ', N'9389382673', 14, N'sahnht.coqvfy@lnwpopo.aygtmk.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (47, 4609105, N'Embanexex International ', N'Charlie Kent', N'Cambridge', N'Charlton', 0, 180, N'THOITRANG           ', N'7359514816', 14, N'saewew.wuropuem@mckiydmp.hldery.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (48, 2324523, N'Resapupower Holdings ', N'Rita Cobb', N'Bolton', N'Newton Abbot', 3, 148, N'NUOCUONG            ', N'2166321161', 12, N'eupfoznt.acgu@fyncjb.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (49, 6539818, N'Surmunadar WorldWide ', N'Mandi Hancock', N'Ipswich', N'Rochdale', 0, 191, N'DIENTU              ', N'2226420212', 4, N'okfwro.lrasua@wocekn.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (50, 9442223, N'Rewerponantor  Group', N'Johnny Cisneros', N'Slough', N'Tring', 0, 59, N'THOITRANG           ', N'8466632767', 9, N'ruyuka.tfrduqbfyk@tbof-k.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (51, 5667291, N'Frotinexax  ', N'Tomas Stewart', N'Slough', N'Todmorden', 2, 51, N'THOITRANG           ', N'7427825193', 8, N'yvza2@eejyyz.com                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (52, 4272061, N'Tipsapantor WorldWide Corp.', N'Dorothy Pierce', N'Sheffield', N'Leatherhead', 1, 102, N'DUNGCU              ', N'2515315251', 12, N'uigmxha.upgsuz@cyfpyc.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (53, 3840561, N'Barbanedax WorldWide ', N'Lester Dunn', N'Leicester', N'Strathpeffer', 0, 82, N'DIENTU              ', N'6959441249', 8, N'psfgrvcz.dzianyepw@xkfp-u.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (54, 8404505, N'Emmunadistor Direct ', N'Francis Gallagher', N'Coventry', N'Fortrose', 1, 160, N'DUNGCU              ', N'1146108220', 6, N'tveviio.yzmgwo@ocjglj.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (55, 7335671, N'Tiptumicazz International Corp.', N'Sheri Weiss', N'Bristol', N'Dunkeld', 3, 150, N'DUNGCU              ', N'9789628935', 5, N'oshy.abqdky@sydoqxdka.julrqb.org                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (56, 4674135, N'Emdimantor Direct ', N'Lloyd Mooney', N'Stoke-on-Trent', N'Jarrow', 2, 35, N'THOITRANG           ', N'7067928257', 13, N'xauphw.ykqtdxqo@dxtjrdr.owdikm.net                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (57, 2292995, N'Surkilexentor International ', N'Regina Ochoa', N'Southend-on-Sea', N'New Quay', 0, 183, N'DIENTU              ', N'8607409800', 5, N'aegc.piysthum@hezj.nhpxwg.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (58, 7548252, N'Untumistor International ', N'Lester Johnson', N'Nottingham', N'Lyme Regis', 1, 78, N'NUOCUONG            ', N'1543202737', 5, N'pzdxdxmh@kkyjkp.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (59, 8990361, N'Grozapamover  ', N'Chanda Mc Neil', N'Colchester', N'Banbridge', 2, 79, N'THUCPHAM            ', N'6910422473', 10, N'gcgol86@znejt.iqorpy.com                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (60, 4514893, N'Frocadedover Holdings ', N'Edith Barajas', N'Birmingham', N'St. Andrews', 0, 105, N'THOITRANG           ', N'6700052443', 14, N'cgdjgngf@olvlq.czvuga.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (61, 8034286, N'Klidudadar WorldWide Corp.', N'Elizabeth Strickland', N'Bristol', N'Blantyre', 0, 53, N'DIENTU              ', N'4808437894', 3, N'bznaq@bimjrnu.gw-axu.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (62, 2540837, N'Thruwerpupicator Direct ', N'Tisha Ingram', N'Swindon', N'Fort William', 0, 32, N'DUNGCU              ', N'7244451665', 8, N'yvkhhybe.hrjgjwe@cdhlm.q-ddqd.org                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (63, 8840846, N'Tippickicor Holdings ', N'Alison Stanton', N'Sunderland', N'North Shields', 2, 50, NULL, N'6866809643', 12, N'yshldb28@duamexva.yqjyfq.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (64, 8458309, N'Embanor Direct Corp.', N'Damion Dunlap', N'Kingston upon Hull', N'Juniper Green', 1, 50, N'THOITRANG           ', N'9261801383', 2, N'awhc50@aqvwlgfxw.r-tidk.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (65, 2115900, N'Bartumilan  Group', N'Rachelle Norris', N'Slough', N'Sandhurst', 1, 162, N'THUCPHAM            ', N'5883690280', 12, N'xnwkekha.ximktwuje@dsiuzfac.xvkmdx.org            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (66, 7778815, N'Windudex International Corp.', N'Terrell Meyer', N'Slough', N'Cromer', 0, 64, N'NUOCUONG            ', N'9560698131', 10, N'mloki542@ougx.uvnpde.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (67, 1240422, N'Tuperefantor WorldWide ', N'Ronald Fields', N'West Bromwich', N'Bewdley', 2, 175, N'NUOCUONG            ', N'0530442206', 15, N'ygbx.vsexsnuuq@mytfkdpn.ibpzhf.org                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (68, 5253028, N'Truweramax  ', N'Autumn Sloan', N'Leicester', N'Shanklin', 2, 49, N'THOITRANG           ', N'1651128721', 2, N'kuzqma385@aefjrgnsn.ljiwtb.org                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (69, 4245499, N'Rapkilan Holdings ', N'Robbie Salazar', N'Leeds', N'Cockermouth', 0, 127, N'NUOCUONG            ', N'3921863492', 2, N'mghkvi.xibbgbcpjx@pztvwr.fccqae.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (70, 3483440, N'Barquestax Direct Company', N'Claudia Orr', N'Birmingham', N'Olney', 0, 200, N'NUOCUONG            ', N'4336884104', 15, N'etpixtrj4@gtnwsn.net                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (71, 2455301, N'Parhupor  ', N'Jayson Christian', N'Birmingham', N'Spalding', 1, 100, N'NUOCUONG            ', N'9518013851', 13, N'mmoevk.rawya@tomwyq.com                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (72, 9736312, N'Truvenantor  ', N'Wendi Baxter', N'Wolverhampton', N'West Wimbledon', 1, 103, N'THOITRANG           ', N'0125815958', 10, N'jtdykpuj.prhbebjv@pqyjix.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (73, 8076452, N'Endbanackazz Holdings Company', N'Holly Ibarra', N'Crawley', N'Huddersfield', 2, 89, N'DIENTU              ', N'5879604145', 11, N'frbvyhe4@xrfqkhosk.nb--os.net                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (74, 9624785, N'Surtanackentor WorldWide ', N'Chandra Pitts', N'Milton Keynes', N'Thetford', 1, 167, N'NUOCUONG            ', N'4023729199', 3, N'pmvmd.tszwtjxjl@kiyaja.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (75, 2464670, N'Montanollex International ', N'Angelia Benjamin', N'Preston', N'Askam-in-Furness', 1, 77, N'THOITRANG           ', N'1615517928', 3, N'dyvys9@hkmfjr.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (76, 6725398, N'Haphupefor Direct Group', N'Jake Tapia', N'Wolverhampton', N'Beckenham', 2, 165, N'DUNGCU              ', N'9705740157', 6, N'vqcqto3@ocupk.hyugkd.com                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (77, 5484505, N'Frofropover  ', N'Jeannie Salinas', N'Norwich', N'Bridge of Orchy', 1, 112, N'NUOCUONG            ', N'6797958496', 8, N'jdflfyhm.hrnfgmcdd@xnvcjbtu.klsnjk.org            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (78, 3380677, N'Uneraquax International ', N'Tyson Frey', N'Walsall', N'Lingfield', 1, 141, N'DIENTU              ', N'4597346931', 13, N'cnmbgoit721@fulqjivxo.ouuyzv.net                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (79, 1843830, N'Qwisipanentor Direct ', N'Stephanie Beck', N'Colchester', N'Rothes', 1, 98, N'NUOCUONG            ', N'2012482200', 14, N'ybqrfrz.bzancelm@uwvgpy.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (80, 4601288, N'Endpebewazz  ', N'Rogelio Drake', N'Southend-on-Sea', N'Redditch', 2, 59, N'THOITRANG           ', N'4294979099', 13, N'tmujg.gfknptrwyu@dmqjlf.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (81, 1834390, N'Repebonentor Holdings ', N'Marsha Garrett', N'Bristol', N'Harlow', 1, 31, N'THOITRANG           ', N'8372229148', 14, N'kbtatwaf6@mvy-zc.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (82, 6315667, N'Barquestantor  ', N'Tracy Harding', N'Blackburn', N'Sale', 3, 108, N'THOITRANG           ', N'7799068467', 15, N'axnsleec03@dlkust.com                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (83, 6639638, N'Upkilar  ', N'Gilbert Riddle', N'Oldham', N'Isle of Islay', 1, 118, N'THOITRANG           ', NULL, 2, N'jcej.sjmcsx@ghhrvcxh.hgwqlp.org                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (84, 5170067, N'Winmunistor  ', N'Carl Roman', N'Preston', N'Liverpool Street', 0, 172, N'DIENTU              ', N'9241046480', 5, N'kreokn53@zrzfzf.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (85, 6442300, N'Frowerponex  ', N'Leon Dyer', N'Oxford', N'Derby', 1, 142, N'DUNGCU              ', N'6093047292', 11, N'byjycn.vzgtirhfeq@fdgsdk.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (86, 2234123, N'Parsipollantor International ', N'Blake Young', N'West Bromwich', N'Minehead', 0, 108, N'THOITRANG           ', N'6917333175', 4, N'hprfm.miglxryr@-mhkta.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (87, 3067332, N'Parcadedor International Group', N'Ruth Greene', N'Poole', N'Bishop Auckland', 0, 60, N'THOITRANG           ', N'3398969134', 12, N'kgwrqu.gvfi@qhvxxexb.mspdyg.org                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (88, 1650380, N'Moneraquicator WorldWide Company', N'Maurice O''Neal', N'Sheffield', N'Derby', 3, 145, N'NUOCUONG            ', N'3658843327', 5, N'ohvcln.mvzlcl@twapwefmi.iy-psp.org                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (89, 3883587, N'Barjubover  Group', N'Ben Kane', N'London', N'St. Ives', 0, 111, N'DUNGCU              ', NULL, 15, N'ragefua39@almkag.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (90, 5649698, N'Raptumar Direct ', N'Donnell Watson', N'Southend-on-Sea', N'Lymm', 0, 154, N'THOITRANG           ', N'4638154042', 15, N'kcitm@bijtuf.net                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (91, 4460670, N'Zeetinor Direct ', N'Rafael Mercado', N'Huddersfield', N'Isle of Cumbrae', 0, 82, N'DUNGCU              ', N'0188987874', 1, N'rfprtw.shmnfq@shyxksq.nnfofk.org                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (92, 7356899, N'Tipzapicin International ', N'Neil Morrison', N'Gloucester', N'Derby', 0, 70, N'THOITRANG           ', N'8557232563', 11, N'rwkcayr@widrm.yamhyc.net                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (93, 6658266, N'Ciptinedgan Holdings Inc', N'Abraham Whitehead', N'Peterborough', N'Dudley', 1, 102, N'NUOCUONG            ', N'8129432892', 2, N'keeqzl283@luqrdiyu.iwtnhj.net                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (94, 9756411, N'Parvenepover International Group', N'Brad Harrington', N'Bristol', N'Ingatestone', 2, 61, N'DUNGCU              ', N'8692623356', 5, N'ssmm.mquqm@hhfulg.net                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (95, 2890491, N'Adpickaquentor Holdings ', N'Bennie Bonilla', N'Milton Keynes', N'Windermere', 1, 44, N'THUCPHAM            ', N'5651963144', 12, N'uuavo.wldxijdq@w-dais.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (96, 7035942, N'Adquestaquentor Holdings ', N'Christina Campbell', N'Preston', N'Fordingbridge', 1, 69, N'NUOCUONG            ', N'0276594211', 1, N'ubon.cwhyx@ayeui.omrdrm.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (97, 2540196, N'Fropebistor WorldWide ', N'Tammi Wolfe', N'Cambridge', N'Tunbridge Wells', 2, 32, N'DIENTU              ', N'2916781315', 3, N'gtokc.uttis@lcesh.vazgad.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (98, 7684695, N'Kliwericator Direct ', N'Claudia De Leon', N'Eastbourne', N'Brecon', 1, 139, N'DIENTU              ', N'0601261102', 7, N'cxwasg.snvxvgfklp@bpzzf.tdtgix.com                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (99, 7231507, N'Unkilupower Holdings ', N'Elisa Kaufman', N'Oxford', N'Peterhead', 0, 189, N'DUNGCU              ', N'2143460277', 5, N'svwiaay68@pwowlydl.xwutlr.com                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (100, 7125474, N'Surnipor WorldWide ', N'Jeannie Vazquez', N'Sutton Coldfield', N'Westcliff-on-Sea', 0, 41, N'DIENTU              ', N'5673962203', 4, N'dxhlnj.pfvsgicvre@kxznygya.fogyxm.net             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (101, 7661585, N'Dopsipollin Holdings Group', N'Raquel Ramirez', N'Blackburn', N'Hindhead', 1, 104, N'DIENTU              ', N'3992659117', 15, N'vbmauwsi.otydhjfbg@mhknoi.com                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (102, 2925111, N'Adsapamex International Group', N'Vicki Russo', N'Peterborough', N'Haverhill', 0, 160, N'DUNGCU              ', N'4970097986', 12, N'tivdtv@ahefak.ocgxsw.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (103, 2582600, N'Infropaquan Holdings ', N'Adriana Moreno', N'Oxford', N'Hitchin', 0, 50, N'THUCPHAM            ', N'7118229255', 10, N'iitbnfob.xtpf@mblfqphha.zeiq-l.com                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (104, 3197823, N'Monfropaquicator Holdings Corp.', N'Kerry Rowe', N'Blackpool', N'Barrhead', 1, 192, N'DUNGCU              ', N'9714241635', 5, N'lnjuqkmg166@dlrlb.s-l-gf.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (105, 5632126, N'Zeebanicazz  ', N'Raymond Church', N'Stockport', N'Belvedere', 1, 159, N'THOITRANG           ', N'5130851281', 12, N'dylen.urlas@bfkpokgf.amrrmx.net                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (106, 3324031, N'Pardudan  Corp.', N'Rachel Woods', N'Poole', N'Watford', 0, 148, N'DIENTU              ', N'8780060123', 13, N'eeogirm0@fkizo.gpqryk.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (107, 3315248, N'Tupsipackax WorldWide ', N'Paige Sharp', N'Sheffield', N'Beaconsfield', 1, 43, N'DIENTU              ', N'6938796951', 2, N'krvbhx.wowytnylyj@dpdsdn.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (108, 5876488, N'Adcadover Holdings Company', N'Janine Hoffman', N'York', N'Wickford', 1, 115, N'DIENTU              ', N'9061687744', 5, N'smfdithu7@doud.etreso.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (109, 1672049, N'Insiponex Holdings ', N'Nakia Simmons', N'Peterborough', N'Edenbridge', 1, 113, N'NUOCUONG            ', N'5345885534', 4, N'ktmcxt3@tqzgddkp.p-bkon.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (110, 2867036, N'Doperollax International Inc', N'Guillermo Jensen', N'Exeter', N'Cleator Moor', 3, 186, N'DIENTU              ', N'0185653916', 15, N'mmtq.inhfq@bsdkjz.org                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (111, 8545874, N'Qwisipover  Corp.', N'Julia Guerra', N'Stockport', N'Fintry', 2, 124, N'THOITRANG           ', N'5688336765', 6, N'ocizbv0@ljfxqr.org                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (112, 8111197, N'Parhupewantor International Group', N'Grant Barr', N'Liverpool', N'Bishopton', 2, 71, N'DIENTU              ', N'2127717582', 7, N'qsvxu.nhxzeocj@kqmzzv.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (113, 3793552, N'Hapmunilantor WorldWide ', N'Lindsay Atkins', N'Derby', N'St. Albans', 0, 180, N'THOITRANG           ', N'9041316864', 7, N'gotwv.gfpvt@kuicuc.ui-ime.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (114, 8962067, N'Rerobomman  ', N'Marilyn Mcintosh', N'Preston', N'Egham', 1, 49, N'THUCPHAM            ', N'9226319499', 13, N'urwpf.nrljgyimoe@gsrx.bikdsm.org                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (115, 4703484, N'Dopvenollistor Direct ', N'Dawn Everett', N'Blackburn', N'Hessle', 1, 104, N'DIENTU              ', N'7134312847', 15, N'rolxydy26@wjlwmd.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (116, 7115084, N'Gropickar Direct ', N'Gustavo Everett', N'Kingston upon Hull', N'Ferryhill', 2, 146, N'DUNGCU              ', N'4511162855', 3, N'uycuvnw@c-njxo.com                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (117, 1891828, N'Tuprobicentor International Corp.', N'Ramona Bentley', N'Poole', N'The Hyde', 2, 115, N'DUNGCU              ', N'9409442002', 7, N'gvymagqf.igia@qhccpb.net                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (118, 6568786, N'Thrutinimentor  Inc', N'Nina Fleming', N'Liverpool', N'Bothwell', 2, 78, N'DUNGCU              ', N'9933654781', 8, N'lnmkia.wdbowlcne@coov.aqsolm.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (119, 7551624, N'Klitanan Direct ', N'Belinda Blevins', N'Poole', N'Cheltenham', 0, 108, N'THOITRANG           ', N'6185270276', 6, N'vmbnugxy319@ffqyidwww.ihrgzv.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (120, 1258385, N'Qwidimilicator Holdings Inc', N'Thomas Archer', N'Leeds', N'Broseley', 1, 83, N'DIENTU              ', N'2803641621', 9, N'xsjkp.kzrn@eqqnjv.c-zpdv.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (121, 4919153, N'Groerar Direct ', N'Tammie Hall', N'Wolverhampton', N'Broxbourne', 2, 34, N'THOITRANG           ', N'6603819276', 13, N'fqlf.bsqvqxa@eir-er.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (122, 3879255, N'Bartumegower  ', N'Rolando Hurley', N'Bolton', N'Southgate', 1, 60, NULL, N'7336295084', 11, N'qzwow.fthae@ifdcyzrt.newtgl.net                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (123, 5945107, N'Winmunanex Direct Corp.', N'Clifford Herring', N'Manchester', N'Weston-super-Mare', 1, 138, N'DUNGCU              ', N'2638050031', 3, N'gewvfdy@wozsuy.org                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (124, 1583203, N'Enddudexistor  ', N'Tera Campos', N'Huddersfield', N'New Cross', 0, 174, N'THOITRANG           ', N'4095755540', 3, N'wctbcx39@txau-m.com                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (125, 2666544, N'Thrurobicazz International ', N'Larry Golden', N'Walsall', N'Chorley', 2, 147, N'THUCPHAM            ', N'3416986370', 14, N'bfxzdcwj.cvgzzem@xeuof.jvynes.org                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (126, 4448022, N'Endmuneficator WorldWide Group', N'Lynn Black', N'Wolverhampton', N'Linwood', 1, 60, N'DUNGCU              ', N'4201420194', 2, N'xlqeux.ruxxeguyxh@mygrsz.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (127, 7600704, N'Zeetinilar  Company', N'Don Miranda', N'Walsall', N'Newquay', 0, 30, N'THUCPHAM            ', N'7803241452', 8, N'yvituij.zsfuxmaq@dbaq.vpzydy.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (128, 2505217, N'Rezapopex  Company', N'Rosa Sullivan', N'Sutton Coldfield', N'Woolwich', 0, 57, N'THUCPHAM            ', N'4274161993', 7, N'etcwl882@oqxplg.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (129, 7539409, N'Unzapover  ', N'Matthew Soto', N'London', N'Turriff', 1, 153, N'DIENTU              ', N'8171073970', 7, N'dpfxel.ikjknybav@lczftk.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (130, 3317471, N'Varcadexin Holdings Inc', N'Lillian Singleton', N'London', N'Oxted', 1, 38, N'THOITRANG           ', N'4998831496', 2, N'erjnxxb.neragzn@fjrp.uuspgd.com                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (131, 5557043, N'Trukilar Holdings ', N'Clinton Odom', N'Northampton', N'Caernarfon', 3, 162, N'NUOCUONG            ', N'4802665305', 3, N'nldtmy.mmhnnqz@dmtwei.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (132, 1497979, N'Supglibover WorldWide ', N'Lakeisha Newton', N'Oxford', N'Aberaeron', 0, 173, N'NUOCUONG            ', N'6301259052', 2, N'vpseht062@mooksw.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (133, 4283715, N'Qwisipopan WorldWide ', N'Catherine Gallagher', N'Eastbourne', N'Stansted', 0, 153, N'THUCPHAM            ', N'9549370772', 9, N'jevekcro.cmerjfhe@hjztrq.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (134, 2144165, N'Rapvenepan Direct Corp.', N'Terence Graves', N'Birmingham', N'Skegness', 3, 87, N'THOITRANG           ', N'4461788548', 10, N'elmm44@wqvpnj.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (135, 7608056, N'Parbanaquin Holdings Inc', N'Katherine Bautista', N'Oxford', N'Earls Court', 0, 156, N'NUOCUONG            ', N'6181781453', 14, N'jvekdne.zecmt@kdupf.fyifha.net                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (136, 8213346, N'Klitumicator International ', N'Irene Novak', N'Northampton', N'Worthing', 1, 71, N'DIENTU              ', N'0994071217', 2, N'wpqhh.uhyis@ftnceb.org                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (137, 3522498, N'Barmunilar International ', N'Howard Barr', N'Newcastle upon Tyne', N'Farnham', 0, 87, N'THUCPHAM            ', N'3664012809', 6, N'onespg@qbcpmelpz.vvhmyu.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (138, 4545052, N'Inbanantor  ', N'Sophia Casey', N'Dudley', N'Harlow', 1, 126, N'DUNGCU              ', N'3448828438', 13, N'sevwml162@ksfbr.phirpb.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (139, 1888020, N'Grotumazz International ', N'Nicolas Miller', N'Ipswich', N'Invergordon', 1, 43, N'THOITRANG           ', N'8627443487', 8, N'sfstu.fbhtprp@vjnvkdckg.agilft.net                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (140, 5319114, N'Tiptanollover  ', N'Tracie Blanchard', N'Birmingham', N'Faversham', 2, 194, N'NUOCUONG            ', N'6684374391', 14, N'hwkv@rxicrayh.eouepc.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (141, 6966479, N'Vartinover Holdings Corp.', N'Seth Bender', N'Blackpool', N'Liverpool', 0, 94, N'DUNGCU              ', N'7860259621', 2, N'jmewpa@mqzyon.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (142, 7328098, N'Frosipackan  Inc', N'Tyrone Pruitt', N'Exeter', N'Bridgend', 1, 145, N'THOITRANG           ', N'9039516836', 8, N'eceubi0@qrtdibldj.whivsl.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (143, 3284871, N'Surtinover  ', N'Jennie Soto', N'Newcastle upon Tyne', N'Wetherby', 1, 62, N'THOITRANG           ', N'9753766166', 1, N'gagz@olvvzaw.eqsnqw.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (144, 1770766, N'Zeekilimazz  Inc', N'Robin Hess', N'Leicester', N'Matlock', 1, 126, N'DUNGCU              ', N'7924864825', 1, N'wkhvvz@tdtrn.z-m-gn.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (145, 1753431, N'Zeevenilantor Holdings ', N'Dwight Wolfe', N'Slough', N'Corrour', 1, 60, N'DUNGCU              ', N'8081610771', 9, N'lpqb.fjxvdtqinp@kggs.ncxnqi.org                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (146, 3870639, N'Winfropar Holdings ', N'Gabriel Todd', N'Southend-on-Sea', N'Galashiels', 0, 40, N'DIENTU              ', N'3675406012', 10, N'iiljfihd3@nteq.yxhcvp.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (147, 3182220, N'Thrusipadicator Direct ', N'Roger Townsend', N'Bournemouth', N'Hunstanton', 3, 90, N'NUOCUONG            ', N'6161768243', 4, N'cyvoo@kezgfv.net                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (148, 2829680, N'Hapcadplentor  Inc', N'Michelle Nelson', N'Derby', N'Windermere', 0, 83, N'DUNGCU              ', N'5154354901', 5, N'swlazjtx18@vpogiit.jkfshy.com                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (149, 3466934, N'Winwerefor  ', N'Xavier Crane', N'Kingston upon Hull', N'Arthog', 2, 157, N'THOITRANG           ', N'6224524005', 5, N'scnbcsh.obqkoqwqyk@zmmit.-tgaug.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (150, 1509952, N'Emtumax Holdings ', N'Sonny Greene', N'Plymouth', N'Motherwell', 0, 98, N'DUNGCU              ', N'8819515889', 9, N'chdjc@hdovu.cingmr.com                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (151, 2522792, N'Cipjuban  ', N'Marc Clayton', N'Rotherham', N'Isle of Canna', 0, 155, N'NUOCUONG            ', N'4239959599', 10, N'tjghwwng85@ogatws.org                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (152, 3663969, N'Varwerpor Holdings ', N'Brendan Moran', N'Watford', N'Selby', 2, 154, N'NUOCUONG            ', N'7155680823', 10, N'erfjdrgz423@bbhg.tbzfuq.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (153, 2589243, N'Rapfropopor WorldWide ', N'Krista Mc Millan', N'Derby', N'Walton-on-Thames', 1, 60, N'THOITRANG           ', N'1745812967', 1, N'gtvwwof.msvzkbubjc@zroldl.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (154, 5839843, N'Undudex WorldWide ', N'Meredith Gibbs', N'Southend-on-Sea', N'Llandudno Junction', 4, 135, N'NUOCUONG            ', N'2232495833', 11, N'yonxz.fqiwvi@ol-iae.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (155, 1602574, N'Tuppebax WorldWide ', N'Eric Cummings', N'York', N'Sleaford', 1, 36, N'DUNGCU              ', N'9394384444', 6, N'ogwgbg0@cyex.riok-f.net                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (156, 6981876, N'Frodimackicator  ', N'Sylvia Larson', N'Reading', N'Merriott', 0, 74, N'NUOCUONG            ', N'0233506201', 4, N'aczzdczm.zqdmpyfqtr@qkna.sptkhn.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (157, 6860522, N'Upsipicator  Group', N'Latoya Sanders', N'Middlesbrough', N'Hungerford', 1, 52, N'DIENTU              ', N'6822271039', 10, N'ygkozdj@wetqfjmb.clplck.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (158, 6947005, N'Qwipebantor International ', N'Esther Alexander', N'Liverpool', N'Settle', 3, 77, N'THUCPHAM            ', N'7878875500', 8, N'zrqd66@tnbnvd.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (159, 5624604, N'Qwikilantor Direct Company', N'Wendy Steele', N'Coventry', N'Strome Ferry', 0, 74, N'DUNGCU              ', N'6251262213', 6, N'myzobvmb6@owmido.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (160, 5456372, N'Cipcadentor WorldWide ', N'Leroy Perkins', N'Southend-on-Sea', N'Liphook', 0, 129, N'DIENTU              ', N'9131386223', 10, N'xcylhs6@ezyixk.com                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (161, 9507389, N'Uncadower Direct ', N'Manuel Hobbs', N'Sheffield', N'Devizes', 2, 147, N'DUNGCU              ', N'6663105971', 5, N'qied@rpdrpb.net                                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (162, 4313253, N'Kliglibax Direct ', N'Kate Foley', N'Kingston upon Hull', N'Belper', 1, 187, N'THUCPHAM            ', N'5424809595', 11, N'vbdtdz82@pnpynt.com                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (163, 1836332, N'Endtanower Holdings ', N'Jonathon Ortiz', N'York', N'Banbridge', 1, 163, N'DUNGCU              ', N'3823061092', 14, N'tyxpqnvz@gjmvhw.net                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (164, 8078420, N'Thrumunonantor  Group', N'Evelyn Dillon', N'Peterborough', N'Moodiesburn', 0, 104, N'DUNGCU              ', N'5853246881', 3, N'vshuc1@dvpovweo.pdmzxk.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (165, 2561604, N'Grodudentor International Corp.', N'Jocelyn Perkins', N'Southend-on-Sea', N'Balfron', 1, 53, N'DIENTU              ', N'4653768089', 12, N'gatqrcwh1@yrzguzn.npqtsa.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (166, 7566189, N'Varwerazz International Group', N'Neil Norman', N'Kingston upon Hull', N'Filey', 1, 151, N'THOITRANG           ', N'8069448924', 4, N'tjjmcid4@gveaas.net                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (167, 4458898, N'Varjubin  ', N'Jimmy Cisneros', N'Coventry', N'Dartford', 0, 119, N'NUOCUONG            ', N'4525197080', 14, N'nsdlck.cwyajzgi@gontrh.org                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (168, 1676607, N'Rapmunin Holdings ', N'Dean Gardner', N'Southampton', N'Anerley', 1, 123, N'DUNGCU              ', N'5662532610', 13, N'lslp.kzua@ksqs.rnsiho.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (169, 6849814, N'Cipmunor  ', N'Mike Vargas', N'Rotherham', N'Acton', 1, 94, N'NUOCUONG            ', N'2638271647', 14, N'blcyubu99@dyqjdf.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (170, 1444687, N'Suppickommentor  ', N'Shelly Wade', N'Huddersfield', N'Hockley', 3, 62, N'THOITRANG           ', N'4845878813', 13, N'ppyv.unme@iqnhaa.ktbtqt.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (171, 1682819, N'Monpebedgicator Holdings ', N'Randi Bryant', N'Rotherham', N'Aberfeldy', 0, 88, N'THUCPHAM            ', N'5921693016', 13, N'pcydit81@baqvuwke.khidgr.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (172, 2935529, N'Dopzapistor  ', N'Tracy Bond', N'Plymouth', N'Keighley', 2, 189, N'DIENTU              ', N'0545813341', 10, N'vhczle0@vcqdxv.net                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (173, 2453128, N'Emhupazz Direct ', N'Darlene Rubio', N'Luton', N'Newton Aycliffe', 1, 65, N'THUCPHAM            ', N'4571166963', 1, N'dhzuil.tpybblzbv@pvfhtbpj.tdlhig.net              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (174, 7932902, N'Thrupickicator Holdings ', N'Esteban Bender', N'Huddersfield', N'Swadlincote', 3, 115, N'DIENTU              ', N'4130670682', 7, N'wntnnzrx7@qivrhoyaf.tbnkod.com                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (175, 2018842, N'Parfropantor  Corp.', N'Lorie Dickson', N'Sunderland', N'Market Weighton', 1, 189, N'THUCPHAM            ', N'1970492656', 7, N'uouei1@jrhvzf.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (176, 5898500, N'Parquestor WorldWide ', N'Julio Delacruz', N'Newcastle upon Tyne', N'Alford', 1, 90, N'DUNGCU              ', N'6882666509', 6, N'qrbs.rtzlzoctl@ujlz.-eskpn.com                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (177, 8975850, N'Inquestex  Company', N'Darlene Ford', N'Reading', N'Strontian', 1, 199, N'DIENTU              ', N'1707599521', 11, N'chis.qcpp@iechjq.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (178, 4343159, N'Tipglibicentor WorldWide Corp.', N'Alan Johnson', N'Crawley', N'Forest Row', 0, 41, N'DIENTU              ', N'5002047697', 3, N'wewrwcr.npdi@sgjfmkw.uxkdua.com                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (179, 4887688, N'Supwerponantor International Group', N'Eric Choi', N'Slough', N'Harrow', 1, 143, N'THUCPHAM            ', N'9047789588', 9, N'yhebxkqw71@jghw.a-ltvz.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (180, 9123791, N'Untumefan WorldWide Company', N'Lauren Nelson', N'Oldham', N'Strathaven', 1, 136, N'THUCPHAM            ', N'9831191666', 5, N'tlywuomr.zlhpnueqtd@dwxqiz.com                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (181, 5456926, N'Tupjubar International ', N'Jack Parsons', N'Peterborough', N'Beverley', 2, 171, N'THOITRANG           ', N'5210975147', 14, N'jbyiwk95@mchlcl.com                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (182, 8472333, N'Tiperepan WorldWide Inc', N'Vernon Esparza', N'Bradford', N'Orpington', 1, 148, N'THUCPHAM            ', N'7173437753', 4, N'pffwh09@nejuxnzt.htqfol.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (183, 8436339, N'Endtumax WorldWide ', N'Angelina Mc Daniel', N'Peterborough', N'Westerham', 1, 100, N'DIENTU              ', N'4230306787', 2, N'olnxmvxd.aqcklvibee@ydrkjvn.gvdfmm.com            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (184, 2935710, N'Qwidimexover  Group', N'Ismael Benson', N'Stockport', N'Denny', 1, 84, N'DIENTU              ', N'3784150231', 14, N'ajlqbkz938@gwsdmi.org                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (185, 1448913, N'Tipcadamax Direct ', N'Marvin Wilkerson', N'Kingston upon Hull', N'Cleator Moor', 1, 84, N'NUOCUONG            ', N'7428325463', 7, N'mcpwuelw.dzbv@indojk.com                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (186, 3822122, N'Tipwerepistor Holdings Corp.', N'Joey Crawford', N'Huddersfield', N'Great Yarmouth', 1, 38, N'DUNGCU              ', N'2172970189', 9, N'buphn209@-epvqd.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (187, 6029934, N'Unbanupantor WorldWide ', N'Seth Murillo', N'Southampton', N'Barton-on-Humber', 0, 142, N'THOITRANG           ', N'8220242188', 1, N'syllda.fqsa@uzodin.net                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (188, 1161729, N'Lompebollower  ', N'Dina Leach', N'Portsmouth', N'Dinas Powys', 0, 47, N'DUNGCU              ', N'4233217782', 13, N'xdyk.xixflczdj@moablfwtc.pfmull.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (189, 2893058, N'Rapdimicator WorldWide Inc', N'Andrea Morse', N'Newcastle upon Tyne', N'Yateley', 0, 81, N'THUCPHAM            ', N'5143306725', 4, N'hntjqcwt.myrqma@xulybq.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (190, 8402912, N'Tipsapadin  Group', N'Lori Nixon', N'Derby', N'Peebles', 2, 112, N'DIENTU              ', N'8538263757', 10, N'hckky.cbpjdxyfs@fdtztm.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (191, 4364324, N'Trupickefar  Group', N'Esther Moreno', N'Brighton', N'Linton on-Swale', 1, 49, N'DUNGCU              ', N'9401922957', 8, N'pbpjld.utjc@uoowps.org                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (192, 2027832, N'Barvenover  Inc', N'Carlton Donovan', N'Reading', N'Llanbedrgoch', 1, 40, N'DUNGCU              ', N'8603379438', 13, N'ptgw02@lmbc.rdgh-c.com                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (193, 3643668, N'Endwerpazz  Inc', N'Kristin Horne', N'Kingston upon Hull', N'Liverpool', 0, 81, N'DUNGCU              ', N'3026187439', 7, N'ppjjekx.kqmwdptkx@lqdvrb.net                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (194, 4239150, N'Frowerackantor Direct Corp.', N'Roger Serrano', N'Leicester', N'Upper Holloway', 0, 114, N'THOITRANG           ', NULL, 13, N'jlbvd2@vwlzfckqq.pnwbq-.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (195, 8102554, N'Unbanantor WorldWide Corp.', N'Nora Hoffman', N'Oldham', N'Banchory', 2, 76, N'NUOCUONG            ', N'6188719632', 9, N'korc.nuivilmis@qzmlckbli.vnydbn.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (196, 8761659, N'Parcadopazz Holdings Corp.', N'Tia French', N'Norwich', N'Invergordon', 0, 108, N'THOITRANG           ', N'1050884803', 7, N'mjtj47@ebguma.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (197, 8110234, N'Doptinantor WorldWide ', N'Robin Conley', N'Kingston upon Hull', N'Beauly', 0, 182, N'THOITRANG           ', N'9238016200', 10, N'jnidpred.jqgxumgai@aaivt.gu-axd.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (198, 8503001, N'Unhupicator International ', N'Hector Stein', N'Blackpool', N'Evesham', 1, 158, N'THUCPHAM            ', N'6279760097', 14, N'emiucebt90@uomtthjm.hvkxir.org                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (199, 5237474, N'Qwiwerantor  ', N'Tara Love', N'Blackpool', N'Llanelli', 1, 103, N'NUOCUONG            ', N'1397201940', 4, N'mftpzx072@vsyz-l.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (200, 6460192, N'Grovenefex WorldWide ', N'Wendi Burke', N'Middlesbrough', N'Torpoint', 0, 109, N'THUCPHAM            ', N'9925176633', 5, N'kturmayr0@mwnrvp.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (201, 7057296, N'Lomdimor WorldWide ', N'Natalie Stanton', N'Portsmouth', N'Bexley', 0, 122, N'THOITRANG           ', N'1341081539', 11, N'robqbm9@qhblyymx.ouzewa.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (202, 9022628, N'Frobanicator Holdings ', N'Carey Cantrell', N'Nottingham', N'Hexham', 1, 168, NULL, N'7627727917', 6, N'khew7@alnve.jxipkk.com                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (203, 5670071, N'Monkilanin  Group', N'Janine Montoya', N'Walsall', N'Whitley Bay', 1, 190, N'NUOCUONG            ', N'6349924489', 6, N'iszyx.uzdg@diiqig.xajlkl.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (204, 9196928, N'Haptuminor  ', N'Israel Whitaker', N'Blackpool', N'March', 1, 124, N'THOITRANG           ', N'3175917555', 8, N'nmxlvow78@fljoar.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (205, 5403289, N'Rapsapex  Corp.', N'Cody O''Neal', N'Preston', N'Morden', 0, 39, N'DIENTU              ', N'4755224906', 11, N'bzcdiw55@phng.gahezx.com                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (206, 7046264, N'Cipnipedicator WorldWide ', N'Tom Sherman', N'Poole', N'Wokingham', 2, 166, N'THUCPHAM            ', N'9846962524', 1, N'kqpzw@lnuhm.ouuejp.org                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (207, 5975195, N'Tupdimommower International Company', N'Shanda Hendricks', N'Milton Keynes', N'Bourne', 0, 118, N'THUCPHAM            ', N'0750785439', 10, N'ydtu.ibbp@frir.rqvv-l.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (208, 9679262, N'Kliglibar International ', N'William Baxter', N'Brighton', N'Barnetby', 1, 146, N'THOITRANG           ', N'4375155699', 10, N'jtlfs166@ockkjl.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (209, 5662878, N'Uphupower Holdings Group', N'Angelo Ritter', N'Sheffield', N'West Kensington', 1, 147, N'THOITRANG           ', N'8337290556', 5, N'nmxl793@rfzh.xvimku.com                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (210, 5931546, N'Surtinazz International ', N'Nina Cooke', N'Newcastle upon Tyne', N'Sevenoaks', 0, 147, N'THOITRANG           ', N'9959259393', 1, N'mnpo45@gwvzc.jbtmte.net                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (211, 2657794, N'Tipsaponower  Corp.', N'Kris Wilson', N'London', N'Rothwell', 3, 76, N'DUNGCU              ', N'4019952228', 9, N'vfnocr9@pkctzt.com                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (212, 2817729, N'Moncadexover WorldWide ', N'Autumn Kline', N'Blackpool', N'Billingham', 0, 40, N'THUCPHAM            ', N'4609631105', 8, N'mtkjytq00@oaszywlq.nyxzmg.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (213, 2955906, N'Wintumazz International ', N'Julio Alvarado', N'Southampton', N'Gravesend', 1, 134, N'DIENTU              ', N'7387470461', 15, N'utkwlwl.vmobrvr@kktaxw.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (214, 3078968, N'Dopvenazz WorldWide ', N'Chandra Rose', N'Bradford', N'Abergele', 2, 138, N'DIENTU              ', N'7326190038', 2, N'fmlygjva84@hdjazbhwd.gkwvot.net                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (215, 7004397, N'Rapnipimower  ', N'Sonja Vega', N'Gloucester', N'Huntingdon', 1, 159, NULL, N'1037780800', 11, N'dhqzkq.sbjmwhygcp@xqwhie.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (216, 3297652, N'Tuptinazz Holdings Corp.', N'Rafael Mc Neil', N'Sutton Coldfield', N'Malmesbury', 1, 200, N'THUCPHAM            ', N'7082556991', 2, N'mzko.hvnitsmwj@qjznqt.azqmkh.com                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (217, 4340613, N'Wintanor  ', N'Monica Acevedo', N'Sunderland', N'Braintree', 0, 116, N'NUOCUONG            ', N'4813682245', 9, N'zsqsqvzp778@agpvrv.com                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (218, 2910603, N'Wintumepicator  ', N'Tanisha Lucero', N'Colchester', N'Seahouses', 1, 109, N'THUCPHAM            ', N'0264198555', 15, N'wglmnqu757@qprruy.com                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (219, 9183986, N'Tipcadewin  ', N'Brady Stevens', N'Huddersfield', N'Hastings', 0, 50, N'THUCPHAM            ', N'2728449260', 11, N'ydcq.unyjikumf@zgsobhf.uq-d-a.net                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (220, 2743243, N'Zeebanex  ', N'Floyd Hernandez', N'Oldham', N'Nine Elms', 0, 45, N'NUOCUONG            ', N'3696569367', 4, N'zihj.oprufljlek@vsrjxvxa.ouixhp.com               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (221, 2846738, N'Varbanax Direct Corp.', N'Christina Thornton', N'Eastbourne', N'Dawlish', 2, 38, N'DIENTU              ', N'7240697865', 4, N'exzo.dwhcug@pvugagp.lmwfzu.org                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (222, 2747442, N'Lomglibanan  ', N'Esmeralda Frost', N'Brighton', N'Woodhall Spa', 1, 101, N'THOITRANG           ', N'2772540880', 2, N'xvwq3@znmptb.net                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (223, 8177822, N'Retanopazz Direct Corp.', N'Dale Wilkinson', N'Blackburn', N'Appleby-in-Westmorland', 2, 71, N'DUNGCU              ', N'7329779802', 9, N'bfncbp744@siokdz.com                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (224, 7605557, N'Frozapopicator  Corp.', N'Scottie Benton', N'Swindon', N'Eastleigh', 0, 182, N'NUOCUONG            ', N'6258323249', 4, N'mcndj1@jcvxpt.net                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (225, 3537703, N'Trubanegicator  Inc', N'Paula Valentine', N'Gloucester', N'Tidworth', 1, 43, N'THUCPHAM            ', N'3340269569', 6, N'fpkh@gexdoc.com                                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (226, 3737019, N'Fronipilan International ', N'Brandi Simon', N'Swindon', N'Hythe', 3, 78, N'NUOCUONG            ', N'2801877612', 1, N'pcayr.cxtcowu@qhtuhe.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (227, 6044860, N'Insapanex Holdings Group', N'Joanna Browning', N'Sheffield', N'Warminster', 0, 138, N'THOITRANG           ', N'1864417011', 3, N'eesmf.gudimtveqa@iskinmd.fjnijb.com               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (228, 1157508, N'Inpebex International ', N'Jamison Contreras', N'Plymouth', N'Rhosneigr', 0, 151, N'NUOCUONG            ', N'6658929374', 3, N'nwcwh.uslg@ecuz.rytwez.org                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (229, 9423151, N'Varsapedgentor Holdings Group', N'Joyce Jacobs', N'Oxford', N'Sleaford', 1, 68, N'DIENTU              ', N'8647567641', 13, N'wwfvykkb.ylcrw@afbrbg.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (230, 1425379, N'Survenefex Direct ', N'Rolando Mckay', N'St Helens', N'Brighton', 1, 110, N'THOITRANG           ', N'4338080234', 15, N'okkaqqc.tzoxnvqun@ntzbd.dtzkuo.com                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (231, 9290016, N'Parwerpollor Direct ', N'Tina Stout', N'Bradford', N'Waterlooville', 2, 108, N'THUCPHAM            ', N'5638282334', 12, N'jzzazd.yywbrn@xoyyuvk.wjmius.net                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (232, 8640500, N'Klierommantor  Company', N'Jason Livingston', N'Telford', N'Lee', 1, 70, N'DIENTU              ', N'3797894756', 13, N'dlewqt.zwubfboqi@epmqmn.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (233, 3098431, N'Grozapepar International ', N'Chastity Berger', N'Portsmouth', N'Shipley', 2, 139, N'THUCPHAM            ', N'3355164338', 14, N'qqnwfymy58@uzybjdvuw.getupu.com                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (234, 9433267, N'Klijubex WorldWide ', N'Luis Duarte', N'Kingston upon Hull', N'Kirkwall', 0, 64, N'NUOCUONG            ', N'9069556570', 4, N'zpxnmzp1@vrkevnsm.niuumo.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (235, 1650341, N'Grovenover International Company', N'Kelli Gilbert', N'Oxford', N'Rossendale', 2, 44, N'THOITRANG           ', N'0942408088', 9, N'rimrfwnd9@ksmpepup.baeclg.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (236, 8878177, N'Resapazz WorldWide Group', N'Lance Barrett', N'Bournemouth', N'Normanton', 1, 32, N'DIENTU              ', N'3512050064', 9, N'ykoyb.ppuwa@u-zbph.org                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (237, 3997734, N'Varwerpazz  Company', N'Tonia Mullins', N'York', N'Porth', 1, 159, N'DIENTU              ', N'1896548151', 13, N'zgosfkm20@nxhjyq.ouxpia.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (238, 7212187, N'Surzapantor  ', N'Thomas Gomez', N'Manchester', N'Fowey', 1, 176, N'THUCPHAM            ', N'2858161784', 10, N'eiqtoqkh54@jpydmg.rtrret.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (239, 9747003, N'Grozapax Direct ', N'Chandra Jordan', N'Newcastle upon Tyne', N'New Milton', 1, 74, N'THOITRANG           ', N'1445884311', 3, N'zkddhyc.xydqxaje@khqep-.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (240, 8428879, N'Partinin  ', N'Carlos Jenkins', N'Middlesbrough', N'Cookstown', 1, 118, N'DIENTU              ', N'6331305467', 7, N'pybjwf.ykhuphyr@dmtsin.rtzhdn.org                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (241, 3963175, N'Parmunazz WorldWide Inc', N'Fernando Kemp', N'Leicester', N'Cumbernauld', 1, 120, N'NUOCUONG            ', N'4780245769', 14, N'lmrfobx.czxcmdj@axpswp.com                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (242, 6697974, N'Vartinax International ', N'Vicky Preston', N'Southend-on-Sea', N'Abergavenny', 2, 197, N'DIENTU              ', N'9011914821', 7, N'elzctwep@rmfvgpj.efppid.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (243, 5456938, N'Windimazz International ', N'Linda Haney', N'Reading', N'Evesham', 1, 100, N'THUCPHAM            ', N'9913417906', 9, N'psqbrmx4@snijcnjpr.mggywy.net                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (244, 9145395, N'Winvenazz  Group', N'Paul Estrada', N'London', N'Chingford', 2, 134, N'DIENTU              ', N'9868044855', 4, N'tpjyzle@tduhgx.xfmvux.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (245, 9183576, N'Tipjubax  ', N'Efrain Walsh', N'Reading', N'Warrington', 2, 66, N'NUOCUONG            ', N'9381545869', 2, N'fjusq.istttn@xsd-xq.net                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (246, 2379506, N'Hapsapewan Direct Company', N'Greg Rodriguez', N'Coventry', N'Houghton le Spring', 2, 38, N'THUCPHAM            ', N'3498293030', 15, N'abea.xulkf@kboqd.bnlcea.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (247, 2080034, N'Surbanewazz Direct ', N'Lewis Mc Connell', N'Birmingham', N'Bury', 1, 106, N'THUCPHAM            ', N'6631130255', 13, N'cqxqe.trmxamuy@iqkmrqj.vploxy.net                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (248, 9457514, N'Trubanistor Holdings Group', N'Alyssa Mendez', N'St Helens', N'Linlithgow', 2, 143, N'DUNGCU              ', N'4063082070', 6, N'fveoub.rkcscii@uwkpck.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (249, 7724153, N'Trupebicator International ', N'Max Jacobson', N'Dudley', N'Isle of Canna', 0, 156, N'DUNGCU              ', N'5480865876', 3, N'vixxet.mhzt@gwzugn.net                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (250, 5687816, N'Hapglibin  ', N'Kari Zuniga', N'Leeds', N'Isle of Arran', 2, 77, N'THOITRANG           ', N'4847475474', 8, N'mhwkd9@eaysvom.otqaiv.com                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (251, 6201894, N'Trusapover International ', N'Annette Koch', N'Birmingham', N'Eye', 0, 193, N'THUCPHAM            ', N'1111856555', 14, N'poqidmw@uqkjme.com                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (252, 6494602, N'Groquestover  ', N'Julie Wells', N'Wolverhampton', N'Dukinfield', 3, 103, N'THOITRANG           ', N'9069461425', 10, N'tpoali.xaly@wmai.frctwe.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (253, 7603276, N'Parglibackazz Holdings ', N'Tomas Thompson', N'Leeds', N'Wadhurst', 0, 137, N'DUNGCU              ', N'6211598642', 3, N'aekdw.qqanfanoz@ravtyjf.hxpvrv.net                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (254, 5775430, N'Hapnipor  ', N'Jeanine Li', N'Ipswich', N'Thurso', 0, 88, N'NUOCUONG            ', N'6736872943', 1, N'pumxp@lmctsdeq.nlwff-.net                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (255, 4412982, N'Surzapegover  Inc', N'Shawna Rocha', N'Peterborough', N'Mitcham', 0, 100, N'THOITRANG           ', N'3960802842', 2, N'mjbvis97@unhmomxc.otkeeg.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (256, 4169215, N'Untanewax Direct Group', N'Aisha Levine', N'Middlesbrough', N'Blackheath', 2, 50, N'THUCPHAM            ', N'6854906099', 10, N'jomze.hkdtvjuj@r-eirt.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (257, 3194591, N'Winbanover  ', N'Jeremiah Gordon', N'Derby', N'Halstead', 0, 126, N'THUCPHAM            ', N'3839646911', 13, N'sxpp.lvqofahpvw@jdhjujtvn.fjquic.com              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (258, 7772149, N'Frowerupor International ', N'Sally Banks', N'Oldham', N'Newbridge', 1, 37, N'THUCPHAM            ', N'2188007785', 2, N'uruai.fercc@dokzojc.wuodpe.net                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (259, 8433369, N'Zeezapentor International Company', N'Heath Espinoza', N'Rotherham', N'Plockton', 3, 111, N'THOITRANG           ', N'1998677623', 2, N'redbbo83@easkbx.org                               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (260, 4131935, N'Dopsapedgantor Holdings Company', N'Melisa Warner', N'Eastbourne', N'Camberley', 0, 161, N'NUOCUONG            ', N'6823872419', 10, N'kjpcsouz353@yycgoe.org                            ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (261, 9453686, N'Zeetinexentor International Company', N'Darin Sullivan', N'Walsall', N'Bakewell', 0, 58, N'NUOCUONG            ', N'0542333029', 13, N'ftnavbeb.vaip@ntjxqyc.laulzq.net                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (262, 2209911, N'Frowerpefor  Company', N'Charles Villegas', N'Kingston upon Hull', N'Gosport', 1, 167, N'NUOCUONG            ', N'2118491515', 7, N'jejj9@cqomsr.com                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (263, 4063037, N'Adtumilistor WorldWide ', N'Angela Yang', N'Kingston upon Hull', N'Currie', 1, 108, N'THOITRANG           ', N'0614636809', 12, N'utvv2@otgsba.org                                  ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (264, 3986823, N'Raptanonin International Corp.', N'Beverly Cervantes', N'Bristol', N'Somerton', 0, 66, N'DIENTU              ', N'1953473507', 5, N'qefr@qmgnts.com                                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (265, 7624169, N'Admunilover Direct Inc', N'Simon Spears', N'Kingston upon Hull', N'Stratford', 0, 69, N'NUOCUONG            ', N'0239200348', 5, N'nexvbg.syyfqobphp@dgqtbj.azcmvi.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (266, 1556170, N'Unquestower Holdings Inc', N'Randolph Finley', N'Dudley', N'Colintraive', 0, 35, N'DIENTU              ', N'7431755619', 11, N'xelwkodz581@geqwi.ncurto.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (267, 4826707, N'Adzapollin International ', N'Bethany Cummings', N'Nottingham', N'Dunkeld', 1, 102, N'THUCPHAM            ', N'5845215290', 10, N'lcwujd@zzflrm.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (268, 3095047, N'Supfropupor Holdings Corp.', N'Loretta Cooley', N'Manchester', N'Tayport', 0, 100, N'DUNGCU              ', N'7465960153', 11, N'phwifmn.arfqzakt@ashfjl.net                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (269, 4186760, N'Indimover International ', N'Monica Ibarra', N'Oxford', N'Cranleigh', 0, 124, N'DUNGCU              ', N'5858434737', 8, N'ibcl398@xigmtk.org                                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (270, 5759764, N'Unglibopower  Corp.', N'Gina Cuevas', N'Derby', N'Seaview', 4, 156, N'DUNGCU              ', N'1726726734', 3, N'azzwst.qgamwgp@hokb.-drq-i.net                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (271, 6704858, N'Unsapinan  ', N'Travis Roman', N'Stoke-on-Trent', N'Tayport', 1, 70, N'THUCPHAM            ', N'7376546917', 5, N'ovfzyxj64@suefrt.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (272, 5678311, N'Cipcadadax Direct Inc', N'Abel Fields', N'Newcastle upon Tyne', N'Saltcoats', 1, 140, N'DIENTU              ', N'7223421468', 15, N'mwulu.dbsms@fhwhr.qxwxjm.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (273, 1584772, N'Supmunex International ', N'Sonja Shea', N'Middlesbrough', N'Bridgnorth', 0, 64, N'THOITRANG           ', N'9985526101', 12, N'mkjpspb.oeyoaiza@-oxjib.org                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (274, 1733184, N'Bardudewan WorldWide ', N'Ronald Knox', N'Oldham', N'Bushmills', 1, 132, N'THOITRANG           ', N'8593466414', 4, N'ozwbhskr.wzuqgxid@poxxkb.org                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (275, 9638458, N'Tupzapower  Inc', N'Roderick Mora', N'Rotherham', N'Haslemere', 2, 125, N'DUNGCU              ', N'5661502718', 5, N'paanm.znmwgej@czpihz.org                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (276, 5967962, N'Dopdudicator  ', N'Allen Bird', N'Northampton', N'Dalwhinnie', 1, 42, N'DIENTU              ', N'5597415759', 12, N'iyjzcyq60@jlecgj.net                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (277, 2830721, N'Supsipamar Holdings ', N'Rebekah Graham', N'Walsall', N'Newport', 1, 31, N'NUOCUONG            ', N'4220607201', 8, N'ncgxhuk@yueofm.nwrvoh.org                         ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (278, 6398030, N'Suptumanazz Holdings Corp.', N'Stuart Russell', N'Blackburn', N'Spalding', 3, 138, N'DUNGCU              ', N'8628096960', 6, N'tnkfbpf.wdcue@mdlso.yzqjvz.com                    ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (279, 5517992, N'Endhupewin Holdings Inc', N'Jamey Hardin', N'Nottingham', N'Gosport', 1, 146, N'DIENTU              ', N'4172653078', 3, N'oxwzb.slasvjsbkc@ajkxis.okoqsf.com                ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (280, 7698777, N'Tupnipollex Holdings ', N'Tricia Hall', N'Ipswich', N'Houghton le Spring', 1, 35, N'DUNGCU              ', N'5256350002', 7, N'hfgvcipt.ztvgxghl@idanhn.qctglk.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (281, 8508135, N'Uneraquor Direct Inc', N'Alexandra Wilcox', N'Bournemouth', N'Doncaster', 0, 173, N'DIENTU              ', N'5542680891', 3, N'vehhhkp.jysinij@vuef.mo-ypy.org                   ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (282, 3167976, N'Upsapazz Holdings Group', N'Anitra Daugherty', N'Manchester', N'Haddington', 1, 195, N'THUCPHAM            ', N'5865447049', 13, N'ipvbca174@iuzdvj.org                              ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (283, 9244622, N'Upsipilistor  Inc', N'Shelia Costa', N'Colchester', N'Derby', 0, 196, N'DUNGCU              ', N'8611956759', 1, N'pmfqmt.lztjwpdn@jdwqatqn.t-uunc.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (284, 3502729, N'Trupickilicator Direct Corp.', N'Erick Small', N'Swindon', N'Feltham', 3, 191, N'DUNGCU              ', N'2421943070', 6, N'cqlqg7@ehsrls.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (285, 2171376, N'Frosipower WorldWide ', N'Brady Greene', N'Oldham', N'South Ockendon', 0, 117, N'NUOCUONG            ', N'3636027093', 2, N'wsylmayp.refgywawa@scxeak.org                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (286, 1101623, N'Qwisipantor Holdings ', N'Stefanie Newman', N'Oldham', N'Nethy Bridge', 0, 35, N'THOITRANG           ', N'9998164880', 2, N'bobfmg@krqlla.com                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (287, 3996984, N'Ineraquan WorldWide ', N'Penny Dorsey', N'Middlesbrough', N'Market Drayton', 0, 133, N'THOITRANG           ', N'3808131226', 10, N'yjwrps.dqag@texspy.ztbito.net                     ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (288, 9302064, N'Varfropin International Group', N'Marco Payne', N'West Bromwich', N'Tring', 0, 80, N'NUOCUONG            ', N'6558535119', 14, N'gqwppm.jyignc@kswymo.net                          ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (289, 9898294, N'Endpebupower WorldWide Inc', N'Debra Whitehead', N'Milton Keynes', N'Thames Ditton', 4, 164, N'THOITRANG           ', N'1975907758', 3, N'rtypui.anxzequbx@tgsdxe.com                       ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (290, 4292369, N'Haptanopin  ', N'Clifton Hale', N'Crawley', N'Newbridge', 0, 194, N'NUOCUONG            ', N'7722093018', 14, N'asay.kyvn@bcega.potxta.net                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (291, 4808110, N'Unvenollazz WorldWide Inc', N'Gavin Stafford', N'Bradford', N'Darvel', 0, 107, N'NUOCUONG            ', N'4504238509', 11, N'zfypbjlk.zofbusyo@lqbldr.com                      ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (292, 8636400, N'Rerobower WorldWide ', N'Telly Huffman', N'Stockport', N'Barrow-in-Furness', 1, 152, N'THUCPHAM            ', N'8779658067', 11, N'ecyzb.ezgm@qgtfkz.com                             ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (293, 8026279, N'Varfropistor Holdings Group', N'Johnny Bender', N'Southampton', N'New Milton', 0, 95, N'THOITRANG           ', N'9430618643', 8, N'byglc.cmljtrgt@npdptsbsk.jhfssb.net               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (294, 5795897, N'Upmunommar  ', N'Deanna Petersen', N'Sunderland', N'Isle of Cumbrae', 0, 114, N'NUOCUONG            ', N'3374017192', 8, N'dsoyapcn.eskohgxkje@essuyugs.qrcptl.com           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (295, 3089682, N'Tipsapplan  ', N'Jodie David', N'Manchester', N'Carr Bridge', 0, 90, N'THUCPHAM            ', N'1290300399', 9, N'nnfwzo.wazuisut@vffrhf.org                        ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (296, 1016361, N'Endquestistor International Corp.', N'Herbert Banks', N'Oldham', N'Tetbury', 2, 153, N'DIENTU              ', N'0962299420', 8, N'mzgyou@bjddzj.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (297, 3482792, N'Haptanplentor International Group', N'Cecilia Carlson', N'Northampton', N'Renfrew', 1, 119, N'NUOCUONG            ', N'8538944720', 11, N'hxiyx1@hveztm.org                                 ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (298, 2941328, N'Unglibover WorldWide Company', N'Zachary Moran', N'Bradford', N'Laurencekirk', 1, 64, N'THUCPHAM            ', N'8774156205', 4, N'dxmem@mjqgwq.zecobw.org                           ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (299, 9706484, N'Qwiwerazz WorldWide ', N'Oscar Tanner', N'Cambridge', N'Frome', 1, 95, N'THUCPHAM            ', N'2075195117', 14, N'eynzldq.gfehclvbts@zclfr.nimqgr.org               ')
GO
INSERT [dbo].[DOITAC] ([MaDT], [MaSoThue], [TenDT], [NguoiDaiDien], [ThanhPho], [Quan], [SoChiNhanh], [SoDonTrongNgay], [LoaiVanChuyen], [SDT], [PhanTramHoaHong], [Email]) VALUES (300, 3339928, N'Klitumackan  ', N'Joni Heath', N'St Helens', N'Perth', 0, 60, N'NUOCUONG            ', N'0179120667', 6, N'nzwsovsn4@uini.zodwbt.net                         ')
GO
SET IDENTITY_INSERT [dbo].[DOITAC] OFF
GO
SET IDENTITY_INSERT [dbo].[CHINHANH] ON 
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (208, 11, N'10 Green Fabien Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (234, 267, N'105 West Green Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (293, 73, N'108 North White Hague Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (252, 192, N'114 East Green Oak Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (205, 236, N'116 North Green Clarendon Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (64, 59, N'116 West Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (44, 233, N'116 West Rocky New Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (6, 270, N'120 North Green Old Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (206, 203, N'123 West Green Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (291, 149, N'128 White Cowley Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (81, 211, N'130 West Nobel St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (157, 183, N'131 East Green Second Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (1, 25, N'133 North White Old Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (300, 45, N'14 White Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (281, 232, N'142 South Green Old Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (35, 28, N'147 North Cowley Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (150, 153, N'15 North Green Oak St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (211, 185, N'150 East Green Fabien St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (75, 195, N'153 West Green Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (133, 105, N'155 Milton St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (58, 58, N'162 West Cowley Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (297, 125, N'166 South Green Second St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (86, 17, N'167 West White Old Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (232, 30, N'168 Rocky Milton Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (241, 184, N'171 North White Old Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (184, 222, N'171 South Oak Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (175, 277, N'172 Green Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (226, 120, N'174 East Green Milton Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (15, 72, N'176 Rocky Second Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (168, 250, N'179 East White Hague Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (109, 38, N'179 West Cowley Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (22, 182, N'191 North White Clarendon Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (242, 289, N'196 West White Oak Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (89, 4, N'208 South Nobel Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (290, 250, N'21 South White Nobel Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (112, 175, N'211 North Milton St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (37, 170, N'212 East Hague Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (149, 97, N'213 South Rocky New Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (10, 233, N'217 West Rocky Hague Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (12, 17, N'221 South White Nobel Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (25, 116, N'224 North White Old Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (43, 247, N'227 East Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (39, 226, N'230 East Rocky Hague Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (13, 118, N'233 North White New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (189, 289, N'234 South New Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (4, 270, N'236 East Milton St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (32, 80, N'238 Green Oak Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (46, 4, N'239 East Green Second Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (201, 30, N'24 East Green Clarendon Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (224, 35, N'240 East Rocky First Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (60, 38, N'247 West Green Hague Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (139, 41, N'251 South Rocky Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (72, 121, N'252 North Rocky Hague Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (104, 231, N'252 West White Cowley Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (11, 143, N'255 North White Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (134, 155, N'256 South Fabien Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (197, 191, N'256 South Old Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (194, 276, N'258 North Rocky Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (227, 139, N'266 South White Fabien Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (36, 101, N'268 South Rocky First Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (124, 235, N'272 Green Clarendon Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (56, 63, N'278 West Rocky New Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (247, 71, N'285 South Rocky Cowley Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (180, 80, N'286 Rocky Hague Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (54, 199, N'296 East Green Cowley Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (196, 284, N'299 East Rocky New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (255, 259, N'30 East Rocky Fabien Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (260, 111, N'300 South Fabien Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (50, 110, N'300 West Oak Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (193, 74, N'305 East Second Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (210, 16, N'307 White Old Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (66, 259, N'310 South Rocky Milton Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (123, 198, N'314 Green Old Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (277, 296, N'314 West Green Milton Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (170, 289, N'318 West White First Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (245, 239, N'323 East White Fabien Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (95, 225, N'325 Green First Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (14, 17, N'327 East Green Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (8, 138, N'327 North Second Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (85, 158, N'332 West White Nobel St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (108, 180, N'332 White First Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (61, 252, N'334 West White Cowley Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (240, 241, N'34 South Green Milton Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (298, 246, N'340 North White Cowley Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (279, 158, N'342 East Green Cowley Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (57, 29, N'345 West Rocky Fabien Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (186, 230, N'349 East White Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (59, 111, N'352 East Green Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (236, 114, N'354 Second Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (222, 278, N'360 East Oak Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (105, 110, N'360 North White Clarendon Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (135, 147, N'366 South Old St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (110, 79, N'367 East Green First Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (294, 56, N'369 East Rocky Oak Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (203, 202, N'371 West White First Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (16, 170, N'376 West White Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (97, 136, N'387 Rocky Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (285, 190, N'389 East Green Milton Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (122, 122, N'390 South New Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (53, 37, N'392 North Green New Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (267, 126, N'394 West Rocky First Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (228, 63, N'401 North White Milton Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (251, 235, N'403 White Hague Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (248, 13, N'407 East White Second Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (73, 76, N'410 Rocky Second St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (2, 223, N'411 White Nobel Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (74, 55, N'413 South Milton Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (215, 140, N'415 Green Cowley Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (47, 152, N'416 West Hague Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (280, 237, N'426 East Green New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (177, 218, N'426 North Rocky Second Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (270, 82, N'429 West Green New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (204, 165, N'43 North White Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (283, 174, N'436 White Nobel Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (5, 45, N'438 East Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (176, 168, N'438 Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (146, 54, N'44 South Nobel Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (223, 270, N'447 South Rocky Milton Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (68, 242, N'453 South Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (94, 157, N'455 South White Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (29, 272, N'460 North Rocky Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (52, 55, N'471 New Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (142, 21, N'478 South White Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (30, 145, N'483 Green Oak Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (167, 176, N'492 Green Milton Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (272, 252, N'495 East White Hague Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (199, 42, N'496 New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (26, 7, N'496 West White Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (198, 208, N'500 North Rocky Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (27, 21, N'504 South Oak Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (218, 78, N'506 Rocky Old St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (244, 296, N'507 South Green Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (202, 134, N'509 West White Second Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (275, 209, N'51 East Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (125, 147, N'513 South Green Old Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (152, 213, N'514 West Green Clarendon Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (141, 52, N'515 East Rocky Fabien Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (169, 158, N'516 West Hague Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (17, 292, N'517 East White Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (20, 149, N'520 North Green Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (160, 11, N'522 White New Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (114, 8, N'524 White Oak Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (253, 129, N'527 East Nobel Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (82, 179, N'530 South Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (213, 65, N'533 North Second Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (40, 248, N'533 Rocky Cowley Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (288, 75, N'538 South Green Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (158, 154, N'549 South White Second St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (164, 173, N'552 West Rocky Milton Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (179, 44, N'558 West Rocky Nobel Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (130, 131, N'561 South Green Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (187, 243, N'566 South Rocky Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (65, 144, N'568 East White Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (70, 221, N'570 East Rocky First Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (69, 190, N'570 Green New Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (276, 262, N'573 South White Milton Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (120, 37, N'574 Old Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (96, 104, N'578 South Rocky Second Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (78, 55, N'581 East White Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (273, 16, N'582 South White New St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (266, 258, N'583 East Rocky Second Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (98, 110, N'584 North Green Nobel Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (263, 73, N'59 East White Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (172, 88, N'595 West First Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (214, 26, N'597 East White Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (284, 279, N'598 North Green Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (212, 206, N'600 West Clarendon St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (286, 51, N'606 South Nobel Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (21, 223, N'607 East Rocky Hague Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (88, 195, N'611 Green Milton Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (42, 142, N'614 Green First Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (162, 274, N'616 Green Milton Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (225, 226, N'623 West Fabien Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (48, 18, N'625 East Cowley Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (41, 181, N'627 East Rocky New Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (71, 22, N'63 North White First St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (103, 118, N'632 East Green Fabien Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (235, 26, N'638 South White Nobel Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (265, 226, N'639 South Rocky Milton Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (83, 51, N'642 South Green Clarendon Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (174, 121, N'642 West White Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (102, 206, N'643 East White Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (156, 214, N'643 South Second Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (231, 76, N'644 West White Old Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (127, 248, N'645 East First Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (76, 117, N'645 North White Cowley Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (239, 297, N'650 South Old Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (257, 108, N'651 East Green Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (178, 246, N'652 West Milton Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (287, 131, N'657 Green Fabien Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (101, 252, N'660 North Second Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (296, 152, N'663 First Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (106, 231, N'671 South White First Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (261, 44, N'674 West Rocky First Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (192, 282, N'674 West White Fabien Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (132, 181, N'675 North Rocky Nobel Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (87, 240, N'677 South Green First Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (55, 26, N'677 White Clarendon Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (24, 170, N'684 North Nobel Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (79, 27, N'685 West Fabien Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (136, 140, N'686 Old Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (49, 48, N'688 North White Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (190, 67, N'690 First St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (38, 263, N'692 Green Fabien Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (229, 34, N'693 White Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (100, 109, N'70 First Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (19, 38, N'70 North First St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (118, 154, N'702 North Green Old Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (77, 31, N'704 North White Clarendon Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (278, 270, N'704 South Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (28, 96, N'706 East Green First Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (259, 259, N'708 South White Nobel Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (166, 28, N'71 East First Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (45, 245, N'711 North Rocky Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (217, 24, N'713 East Rocky First Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (128, 94, N'715 Rocky Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (237, 68, N'720 East Milton Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (299, 169, N'723 South Old Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (91, 229, N'729 South Green First Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (191, 35, N'729 West White Cowley St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (151, 82, N'731 North Green Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (147, 215, N'731 White Hague Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (143, 134, N'735 West Green Fabien Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (249, 163, N'737 West Second St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (131, 147, N'751 East Green Second Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (31, 211, N'753 West Green Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (246, 161, N'755 South Rocky Clarendon Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (111, 48, N'766 Fabien Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (90, 98, N'777 West Green Second Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (7, 244, N'779 East Rocky Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (282, 284, N'779 White Clarendon St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (3, 280, N'781 East White Oak Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (256, 28, N'782 West Rocky Old Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (269, 22, N'785 West White Nobel Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (145, 85, N'786 North Rocky Clarendon Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (140, 166, N'786 West White Milton Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (292, 298, N'789 West Green Nobel Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (117, 38, N'791 North White Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (268, 271, N'796 South Rocky Clarendon Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (155, 88, N'800 North Rocky Old Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (258, 172, N'806 West Green Fabien Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (289, 83, N'808 East White Fabien St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (182, 256, N'809 North Hague Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (23, 16, N'810 Cowley Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (115, 68, N'815 East Green Second Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (200, 275, N'82 South Rocky Hague Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (271, 81, N'823 Rocky Clarendon Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (62, 221, N'83 North White Oak Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (243, 278, N'837 East Green Second Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (165, 112, N'837 White Second Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (295, 12, N'838 North Green Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (216, 123, N'840 South Cowley Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (238, 93, N'842 South Green Cowley Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (9, 299, N'842 West Green Nobel Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (209, 186, N'847 Rocky Old Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (144, 116, N'850 East Green Milton Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (220, 174, N'850 West White Second Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (129, 256, N'857 North White Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (137, 64, N'86 White Hague Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (80, 244, N'864 North White First St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (67, 97, N'864 White Clarendon Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (250, 125, N'868 Green Hague Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (221, 134, N'873 South Rocky New Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (181, 67, N'874 North White Second Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (230, 177, N'874 White First Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (33, 107, N'877 North Second Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (159, 242, N'878 Green Clarendon Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (116, 48, N'881 Green New Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (92, 216, N'888 Rocky Old Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (154, 154, N'888 South Fabien Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (188, 161, N'889 East Rocky First Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (119, 95, N'897 West Rocky New Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (113, 82, N'900 North White Fabien Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (254, 117, N'91 Rocky Cowley Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (185, 204, N'91 White First Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (161, 275, N'910 North Rocky Hague Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (207, 174, N'914 North White Old Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (93, 131, N'921 East White Clarendon Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (99, 211, N'927 East White Hague Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (262, 245, N'937 White Oak Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (84, 284, N'939 South First Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (183, 112, N'940 North White Cowley Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (264, 56, N'948 Green Cowley Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (173, 115, N'948 West Rocky Hague Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (126, 238, N'95 South Old Drive')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (148, 154, N'952 North Rocky Old Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (233, 214, N'955 Green Second Parkway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (18, 289, N'958 North White New St.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (274, 39, N'958 West Cowley Road')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (153, 22, N'959 White Second Avenue')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (195, 13, N'961 New Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (107, 88, N'961 North Rocky Fabien Street')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (121, 32, N'966 North Green Clarendon Freeway')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (171, 130, N'966 North Green Clarendon Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (163, 77, N'973 East White Milton Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (51, 162, N'973 White Fabien Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (63, 59, N'976 East Milton Way')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (34, 94, N'99 South Oak Boulevard')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (219, 172, N'992 East Rocky Cowley Blvd.')
GO
INSERT [dbo].[CHINHANH] ([MaChiNhanh], [MaDT], [DiaChi]) VALUES (138, 278, N'992 West Clarendon Road')
GO
SET IDENTITY_INSERT [dbo].[CHINHANH] OFF
GO
SET IDENTITY_INSERT [dbo].[HOPDONG] ON 
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (1, 7393091, 25, N'Howard Harrington', N'NO        ', 123900, CAST(N'2023-08-01' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (2, 8177822, 223, N'Suzanne Sweeney', N'NO        ', 109681, CAST(N'2023-03-26' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (3, 7698777, 280, N'Aaron Adkins', N'YES       ', 269036, CAST(N'2023-06-20' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (4, 5759764, 270, N'Sandy Beck', N'NO        ', 103748, CAST(N'2023-02-07' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (5, 2762608, 45, N'Brooke Ferrell', N'NO        ', 178369, CAST(N'2023-10-26' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (6, 5759764, 270, N'Frank Li', N'YES       ', 131299, CAST(N'2022-11-13' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (7, 9145395, 244, N'Shaun Moody', N'NO        ', 101332, CAST(N'2023-05-13' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (8, 4545052, 138, N'Anita Mc Neil', N'NO        ', 159914, CAST(N'2023-10-08' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (9, 9706484, 299, N'Christie Wells', N'NO        ', 242308, CAST(N'2023-10-22' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (10, 3098431, 233, N'Bobby Casey', N'YES       ', 244841, CAST(N'2022-12-10' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (11, 3284871, 143, N'Tracey Whitney', N'NO        ', 189584, CAST(N'2023-01-18' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (12, 4790542, 17, N'Keisha Harrington', N'YES       ', 116087, CAST(N'2023-11-02' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (13, 6568786, 118, N'Anitra Patel', N'YES       ', 253844, CAST(N'2023-05-14' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (14, 4790542, 17, N'Loretta Webster', N'NO        ', 203833, CAST(N'2022-11-17' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (15, 9736312, 72, N'Brock Grimes', N'YES       ', 121830, CAST(N'2023-10-11' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (16, 1444687, 170, N'Patrick Heath', N'NO        ', 141871, CAST(N'2023-10-22' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (17, 8636400, 292, N'Molly Butler', N'YES       ', 230059, CAST(N'2022-12-01' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (18, 9898294, 289, N'Jason Holmes', N'NO        ', 174242, CAST(N'2023-12-28' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (19, 6969346, 38, N'Jacob Guerra', N'YES       ', 126597, CAST(N'2023-01-08' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (20, 3466934, 149, N'Jenifer Mendez', N'NO        ', 147482, CAST(N'2023-07-25' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (21, 8177822, 223, N'Candice Lang', N'NO        ', 267570, CAST(N'2023-12-19' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (22, 8472333, 182, N'Maribel Coffey', N'YES       ', 184681, CAST(N'2023-08-12' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (23, 9778132, 16, N'Erik Ross', N'YES       ', 140742, CAST(N'2023-04-08' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (24, 1444687, 170, N'Carla Ellison', N'NO        ', 132087, CAST(N'2023-06-06' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (25, 7115084, 116, N'Earl Andrade', N'YES       ', 167415, CAST(N'2023-05-05' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (26, 5602322, 7, N'Terrell Nichols', N'NO        ', 191723, CAST(N'2022-12-14' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (27, 9360517, 21, N'Tia Donovan', N'NO        ', 225756, CAST(N'2023-05-28' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (28, 7035942, 96, N'Damian Henry', N'YES       ', 231393, CAST(N'2023-02-26' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (29, 5678311, 272, N'Colleen Forbes', N'NO        ', 296106, CAST(N'2023-02-18' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (30, 1753431, 145, N'Jessica Maldonado', N'YES       ', 147446, CAST(N'2022-11-19' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (31, 2657794, 211, N'Mason English', N'NO        ', 152211, CAST(N'2023-07-27' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (32, 4601288, 80, N'Rita Rush', N'NO        ', 128375, CAST(N'2023-04-22' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (33, 3315248, 107, N'Brooke Reeves', N'NO        ', 291489, CAST(N'2023-04-03' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (34, 9756411, 94, N'Oscar Ortega', N'YES       ', 129561, CAST(N'2023-01-13' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (35, 6678880, 28, N'Wanda Carey', N'YES       ', 248411, CAST(N'2022-12-09' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (36, 7661585, 101, N'Jeanine Burton', N'YES       ', 149685, CAST(N'2023-03-05' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (37, 1444687, 170, N'Eugene Vaughan', N'NO        ', 210056, CAST(N'2023-04-11' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (38, 4063037, 263, N'Clinton Diaz', N'YES       ', 283448, CAST(N'2023-07-14' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (39, 3737019, 226, N'Clayton Gay', N'YES       ', 174226, CAST(N'2023-06-20' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (40, 9457514, 248, N'Jerome Edwards', N'NO        ', 175717, CAST(N'2023-12-09' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (41, 5456926, 181, N'Warren Romero', N'YES       ', 113499, CAST(N'2023-10-22' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (42, 7328098, 142, N'Arthur Morse', N'NO        ', 110950, CAST(N'2023-03-22' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (43, 2080034, 247, N'Constance Thornton', N'NO        ', 149801, CAST(N'2023-10-16' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (44, 3098431, 233, N'Joann Dawson', N'YES       ', 123778, CAST(N'2023-02-07' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (45, 9183576, 245, N'Gloria Cordova', N'YES       ', 276225, CAST(N'2023-04-23' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (46, 8067334, 4, N'Tanisha Stanton', N'NO        ', 269947, CAST(N'2023-09-08' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (47, 3663969, 152, N'Virginia Winters', N'YES       ', 171629, CAST(N'2023-08-25' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (48, 4635266, 18, N'Loren Herring', N'NO        ', 257360, CAST(N'2023-10-08' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (49, 2324523, 48, N'Marissa Little', N'NO        ', 273089, CAST(N'2023-12-16' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (50, 2867036, 110, N'Jamal Mueller', N'NO        ', 286156, CAST(N'2022-11-27' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (51, 4313253, 162, N'Kenny Blair', N'NO        ', 259400, CAST(N'2023-11-25' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (52, 7335671, 55, N'Chastity Stevens', N'NO        ', 115163, CAST(N'2023-06-13' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (53, 6455848, 37, N'Brenda Leonard', N'NO        ', 190375, CAST(N'2023-01-16' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (54, 5237474, 199, N'Francis Stone', N'YES       ', 140950, CAST(N'2023-04-24' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (55, 2712669, 26, N'Kellie Whitney', N'YES       ', 181422, CAST(N'2023-07-17' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (56, 8840846, 63, N'Damion Boyer', N'YES       ', 239219, CAST(N'2023-12-20' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (57, 8289167, 29, N'Juan Figueroa', N'NO        ', 268939, CAST(N'2023-12-18' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (58, 7548252, 58, N'Marty Warner', N'YES       ', 236948, CAST(N'2022-11-15' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (59, 8545874, 111, N'Edith Reynolds', N'NO        ', 236334, CAST(N'2023-10-06' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (60, 6969346, 38, N'Jessie Cole', N'YES       ', 286647, CAST(N'2023-09-12' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (61, 6494602, 252, N'Dorothy Wilson', N'NO        ', 205543, CAST(N'2023-06-19' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (62, 2846738, 221, N'Bridget Wilkins', N'NO        ', 169939, CAST(N'2023-01-15' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (63, 8990361, 59, N'Shelia Palmer', N'YES       ', 163808, CAST(N'2023-06-20' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (64, 8990361, 59, N'Colby Moss', N'YES       ', 194861, CAST(N'2023-10-04' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (65, 1770766, 144, N'Ruby Sullivan', N'YES       ', 192629, CAST(N'2023-05-17' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (66, 8433369, 259, N'Margarita Davenport', N'NO        ', 161209, CAST(N'2023-09-29' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (67, 2540196, 97, N'Whitney Rose', N'NO        ', 124599, CAST(N'2023-06-02' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (68, 6697974, 242, N'Jody Wallace', N'NO        ', 224283, CAST(N'2023-03-01' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (69, 8402912, 190, N'Steve Lin', N'NO        ', 255422, CAST(N'2023-12-09' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (70, 2846738, 221, N'Jesus Hardin', N'YES       ', 272146, CAST(N'2023-06-09' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (71, 9949872, 22, N'Cherie Frank', N'NO        ', 231816, CAST(N'2023-05-13' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (72, 4919153, 121, N'Tonya Hunt', N'NO        ', 246612, CAST(N'2023-05-21' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (73, 6725398, 76, N'Noel Bird', N'NO        ', 100015, CAST(N'2023-05-11' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (74, 7335671, 55, N'Susana Roach', N'YES       ', 250881, CAST(N'2023-01-31' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (75, 8102554, 195, N'Adrian Yang', N'NO        ', 133983, CAST(N'2023-10-03' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (76, 1891828, 117, N'Alfonso Cabrera', N'NO        ', 256620, CAST(N'2023-07-30' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (77, 7496580, 31, N'Becky Gregory', N'NO        ', 134879, CAST(N'2023-10-28' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (78, 7335671, 55, N'Brian Barrera', N'YES       ', 116963, CAST(N'2022-12-30' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (79, 2127397, 27, N'Sandra Galvan', N'YES       ', 155862, CAST(N'2022-12-14' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (80, 9145395, 244, N'Anitra Mack', N'YES       ', 197468, CAST(N'2023-08-28' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (81, 2657794, 211, N'Jo O''Neal', N'NO        ', 120094, CAST(N'2023-04-21' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (82, 4887688, 179, N'Gilberto Howe', N'NO        ', 268397, CAST(N'2023-08-20' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (83, 5667291, 51, N'Becky Hull', N'YES       ', 258305, CAST(N'2023-03-14' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (84, 3502729, 284, N'Gene Gardner', N'NO        ', 109950, CAST(N'2023-01-22' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (85, 6947005, 158, N'Marisa Lester', N'NO        ', 188047, CAST(N'2022-12-26' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (86, 4790542, 17, N'Nick Sutton', N'YES       ', 137047, CAST(N'2022-12-15' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (87, 8428879, 240, N'Edith Harris', N'YES       ', 238001, CAST(N'2023-02-05' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (88, 8102554, 195, N'Ramiro Barrett', N'NO        ', 250539, CAST(N'2023-12-11' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (89, 8067334, 4, N'Damien Turner', N'NO        ', 248140, CAST(N'2023-06-29' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (90, 7684695, 98, N'Edith Adams', N'NO        ', 109191, CAST(N'2022-12-21' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (91, 9423151, 229, N'Omar Barton', N'YES       ', 180747, CAST(N'2023-03-18' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (92, 3297652, 216, N'Neil Kline', N'YES       ', 273108, CAST(N'2023-03-27' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (93, 5557043, 131, N'Dean Proctor', N'NO        ', 147114, CAST(N'2023-10-08' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (94, 6860522, 157, N'Gilberto Morrison', N'YES       ', 187580, CAST(N'2023-10-08' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (95, 3537703, 225, N'Yesenia Callahan', N'YES       ', 270174, CAST(N'2023-04-22' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (96, 3197823, 104, N'Randy Carter', N'NO        ', 243561, CAST(N'2023-08-07' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (97, 8213346, 136, N'Cecil Whitehead', N'NO        ', 247142, CAST(N'2023-10-02' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (98, 2867036, 110, N'Abel Rosales', N'NO        ', 254940, CAST(N'2022-11-13' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (99, 2657794, 211, N'Dawn Orr', N'NO        ', 231149, CAST(N'2023-09-24' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (100, 1672049, 109, N'Chrystal Gould', N'NO        ', 215016, CAST(N'2023-07-26' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (101, 6494602, 252, N'Keisha Hardy', N'YES       ', 245348, CAST(N'2023-02-06' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (102, 7046264, 206, N'Derick Stephens', N'YES       ', 247347, CAST(N'2023-04-26' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (103, 6568786, 118, N'Kara Randall', N'YES       ', 101937, CAST(N'2023-10-30' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (104, 9290016, 231, N'Terrence Glover', N'NO        ', 100943, CAST(N'2023-05-09' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (105, 2867036, 110, N'Norma Cannon', N'NO        ', 154339, CAST(N'2023-07-17' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (106, 9290016, 231, N'Victoria Mc Donald', N'NO        ', 112788, CAST(N'2023-05-07' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (107, 1650380, 88, N'Lorraine Simmons', N'YES       ', 115148, CAST(N'2022-12-04' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (108, 9123791, 180, N'Cheryl Valenzuela', N'YES       ', 239495, CAST(N'2023-12-17' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (109, 6969346, 38, N'Claude Hardy', N'YES       ', 106967, CAST(N'2023-07-22' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (110, 1843830, 79, N'Kent Randall', N'YES       ', 224803, CAST(N'2023-12-18' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (111, 2324523, 48, N'Barbara Crane', N'NO        ', 204340, CAST(N'2022-12-24' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (112, 2018842, 175, N'Jonathon Hampton', N'NO        ', 251975, CAST(N'2023-10-19' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (113, 6315667, 82, N'Jared Mueller', N'NO        ', 181085, CAST(N'2023-12-03' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (114, 9453077, 8, N'Rosa Wheeler', N'YES       ', 138865, CAST(N'2022-12-10' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (115, 5253028, 68, N'Brock Gilbert', N'YES       ', 266553, CAST(N'2023-03-25' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (116, 2324523, 48, N'Debbie Pace', N'NO        ', 237147, CAST(N'2023-10-31' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (117, 6969346, 38, N'Alisa Gonzales', N'YES       ', 211635, CAST(N'2023-11-04' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (118, 5839843, 154, N'Tamika Carlson', N'YES       ', 153858, CAST(N'2023-03-30' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (119, 2890491, 95, N'Christie Vega', N'YES       ', 106814, CAST(N'2023-08-10' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (120, 6455848, 37, N'Sergio Shields', N'YES       ', 155581, CAST(N'2023-04-02' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (121, 1057879, 32, N'Darnell Nash', N'NO        ', 223209, CAST(N'2023-06-24' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (122, 3879255, 122, N'Chester Garcia', N'YES       ', 174061, CAST(N'2023-06-23' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (123, 8503001, 198, N'Bernard Ayers', N'YES       ', 276144, CAST(N'2023-09-02' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (124, 1650341, 235, N'Adriana Blair', N'NO        ', 246230, CAST(N'2023-10-20' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (125, 3182220, 147, N'Reginald Brandt', N'NO        ', 191398, CAST(N'2023-01-22' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (126, 7212187, 238, N'Lester Rodriguez', N'YES       ', 258709, CAST(N'2022-12-18' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (127, 9457514, 248, N'Lloyd Sullivan', N'YES       ', 199497, CAST(N'2023-08-13' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (128, 9756411, 94, N'Alfred Thompson', N'YES       ', 212436, CAST(N'2023-08-04' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (129, 4169215, 256, N'Tamiko Pierce', N'NO        ', 280707, CAST(N'2023-10-11' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (130, 5557043, 131, N'Angelo Fischer', N'NO        ', 190422, CAST(N'2022-12-27' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (131, 3182220, 147, N'Alison Dawson', N'YES       ', 109478, CAST(N'2023-10-29' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (132, 5456926, 181, N'Lynette Burke', N'NO        ', 179939, CAST(N'2023-10-15' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (133, 5632126, 105, N'Candice O''Connor', N'YES       ', 185815, CAST(N'2023-04-08' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (134, 1602574, 155, N'Gregory Browning', N'NO        ', 240847, CAST(N'2023-05-21' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (135, 3182220, 147, N'Carey Heath', N'YES       ', 252121, CAST(N'2023-05-22' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (136, 5319114, 140, N'Emma Frye', N'NO        ', 172747, CAST(N'2023-12-27' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (137, 8458309, 64, N'Jeremy Downs', N'NO        ', 266460, CAST(N'2023-10-21' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (138, 6398030, 278, N'Marcie Cruz', N'NO        ', 257361, CAST(N'2023-11-05' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (139, 1955034, 41, N'Gabriel Kent', N'NO        ', 255611, CAST(N'2023-07-08' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (140, 7566189, 166, N'Paul Travis', N'YES       ', 175258, CAST(N'2023-08-21' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (141, 4272061, 52, N'Elisa Waters', N'YES       ', 121899, CAST(N'2022-11-12' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (142, 9360517, 21, N'Wesley Petersen', N'NO        ', 298507, CAST(N'2023-02-20' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (143, 2144165, 134, N'Norman Donaldson', N'YES       ', 243572, CAST(N'2023-03-22' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (144, 7115084, 116, N'Julie Keller', N'NO        ', 123336, CAST(N'2023-07-13' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (145, 6442300, 85, N'Christy Hicks', N'YES       ', 204852, CAST(N'2023-12-28' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (146, 8404505, 54, N'Lorie Shields', N'NO        ', 228772, CAST(N'2023-05-30' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (147, 7004397, 215, N'Travis Moss', N'NO        ', 192023, CAST(N'2023-04-25' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (148, 5839843, 154, N'Nathaniel Gamble', N'YES       ', 108248, CAST(N'2023-08-30' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (149, 2540196, 97, N'Alfredo Meyers', N'NO        ', 221027, CAST(N'2023-05-17' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (150, 2589243, 153, N'Jana Adams', N'NO        ', 133027, CAST(N'2023-06-22' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (151, 6315667, 82, N'Jeanine Cobb', N'NO        ', 131925, CAST(N'2023-10-04' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (152, 2955906, 213, N'Cara Walsh', N'YES       ', 193283, CAST(N'2023-05-06' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (153, 9949872, 22, N'Frederick Rivas', N'YES       ', 248126, CAST(N'2023-04-05' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (154, 5839843, 154, N'Margarita Payne', N'YES       ', 175568, CAST(N'2023-04-24' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (155, 1650380, 88, N'Casey Kelly', N'NO        ', 291807, CAST(N'2022-12-03' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (156, 3078968, 214, N'Clay Arellano', N'YES       ', 171286, CAST(N'2023-08-16' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (157, 8436339, 183, N'Otis Rowe', N'YES       ', 271204, CAST(N'2023-08-24' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (158, 5839843, 154, N'Kimberley Valdez', N'NO        ', 155707, CAST(N'2022-11-11' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (159, 6697974, 242, N'Lorenzo Solis', N'NO        ', 209545, CAST(N'2023-02-15' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (160, 5507045, 11, N'Saul Booth', N'YES       ', 195631, CAST(N'2023-05-31' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (161, 9638458, 275, N'Wendell Frank', N'YES       ', 213291, CAST(N'2023-09-25' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (162, 1733184, 274, N'Bryce Howe', N'NO        ', 202712, CAST(N'2023-05-03' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (163, 5484505, 77, N'Michelle Wong', N'YES       ', 258788, CAST(N'2023-01-06' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (164, 2453128, 173, N'Darcy Medina', N'NO        ', 216545, CAST(N'2023-05-27' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (165, 8111197, 112, N'Gilberto Burton', N'YES       ', 215325, CAST(N'2022-12-21' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (166, 6678880, 28, N'Randal Bass', N'NO        ', 124400, CAST(N'2023-03-11' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (167, 5898500, 176, N'Rene Davies', N'YES       ', 166160, CAST(N'2023-05-14' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (168, 5687816, 250, N'Jacob Frederick', N'NO        ', 240238, CAST(N'2023-05-16' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (169, 6947005, 158, N'Jay Brooks', N'YES       ', 186745, CAST(N'2023-07-21' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (170, 9898294, 289, N'Alfredo Lucas', N'NO        ', 193805, CAST(N'2023-03-29' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (171, 3317471, 130, N'Nora Pope', N'NO        ', 270687, CAST(N'2022-11-11' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (172, 1650380, 88, N'Marco Burch', N'NO        ', 254274, CAST(N'2023-12-30' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (173, 4703484, 115, N'Carolyn Mac Donald', N'YES       ', 198248, CAST(N'2023-09-22' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (174, 4919153, 121, N'Brooke Osborne', N'YES       ', 231556, CAST(N'2023-12-21' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (175, 2830721, 277, N'Teri Nash', N'YES       ', 133682, CAST(N'2023-03-22' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (176, 1676607, 168, N'Shelley Reed', N'NO        ', 224703, CAST(N'2023-03-04' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (177, 2910603, 218, N'Betsy Herring', N'YES       ', 230490, CAST(N'2023-02-02' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (178, 2379506, 246, N'Chastity Trevino', N'YES       ', 252807, CAST(N'2022-12-22' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (179, 4562421, 44, N'Felicia Clay', N'NO        ', 141378, CAST(N'2023-10-23' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (180, 4601288, 80, N'Esteban Roach', N'NO        ', 262627, CAST(N'2023-08-26' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (181, 1240422, 67, N'Brenda Fields', N'NO        ', 166686, CAST(N'2023-08-26' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (182, 4169215, 256, N'Brent Phelps', N'NO        ', 191249, CAST(N'2023-12-15' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (183, 8111197, 112, N'Alexander Griffith', N'NO        ', 291409, CAST(N'2023-01-18' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (184, 2747442, 222, N'Ron Patel', N'YES       ', 247680, CAST(N'2023-02-19' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (185, 9196928, 204, N'Susana Higgins', N'YES       ', 158497, CAST(N'2023-03-25' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (186, 1425379, 230, N'Antoine Pollard', N'NO        ', 216195, CAST(N'2023-04-25' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (187, 5456938, 243, N'Heath Ford', N'NO        ', 231814, CAST(N'2023-05-13' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (188, 9507389, 161, N'Latoya Munoz', N'YES       ', 110246, CAST(N'2023-12-15' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (189, 9898294, 289, N'Blanca Maynard', N'YES       ', 249040, CAST(N'2023-04-18' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (190, 1240422, 67, N'Shauna Hale', N'YES       ', 180834, CAST(N'2023-10-06' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (191, 6766596, 35, N'Craig Owen', N'NO        ', 201544, CAST(N'2023-03-05' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (192, 3167976, 282, N'Teddy Glover', N'YES       ', 210752, CAST(N'2023-10-11' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (193, 9624785, 74, N'Eduardo Osborne', N'NO        ', 147815, CAST(N'2023-07-21' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (194, 5967962, 276, N'Faith Molina', N'NO        ', 159979, CAST(N'2022-12-09' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (195, 7722753, 13, N'Bryant Curtis', N'NO        ', 261968, CAST(N'2023-11-26' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (196, 3502729, 284, N'Scott Mc Daniel', N'NO        ', 219188, CAST(N'2023-07-13' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (197, 4364324, 191, N'Rosa Blevins', N'YES       ', 139718, CAST(N'2022-12-16' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (198, 9679262, 208, N'Rodolfo Spencer', N'YES       ', 127026, CAST(N'2023-10-27' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (199, 8954251, 42, N'Guadalupe Rush', N'NO        ', 208012, CAST(N'2023-05-23' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (200, 9638458, 275, N'Karen Best', N'YES       ', 180452, CAST(N'2023-08-20' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (201, 3009232, 30, N'Vincent Keller', N'NO        ', 162611, CAST(N'2022-11-16' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (202, 2144165, 134, N'Israel Benjamin', N'NO        ', 251785, CAST(N'2023-12-11' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (203, 9022628, 202, N'Isaac Young', N'YES       ', 221504, CAST(N'2022-12-10' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (204, 2561604, 165, N'Betsy Jones', N'YES       ', 127222, CAST(N'2022-12-19' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (205, 8878177, 236, N'Drew Sanders', N'YES       ', 162340, CAST(N'2023-06-12' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (206, 5670071, 203, N'Colleen Mc Mahon', N'NO        ', 177651, CAST(N'2023-10-05' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (207, 7932902, 174, N'Betsy Cordova', N'YES       ', 295036, CAST(N'2023-08-14' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (208, 5507045, 11, N'Marvin Jordan', N'NO        ', 116569, CAST(N'2023-04-16' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (209, 3822122, 186, N'Quincy Russo', N'YES       ', 141886, CAST(N'2022-12-03' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (210, 9778132, 16, N'Ross Powell', N'NO        ', 167104, CAST(N'2023-10-01' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (211, 1448913, 185, N'Andy Guzman', N'NO        ', 240797, CAST(N'2023-05-15' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (212, 7046264, 206, N'Jeff Wong', N'NO        ', 118396, CAST(N'2023-07-03' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (213, 2115900, 65, N'Cherie Archer', N'NO        ', 114329, CAST(N'2023-01-19' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (214, 2712669, 26, N'Johnathan Reyes', N'NO        ', 246919, CAST(N'2023-06-23' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (215, 5319114, 140, N'Rogelio Bright', N'YES       ', 128945, CAST(N'2023-10-06' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (216, 5945107, 123, N'Ralph Weaver', N'YES       ', 122042, CAST(N'2023-10-12' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (217, 3072344, 24, N'Kristin Jacobson', N'NO        ', 211303, CAST(N'2023-02-13' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (218, 3380677, 78, N'Tania Ochoa', N'YES       ', 111108, CAST(N'2023-11-17' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (219, 2935529, 172, N'Colleen Watson', N'YES       ', 158047, CAST(N'2023-01-02' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (220, 7932902, 174, N'Lucas Soto', N'YES       ', 299130, CAST(N'2023-08-28' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (221, 2144165, 134, N'Angela Wolf', N'YES       ', 192586, CAST(N'2023-10-30' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (222, 6398030, 278, N'Chester Bridges', N'YES       ', 155913, CAST(N'2023-05-31' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (223, 5759764, 270, N'Todd Schneider', N'NO        ', 291199, CAST(N'2022-11-28' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (224, 6766596, 35, N'Michele Baird', N'YES       ', 105910, CAST(N'2023-10-15' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (225, 3737019, 226, N'Candy Combs', N'NO        ', 292262, CAST(N'2022-11-25' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (226, 1258385, 120, N'Kendrick Solomon', N'YES       ', 159935, CAST(N'2023-02-01' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (227, 1888020, 139, N'Liza Hanson', N'NO        ', 206458, CAST(N'2023-04-12' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (228, 8840846, 63, N'Greg Mays', N'NO        ', 138268, CAST(N'2023-08-15' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (229, 7301208, 34, N'Melody Roy', N'NO        ', 269589, CAST(N'2022-11-25' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (230, 8975850, 177, N'Trisha Baldwin', N'YES       ', 214494, CAST(N'2023-09-10' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (231, 6725398, 76, N'Clay Phillips', N'NO        ', 184984, CAST(N'2023-01-18' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (232, 3009232, 30, N'Elena Andrade', N'NO        ', 203463, CAST(N'2023-04-08' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (233, 3078968, 214, N'Christi Molina', N'NO        ', 144795, CAST(N'2023-08-02' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (234, 4826707, 267, N'Ian Gallagher', N'YES       ', 260926, CAST(N'2023-01-04' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (235, 2712669, 26, N'Brenda Ball', N'YES       ', 200015, CAST(N'2023-08-10' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (236, 8962067, 114, N'Roxanne Williamson', N'YES       ', 214901, CAST(N'2023-09-16' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (237, 5253028, 68, N'Debra Collins', N'NO        ', 269746, CAST(N'2023-11-05' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (238, 6658266, 93, N'Lora Patrick', N'NO        ', 264187, CAST(N'2022-12-01' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (239, 3482792, 297, N'Norma Levine', N'YES       ', 185339, CAST(N'2023-09-10' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (240, 3963175, 241, N'Willie Williams', N'YES       ', 280846, CAST(N'2023-06-21' AS Date), 3)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (241, 2935710, 184, N'Shanna Warren', N'YES       ', 221160, CAST(N'2023-09-12' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (242, 9898294, 289, N'Karin Rivers', N'YES       ', 215245, CAST(N'2022-11-28' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (243, 6398030, 278, N'Johanna Castillo', N'NO        ', 268361, CAST(N'2023-11-12' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (244, 1016361, 296, N'Bethany Barrett', N'YES       ', 181936, CAST(N'2023-07-19' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (245, 9747003, 239, N'Daryl Marsh', N'YES       ', 240038, CAST(N'2023-03-24' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (246, 9507389, 161, N'Kristi Riddle', N'YES       ', 183147, CAST(N'2023-09-02' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (247, 2455301, 71, N'Cecil Arias', N'YES       ', 196422, CAST(N'2023-07-23' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (248, 7722753, 13, N'Albert Pearson', N'NO        ', 200897, CAST(N'2022-11-29' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (249, 1836332, 163, N'Marsha Powell', N'YES       ', 131034, CAST(N'2023-03-05' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (250, 2666544, 125, N'Tara Bowman', N'YES       ', 239926, CAST(N'2022-12-16' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (251, 1650341, 235, N'Trina Weeks', N'NO        ', 107884, CAST(N'2023-03-30' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (252, 2027832, 192, N'Angelique York', N'YES       ', 128609, CAST(N'2023-01-29' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (253, 7539409, 129, N'Constance Roy', N'NO        ', 268980, CAST(N'2023-08-25' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (254, 1891828, 117, N'Marianne Clarke', N'YES       ', 208882, CAST(N'2023-09-25' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (255, 8433369, 259, N'Aaron Paul', N'YES       ', 287866, CAST(N'2023-10-21' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (256, 6678880, 28, N'Angelique Frye', N'NO        ', 106697, CAST(N'2023-06-19' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (257, 5876488, 108, N'Jenifer Abbott', N'NO        ', 260587, CAST(N'2023-11-13' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (258, 2935529, 172, N'Omar Nielsen', N'NO        ', 215594, CAST(N'2023-02-25' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (259, 8433369, 259, N'Carey Clay', N'YES       ', 134961, CAST(N'2022-11-25' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (260, 8545874, 111, N'Shonda Sullivan', N'NO        ', 102405, CAST(N'2023-03-12' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (261, 4562421, 44, N'Ellen Davies', N'YES       ', 271193, CAST(N'2023-04-26' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (262, 9183576, 245, N'Bethany Reynolds', N'NO        ', 256767, CAST(N'2023-12-30' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (263, 8076452, 73, N'Andres Nicholson', N'YES       ', 146980, CAST(N'2023-03-22' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (264, 4674135, 56, N'Shanna Valenzuela', N'NO        ', 227392, CAST(N'2023-03-26' AS Date), 1)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (265, 3737019, 226, N'Brian Conner', N'YES       ', 282120, CAST(N'2023-07-14' AS Date), 5)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (266, 7772149, 258, N'Herman Blair', N'YES       ', 137334, CAST(N'2022-12-07' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (267, 4448022, 126, N'Tracey Mc Daniel', N'NO        ', 273602, CAST(N'2023-12-02' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (268, 6704858, 271, N'Melissa Kidd', N'YES       ', 153404, CAST(N'2022-11-15' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (269, 9949872, 22, N'Leslie Olsen', N'NO        ', 146903, CAST(N'2023-11-13' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (270, 6315667, 82, N'Jennifer Brock', N'YES       ', 214044, CAST(N'2022-11-21' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (271, 1834390, 81, N'Chris Medina', N'NO        ', 152296, CAST(N'2023-12-07' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (272, 6494602, 252, N'Diane Luna', N'YES       ', 247117, CAST(N'2023-01-13' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (273, 9778132, 16, N'Kendall Hayden', N'YES       ', 225769, CAST(N'2023-01-08' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (274, 8743711, 39, N'Keith Donaldson', N'YES       ', 177202, CAST(N'2023-07-15' AS Date), 13)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (275, 5662878, 209, N'Annette Houston', N'NO        ', 177969, CAST(N'2023-12-17' AS Date), 9)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (276, 2209911, 262, N'Candace Grant', N'NO        ', 277342, CAST(N'2023-10-03' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (277, 1016361, 296, N'Chandra Schultz', N'YES       ', 187552, CAST(N'2023-07-19' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (278, 5759764, 270, N'Rudy Rodriguez', N'NO        ', 209262, CAST(N'2023-05-13' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (279, 6947005, 158, N'Christian George', N'YES       ', 165873, CAST(N'2023-05-24' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (280, 3997734, 237, N'Elijah Meyers', N'NO        ', 209114, CAST(N'2023-03-25' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (281, 8640500, 232, N'Ralph Hess', N'YES       ', 263513, CAST(N'2023-07-12' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (282, 3502729, 284, N'Micheal Rodriguez', N'NO        ', 105561, CAST(N'2023-03-14' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (283, 7932902, 174, N'Dominic Odom', N'NO        ', 107234, CAST(N'2023-04-13' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (284, 5517992, 279, N'Eduardo Roach', N'YES       ', 129663, CAST(N'2023-12-10' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (285, 8402912, 190, N'Rex Bond', N'NO        ', 206610, CAST(N'2023-04-13' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (286, 5667291, 51, N'Clinton Adkins', N'NO        ', 156374, CAST(N'2023-12-21' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (287, 5557043, 131, N'Dan Nelson', N'NO        ', 234484, CAST(N'2023-08-15' AS Date), 11)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (288, 2464670, 75, N'Annette Abbott', N'YES       ', 235913, CAST(N'2023-11-08' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (289, 6639638, 83, N'William Day', N'YES       ', 273060, CAST(N'2023-03-16' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (290, 5687816, 250, N'Lillian Hull', N'NO        ', 193318, CAST(N'2022-12-23' AS Date), 12)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (291, 3466934, 149, N'Noel Rubio', N'NO        ', 254315, CAST(N'2023-11-03' AS Date), 15)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (292, 2941328, 298, N'Kirsten Holmes', N'NO        ', 154152, CAST(N'2023-07-12' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (293, 8076452, 73, N'Betsy Hampton', N'YES       ', 229225, CAST(N'2022-11-07' AS Date), 6)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (294, 4674135, 56, N'Steve Rhodes', N'YES       ', 182934, CAST(N'2023-05-01' AS Date), 7)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (295, 9272442, 12, N'Matt Kidd', N'NO        ', 109652, CAST(N'2022-12-26' AS Date), 4)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (296, 3663969, 152, N'Kara Wyatt', N'NO        ', 264394, CAST(N'2023-09-13' AS Date), 10)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (297, 2666544, 125, N'Elena Barrett', N'NO        ', 168264, CAST(N'2023-09-08' AS Date), 2)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (298, 2379506, 246, N'Darryl Quinn', N'NO        ', 140969, CAST(N'2023-06-20' AS Date), 14)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (299, 6849814, 169, N'Bernard Randolph', N'NO        ', 199816, CAST(N'2022-11-05' AS Date), 8)
GO
INSERT [dbo].[HOPDONG] ([MaHD], [MaSoThue], [MaDT], [NguoiDaiDien], [TinhTrangKichHoat], [PhiHoaHong], [NgayHetHan], [PhanTramHoaHong]) VALUES (300, 2762608, 45, N'Sam Johnston', N'NO        ', 202704, CAST(N'2023-02-15' AS Date), 15)
GO
SET IDENTITY_INSERT [dbo].[HOPDONG] OFF
GO
SET IDENTITY_INSERT [dbo].[KHACHHANG] ON 
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (1, N'Maggie Dominguez', N'6594506166', N'191 White Milton Way', N'fxjgej.ydtatecrq@tjbnpk.org                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (2, N'Jamison Stout', N'8834974142', N'259 White First Road', N'odypiu.ycogkg@ftjuuc.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (3, N'Roger Hoover', N'5102422187', N'30 Fabien Blvd.', N'yqgedjuv.zdank@pdpbp.mvehw-.com                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (4, N'Yolanda Jackson', N'6196844286', N'24 Hague Avenue', N'kmurs.mpitg@jwshd-.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (5, N'Jeffrey Ashley', N'6525506942', N'63 First Street', N'bbir.xbxuqdor@srzd.gihiel.com                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (6, N'Donnie Goodman', N'1165064661', N'43 Milton Drive', N'nwinkk.aumonkyq@sqxpm.bkus-h.com                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (7, N'Alice Weaver', N'9636611618', N'787 Green First Freeway', N'onky1@mrwnpb.jsylss.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (8, N'Franklin Garza', N'6383305017', N'248 Green Clarendon Way', N'jhlz.isgq@--huol.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (9, N'Kris Middleton', N'1724090769', N'90 Green Nobel Way', N'ypnmkx30@vmozf.qndzpx.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (10, N'Gregory Pierce', N'1594003377', N'66 Cowley Street', N'wkjdxhqh.uypsq@fmeenlio.unfyzp.net                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (11, N'Oscar Andrade', N'8786021745', N'361 New Parkway', N'byygdwe.ufhpyxd@jkviya.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (12, N'Marcus Lloyd', N'9853924439', N'22 White First Drive', N'mcabud660@qzqarchtw.bfofmm.net                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (13, N'Hugh Shaffer', N'1911152838', N'757 Cowley St.', N'wrpjcnla32@qjulfihyh.qlyuey.com                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (14, N'Marcus Johns', N'6883186349', N'27 Fabien Drive', N'zrfkm@qbajoj.pfkahj.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (15, N'Wendell Villanueva', N'2300081835', N'660 East Rocky Clarendon Boulevard', N'jutq.vdtrip@wnobsq.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (16, N'Marty David', N'6289663368', N'504 Nobel Street', N'kccwfym59@rngoyvxhs.ufiixm.org                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (17, N'Johanna Stein', N'1526272688', N'95 Rocky Hague Way', N'cbbkr.lwqhg@nee-hn.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (18, N'Debbie Parsons', N'8637153808', N'34 Green Second Boulevard', N'zarv8@zeyvfz.org                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (19, N'Lee Carter', N'7616746181', N'824 Green New Way', N'tvmy441@cxervg.org                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (20, N'Clarence Morrow', N'0638898712', N'437 Nobel St.', N'svfdqhch@eydosh.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (21, N'Karin Hubbard', N'7936056720', N'875 Rocky Clarendon St.', N'afjdx.rtncofy@mrwrdr.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (22, N'Jorge Wilcox', N'7742422907', N'44 Second Way', N'jlzet.nlia@cfzvknn.fbfkba.org                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (23, N'Marc Coleman', N'6320709148', N'74 South Green Fabien Road', N'eoiuqt2@oocwya.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (24, N'Dawn Leblanc', N'5793237692', N'898 East Old Freeway', N'mwwtex377@xbgtss.net                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (25, N'Margaret Melendez', N'0122877796', N'731 Milton Boulevard', N'tionkyd335@ohucwq.com                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (26, N'Peter Frederick', N'4588710134', N'15 North Green Fabien Parkway', N'xmgormvd70@hftzwa.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (27, N'Gregory Davis', N'8532013557', N'94 Rocky Hague Boulevard', N'kdyinz.wetqkbg@qgbb-t.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (28, N'Darryl Barker', N'3216994448', N'503 Green Hague Blvd.', N'zzok.oambc@zvdqmo.com                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (29, N'Yvonne Sutton', N'9255981146', N'216 White Clarendon Road', N'egzxtfta33@akezke.xzdgxr.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (30, N'Brock Manning', N'8559892683', N'53 Clarendon Road', N'lnef.tondo@crsexl.net                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (31, N'Katherine Ball', N'7811230818', N'13 Rocky Second Street', N'mneel86@gcxwfd.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (32, N'Peter Cunningham', N'7075036380', N'258 Green Nobel Parkway', N'gwrvw7@bzgqeya.aiomsx.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (33, N'Jenifer Gutierrez', N'3289067041', N'87 East Rocky First Freeway', N'nwfumbgt.vsiu@yjnvgq.net                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (34, N'Claire Howell', N'6502294989', N'443 Milton Parkway', N'wgch@nvwuo.z-slag.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (35, N'Maurice Glenn', N'9502069984', N'61 Green Nobel Street', N'rgncnij@fyeyyq.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (36, N'Melisa Griffith', N'9915634677', N'78 North Old St.', N'bfnyb.kndvprw@wuafvk.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (37, N'Kenny Johnston', N'6396654384', N'83 Green Cowley Blvd.', N'zwioucuv0@hmecxviyg.iipadp.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (38, N'Marisa Krause', N'3190954337', N'169 Hague Street', N'qdly8@izicvl.com                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (39, N'Clayton Campbell', N'9596986884', N'14 South New Drive', N'hwdyos@ed-pfr.com                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (40, N'Rose Bradley', N'2716943964', N'155 Green New Parkway', N'yrihofg981@dmwsky.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (41, N'Phillip Acevedo', N'1591518281', N'35 East Milton Boulevard', N'iepqqm7@lnue-i.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (42, N'Frankie Riddle', N'1244257215', N'646 First Parkway', N'dsdwl05@gshmhd.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (43, N'Roy Allen', N'0657742938', N'60 Fabien Avenue', N'puag603@wjngytfi.dhlx-e.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (44, N'Maureen Chavez', N'2234229108', N'791 Oak Parkway', N'dalbi81@rtkz.ewctli.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (45, N'Bobby Kirby', N'2241183638', N'981 North Clarendon Boulevard', N'vnthhdga.yjxg@divghq.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (46, N'Patricia Jimenez', N'5202299612', N'728 Oak Street', N'ivrec.ugifvrbp@wwumqtzi.pbnlve.org                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (47, N'Miriam Russo', N'7571241779', N'354 First Blvd.', N'ymlb.rdcoashct@ktpgrb.net                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (48, N'Abel Stark', N'9965669363', N'49 Second Parkway', N'xafg.asrcdod@cimdzp.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (49, N'Jenny Pitts', N'7404075374', N'82 Second Avenue', N'iskkln.jtfadlwib@qaqg.mblyey.net                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (50, N'Dale Copeland', N'4947045560', N'51 East White Oak Parkway', N'boxnjco@vxxnrl.org                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (51, N'Jerrod Mendoza', N'7870633854', N'30 Rocky Old Boulevard', N'ypgmrmlx704@zpoj.yluqcw.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (52, N'Deborah Hanna', N'4075184351', N'992 White Clarendon Way', N'pnunavuq.fbyfeegujv@zbbedm.net                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (53, N'Johnnie Irwin', N'2588970944', N'672 Rocky Clarendon Avenue', N'ivbliw062@njhbtgqk.mpbror.com                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (54, N'Lakeisha Carson', N'8008016649', N'35 Green Old Parkway', N'rguf.amwixatt@slsvdj.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (55, N'Randy Valenzuela', N'3393156151', N'454 West Old St.', N'eziljqho.yzoztzgox@kpt-mz.org                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (56, N'Monique Villanueva', N'3690046122', N'36 Rocky Old St.', N'orha.ubpdgbjenv@tstopm.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (57, N'Aaron George', N'7251347510', N'51 Fabien Boulevard', N'tkokwq2@yyxzyq.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (58, N'Lawrence Bryant', N'5453810388', N'975 Nobel Freeway', N'xjgby23@busd.jmdgpv.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (59, N'Jane Barker', N'9300822603', N'873 Fabien Drive', N'yerb.vxewk@ipajjv.gnwevq.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (60, N'Vicky Lutz', N'5207983591', N'51 Green Cowley Boulevard', N'meabqj@kqibwx.org                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (61, N'Yolanda Fox', N'5554479094', N'53 North Green Cowley Avenue', N'tbxe.ahqlimfed@awjmeev.yzdaeq.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (62, N'Mickey Huang', N'4319543810', N'745 Second Freeway', N'vwnn70@slgff.yqwaym.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (63, N'Jim Gates', N'3612646894', N'235 Green Old Boulevard', N'cxzh.kujpjiqxd@ickmj-.net                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (64, N'Aisha Brooks', N'5196478920', N'353 East White New Freeway', N'rdoux.hqkkhmdd@crvx.ambyoj.org                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (65, N'Anne Vega', N'5113409016', N'83 White Hague Parkway', N'sxgoecw.qbaamtm@zcoghw.net                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (66, N'Derrick Tran', N'5587886836', N'90 North Nobel Street', N'bbrz@smayzblx.-uwvot.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (67, N'Gwendolyn Walsh', N'4214867514', N'168 Rocky Hague Road', N'jkavlok.auinhdxu@krfxqq.net                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (68, N'Ivan Ferrell', N'3014160623', N'97 White First Drive', N'byanhbr.ckhyqfp@pctrzb.nepcmi.org                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (69, N'Gary Soto', N'7428653810', N'31 New St.', N'hiujn83@jmhulq.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (70, N'Beth Mc Cormick', N'0033446324', N'670 Rocky First Street', N'book.suwa@tfnqhl.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (71, N'Oliver Underwood', N'1091895468', N'12 East Clarendon Blvd.', N'eiglbf.fkdmpjcf@ujuskv.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (72, N'Claude Cortez', N'1722603992', N'323 Fabien Way', N'bdzqma87@ithkolxjk.chyjqw.net                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (73, N'Franklin Williams', N'9568479090', N'792 Rocky First Blvd.', N'ylzmdn9@gokxqpbcj.zybdr-.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (74, N'Drew Fitzgerald', N'6897285811', N'33 North Second Blvd.', N'bjnqj.dvqu@mtge.skhupt.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (75, N'Oscar Kramer', N'4695080103', N'69 Oak Freeway', N'ynwimns.tpqe@mtkhgd.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (76, N'Joanne Crosby', N'4376383350', N'293 Rocky Second Avenue', N'wavhfkgu.cvjgndgje@qmqbju.org                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (77, N'Jeannette Briggs', N'1063267049', N'487 Green Clarendon Way', N'lbdliaiq46@jburff.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (78, N'Mathew Hutchinson', N'8858413947', N'87 Clarendon Freeway', N'xaxefmee.epieyj@emaxsybu.ogsnvw.com               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (79, N'Candy Mahoney', N'2689799291', N'73 South Second Road', N'doeuvmbr.jnfdlra@bahzd.ipwbai.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (80, N'Elijah Daniel', N'4046959126', N'74 North Fabien Street', N'avvw09@mrhy.vantbh.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (81, N'Carlos Bright', N'2226327900', N'445 Nobel Parkway', N'pbjm.pucqpeiqv@tcvjmk.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (82, N'Rhonda Hensley', N'4516672817', N'86 Fabien Blvd.', N'daanpr.zfub@tpbjar.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (83, N'Greg Lowe', N'8926610443', N'204 Rocky Nobel Street', N'fgyaheil2@ephmz.hik-mw.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (84, N'Dianna Watkins', N'1779026503', N'17 Green Milton Street', N'ficjlra.opjln@evukp-.net                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (85, N'Gail Bates', N'3036397743', N'73 Rocky Second Avenue', N'ctlu.lervccagu@ivtxp.uuhvra.org                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (86, N'Nikki Fritz', N'9105622676', N'76 Green First Street', N'fnfgs050@qllcyb.sfeazm.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (87, N'Alvin Sutton', N'2561869568', N'472 Rocky Cowley Way', N'amlud858@dlhgqm.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (88, N'Francisco Robles', N'2087353688', N'38 White Fabien Boulevard', N'jjfx.mnzmft@gnchge.nvgyzf.org                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (89, N'Audrey Giles', N'5187794015', N'90 Old Parkway', N'xkmo62@m-nxcp.org                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (90, N'Cedric Hester', N'4064034193', N'39 Oak Avenue', N'pfveig.vnxyrkepc@fdhpf.cudaqs.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (91, N'Spencer Espinoza', N'8357054704', N'765 Milton Road', N'jrbct70@jpncvyvbx.lgpope.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (92, N'Dana Washington', N'0400160040', N'73 Fabien Drive', N'feugg1@zllbulw.qrhcuq.net                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (93, N'Tammi Ferrell', N'7390165872', N'201 Clarendon Drive', N'xjlnc.ewhid@jslmblpl.dsqntg.org                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (94, N'Karen Williams', N'8187396634', N'588 First St.', N'dlpjjrz621@sqkipr.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (95, N'Ben Lozano', N'6548887641', N'52 White First Boulevard', N'ibmwhu08@ersvz-.com                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (96, N'Lonnie Colon', N'4562854528', N'34 Rocky Cowley Blvd.', N'yujgzba464@dnxmkf.vpikoy.org                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (97, N'Leroy Dickerson', N'8239039140', N'215 Second Parkway', N'pjof5@wftlep.org                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (98, N'Kristine Braun', N'6190492522', N'56 Clarendon Freeway', N'xqofxmq11@kbzbna.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (99, N'Carrie Conley', N'4930926812', N'84 West Green Fabien St.', N'zxpvrpel9@rhmsrwyyp.isklcu.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (100, N'Cara Glass', N'3738900682', N'15 White Old Drive', N'ocexs.gwlvfmev@umjwdd.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (101, N'Miranda Cannon', N'3050917590', N'922 Fabien Road', N'jfchdbq.kaxt@hk-lbj.org                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (102, N'Alexander Cox', N'6363523940', N'96 New Way', N'wrtihzuk.oitg@kegmtu.net                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (103, N'Luke Davenport', N'5279934411', N'63 West Cowley Road', N'fzbk1@-fpksi.net                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (104, N'Lana Montoya', N'0575310094', N'517 White Old Blvd.', N'aczfhtbm915@uucixkfgu.-s-ihr.net                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (105, N'Deborah Edwards', N'1235633204', N'35 Second Parkway', N'htswtyf.wqgx@duqpa-.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (106, N'Marc Black', N'2112227540', N'615 Oak Avenue', N'vfrga930@qixadb.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (107, N'Sandra Evans', N'8618181266', N'219 White New Way', N'jqnrhc.rbuimyw@rezuxf.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (108, N'Erin David', N'5491924818', N'31 Rocky Clarendon Boulevard', N'lzvxplyc26@yepi.gluslf.net                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (109, N'Lawrence Arias', N'6672434450', N'89 Rocky Hague Avenue', N'xyrlkj.daqb@edmr--.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (110, N'Susan Irwin', N'9934716394', N'13 North Clarendon Way', N'ueoxxrq66@crzugm.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (111, N'Shelley Ryan', N'6792257032', N'11 South Oak Parkway', N'ezgs627@tqem.llvfwq.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (112, N'Monique Gonzales', N'2535202531', N'41 Cowley St.', N'rtblnw.qlqfifl@aolq.kzeciu.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (113, N'Katina Oliver', N'8008640571', N'79 South Oak St.', N'ymzv1@ymlde.fofajf.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (114, N'Julio Gaines', N'5645828882', N'58 White Old Way', N'oumicgjn.undg@thuiqzfb.kynbtf.com                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (115, N'Pete Rivera', N'7686623535', N'23 Green Milton Street', N'kkaojbyi5@kabbhc.mloojb.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (116, N'Allan Blake', N'0298442167', N'96 Rocky Hague Road', N'vleqelt.qkgwafl@p-yl-l.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (117, N'Juan Cisneros', N'8279788647', N'868 Green Second Avenue', N'oxvlegkr@dfre.kxwpmg.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (118, N'Charity Pacheco', N'9160106342', N'97 First Avenue', N'qmqi65@vzam.vemfbu.com                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (119, N'Cory Pitts', N'8550445750', N'43 Hague Boulevard', N'jtwppgo7@uuhcor.com                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (120, N'Luz Guzman', N'0151462764', N'936 North Oak Street', N'ivfoytbk010@pmudgmve.lziawi.net                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (121, N'Marlene David', N'3164962578', N'647 White Oak Way', N'knbooi.febqr@rotrtoe.mqybzk.net                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (122, N'Grace Dyer', N'5118972418', N'57 Rocky Hague Parkway', N'qiqsna.ddhaitopam@crywfx.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (123, N'Yvette Bernard', N'0376145863', N'80 White Hague Way', N'pgrk4@szrvrnpgd.sciamt.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (124, N'Trenton Williamson', N'8359143758', N'979 First Way', N'yktmql.xlxusjg@mzqldh.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (125, N'Jimmie Sparks', N'1377692113', N'168 West Rocky Oak Street', N'pvugefrs82@fagpeij.jwutzt.net                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (126, N'Devin Acevedo', N'2555861881', N'812 North Old Road', N'ucdk0@ggbmx.gadtqe.com                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (127, N'Frances Cabrera', N'1345351067', N'57 Second Street', N'hsylxklf.gqud@pz-wxb.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (128, N'Rachael Russo', N'8219154036', N'19 Rocky First Drive', N'mmorvzft@bdcuh-.org                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (129, N'Randy Miranda', N'6570710378', N'444 New Road', N'fgodfveq2@vykwtky.njxgdf.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (130, N'Rachael Wang', N'7329846214', N'129 Hague Blvd.', N'fowu@klzv.noqrgg.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (131, N'Adrian Stout', N'5008822971', N'12 Nobel Way', N'yopkm.rwbps@cjjfwr.com                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (132, N'Megan Hines', N'5074830576', N'94 Milton Freeway', N'hlddzv8@cg-gjr.org                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (133, N'Randi Lynch', N'6151578898', N'89 First Drive', N'gnkjcu.gibkogl@gjsakifq.qsbbzo.com                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (134, N'Christie Barker', N'9091983007', N'60 Green Clarendon Parkway', N'fyxcaik@orxvt.chnjwe.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (135, N'Darcy Cherry', N'8986634191', N'166 First St.', N'odwjd72@icgahrk.jbwswi.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (136, N'Jay Wiggins', N'0994406942', N'574 Milton Blvd.', N'gcwj.jlfoz@hujxik.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (137, N'Tracy Jefferson', N'2143916728', N'48 Rocky Cowley Avenue', N'ifsl@jz-dlf.net                                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (138, N'Scot Gordon', N'4471898427', N'86 West Hague Way', N'qspsuu.pebhmv@zyxwdy.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (139, N'Chrystal Landry', N'8228045588', N'145 Hague Boulevard', N'stvp.lcdzgp@cnlzvy.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (140, N'Samantha Burgess', N'9347651509', N'195 Clarendon Avenue', N'golceni.sbqzazetx@dmpybr.net                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (141, N'Nathaniel Malone', N'7501279805', N'12 West Rocky Old Road', N'kfcsgj18@thtnnd.org                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (142, N'Gabriela Summers', N'4129011601', N'21 Milton Street', N'oifyfsft.amrykaq@qosayju.vtbjxj.net               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (143, N'Andre Morris', N'4128643276', N'894 Nobel Blvd.', N'czdn.thrvbgvxt@urnuhg.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (144, N'Mitchell Landry', N'9545164601', N'71 Cowley Avenue', N'mjzxcc@bmvvlul.bhnky-.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (145, N'Elton Ayala', N'1849324173', N'802 Milton Blvd.', N'dsebuso874@zhtorj.com                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (146, N'Bridgette Swanson', N'7988291851', N'159 East Rocky Oak Parkway', N'ftjy804@wyit-o.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (147, N'Leo Thomas', N'2860367778', N'69 East Green First Blvd.', N'ssqb@fqjiuwd.krvnhf.org                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (148, N'Alvin Arias', N'8042990724', N'371 First Boulevard', N'tsruqo.jmqgpsievx@arx-vw.org                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (149, N'Demetrius James', N'1365972025', N'28 Old Avenue', N'tvpmsfh576@yhfwws.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (150, N'Mason Meza', N'0085063388', N'65 East Green Old Avenue', N'slqqj@ufjgnw.org                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (151, N'Quentin Baker', N'3512454836', N'99 Nobel Parkway', N'klaage.ssquzzp@cewcwfomq.jmbkkb.org               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (152, N'Leroy Harvey', N'2148942281', N'743 East White First Way', N'hiqmgq3@zvqk.lshlnf.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (153, N'Johnny Parker', N'6207415536', N'435 Green Nobel St.', N'pgoaph6@rmqxfzev.oqctbx.net                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (154, N'Sherri Henry', N'0469343293', N'18 Rocky First St.', N'uvyaw@cbbyeiiis.vubmik.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (155, N'Christian Liu', N'3919889695', N'148 Rocky Clarendon Street', N'zcvx.nyvohult@wctlkh.net                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (156, N'Taryn Alexander', N'0844485911', N'944 Milton Avenue', N'kfdxri.wbxxge@lgmtb.gaxyqf.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (157, N'Alex Rodgers', N'3676817276', N'68 East Clarendon Road', N'orhknl2@ryiw-w.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (158, N'Angel Patton', N'0702408894', N'22 First Boulevard', N'abevb9@sriyimfpw.ynu-zs.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (159, N'Jesus Hinton', N'4586479592', N'822 East Milton Avenue', N'xfwc.qnkwgaz@pnvrsq.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (160, N'Diana Hayes', N'4612870787', N'77 West Fabien Road', N'kaaun839@wcqtuh.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (161, N'Shauna Carney', N'7882782907', N'76 East Nobel Avenue', N'jjvrlkfm630@ayscgf.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (162, N'Elizabeth Trujillo', N'6135534217', N'83 Milton Freeway', N'almg@jvuh.dhjcar.net                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (163, N'Marie Hancock', N'0711921700', N'967 North Nobel Street', N'ifzirou583@gydsp.dgmggk.net                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (164, N'Brandie Cohen', N'6845033826', N'253 White Clarendon Avenue', N'iafoh.fmyvih@gyxoia.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (165, N'Sophia Hancock', N'1420720152', N'417 White Fabien Avenue', N'icqd7@retfihbv.-lexfu.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (166, N'Leo Bradford', N'1169695616', N'884 New Boulevard', N'fijvnoxa.rnrmuwp@azypvt.org                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (167, N'Albert Berry', N'9805157408', N'16 West Second Road', N'zulwwuxn3@velwki.mrigor.org                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (168, N'Tara Farley', N'6357269777', N'53 Nobel St.', N'gsnchmyf7@zjcemm.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (169, N'Benjamin Cohen', N'4630224071', N'710 White Clarendon Street', N'ntllu.mdhemugr@wdxzyhpp.ngebae.org                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (170, N'Alonzo Frazier', N'2952267985', N'178 White Hague Freeway', N'tybqmyq.hpgzssyx@huolvv.org                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (171, N'Ashley Serrano', N'1190120581', N'45 West Rocky Cowley Road', N'bhbfakkn.rkehgqaajs@gdkvto.org                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (172, N'Terrance Singh', N'3096373648', N'57 Second Way', N'gujypm685@ugge.nylvmj.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (173, N'Lana Patton', N'6659192813', N'616 West White Oak Drive', N'zxueqw88@suiykneq.mxdqs-.org                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (174, N'Desiree Townsend', N'5598393289', N'358 Green New Drive', N'lhztcmkg687@fyhtpm.com                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (175, N'Esmeralda Rivers', N'6514578312', N'627 West Fabien Boulevard', N'fnyn.nxwdfl@lphyry.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (176, N'Leonardo Erickson', N'5663284303', N'90 White Second Parkway', N'vvpnys65@ufdykp.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (177, N'Joel Blair', N'8137205094', N'971 South Fabien Way', N'vrnlvfm.qumqsrc@svnpmr.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (178, N'Joni Howard', N'0089318551', N'12 Rocky Nobel Road', N'gfljocb1@ssfrvzsnr.na-zxb.net                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (179, N'Chester Huynh', N'0607936241', N'94 North Rocky First Road', N'evzozgh745@uuszpw.myyodr.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (180, N'Emma Mckay', N'4044843343', N'68 North New Way', N'oezikzm793@-bbz-g.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (181, N'Rolando Fox', N'4414958968', N'57 Green Hague Way', N'xmxmrwb@smnkgs.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (182, N'Tera Flynn', N'4178662669', N'682 White Oak Road', N'rogqlaq.mfrcc@mlyipcey.m-jlru.org                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (183, N'Cory Rojas', N'0672908876', N'67 Nobel St.', N'zosrwl925@upefyv.net                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (184, N'Cynthia Grant', N'5532932650', N'720 Green Fabien Road', N'sokhfza16@cnppqz.com                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (185, N'Lynette Nolan', N'0872484257', N'290 Nobel Avenue', N'rwqimsk794@ahjqmlvl.wrsrbo.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (186, N'Marcia Herring', N'6927093067', N'373 Rocky New Boulevard', N'whyaruy.paflslzwn@anbmgutq.-hppkc.org             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (187, N'Toni Rangel', N'0490069234', N'312 White New Avenue', N'hinkxfv.qegsvpgjh@mtwaiygh.pzofso.org             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (188, N'Chandra Jones', N'3805765327', N'92 Milton Drive', N'vcigr630@jgeuz.mlnbyy.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (189, N'Amy Maynard', N'9488863263', N'943 Hague Boulevard', N'pqpzzgk1@utsjxw.org                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (190, N'Crystal Maynard', N'8383608219', N'954 North Green Clarendon Drive', N'bjvuhy2@jshjn-.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (191, N'Ron Klein', N'5359763868', N'547 Old Parkway', N'yiwsavzz.debyy@vvsbergu.pfmiej.com                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (192, N'Cecilia Hardy', N'4786865034', N'910 New Road', N'cger.iyhz@clvzds.r-trqx.org                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (193, N'Marisol Norton', N'1954112333', N'409 East Green Second Boulevard', N'smkotrg.dpawkc@cfxdkn.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (194, N'Christine Riggs', N'2499654925', N'137 Clarendon St.', N'evuioo.splxl@vpdv.rigxw-.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (195, N'Mandy Valdez', N'5098504745', N'34 Hague St.', N'cbhzf8@cpwedv.zethbn.org                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (196, N'Gerard Miles', N'9547435952', N'16 White Old Street', N'qvwow0@rhmsk.bib-es.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (197, N'Wade Carpenter', N'9142573856', N'53 White Milton Freeway', N'lhwuujan.ogsgpbopu@nehvyfs.gmyhqb.com             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (198, N'Lakeisha Newton', N'6573541874', N'860 South Nobel Drive', N'tgsrdi108@lpx-sy.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (199, N'Mark Greene', N'4308161537', N'294 New Way', N'zvdibr.ybeznu@ujfzdrwky.uw-gyd.com                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (200, N'Rex Wood', N'2193609180', N'977 White Hague Freeway', N'ukoj3@-rtmrg.net                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (201, N'Melanie Arias', N'2372298970', N'20 Old Drive', N'jsdlhzt8@qczmnz.net                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (202, N'Byron Ellison', N'4644180716', N'67 Nobel Drive', N'kgopql.eycpfb@jnmkv-.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (203, N'Alexander Conrad', N'6085364548', N'552 Green Fabien Drive', N'mxoxs@gvbdnv.net                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (204, N'Nora Fields', N'7186510263', N'94 Nobel Way', N'aeqtikpn.zmnsjuucsw@xzjhyf.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (205, N'Leslie Banks', N'1748322046', N'23 Milton St.', N'vsrhuww593@zfuolikld.f-fqi-.com                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (206, N'Rachael Ali', N'2059003809', N'73 White Cowley Drive', N'bhhhvgy.tyex@u-dmjt.org                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (207, N'Ronda Thompson', N'6849568809', N'42 White Oak Parkway', N'kosa.frdaqj@rjnpyj.com                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (208, N'Sheila Sheppard', N'1537930044', N'60 West Second Way', N'ybsemq1@jxscfd.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (209, N'Nicolas Patrick', N'5088618372', N'509 Cowley St.', N'cvdge.iuzu@fxpqhp.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (210, N'Charlotte Vazquez', N'0735850015', N'948 South Old Road', N'mqyamm.ghlz@quunen.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (211, N'Marty Fry', N'3404092008', N'28 North Fabien Boulevard', N'nitcezc@coeefr.com                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (212, N'Katina Calhoun', N'7443374392', N'47 Hague Freeway', N'knsi.rgvvtkphcc@ihyvti.net                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (213, N'Joann Davies', N'9754845284', N'331 West White Second Avenue', N'ozlopwto.vzxa@grdefv.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (214, N'Harold Mac Donald', N'7158867629', N'501 South Clarendon Avenue', N'pyidboti5@gfxqaj.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (215, N'Jeannie Porter', N'7530023841', N'17 Oak Blvd.', N'qjivfoc9@iyqmpm.org                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (216, N'Ethan Nelson', N'6901053241', N'442 East White Milton Way', N'mmgnvyak1@uzpaivar.urtekh.com                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (217, N'Tania Mc Neil', N'2703626731', N'992 Rocky Nobel Freeway', N'aobdudc.hnrxduigoz@hriljro.pmsuxm.com             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (218, N'Ray Frye', N'5115061374', N'60 Old Road', N'dzwmfho@ylywi.wsxtql.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (219, N'Keri Patterson', N'5936988986', N'93 New Blvd.', N'akuvwz.ycpcohzcwm@qirpjgaut.lnkyex.net            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (220, N'Clayton Silva', N'7385970862', N'60 Green Clarendon Boulevard', N'cgbum.gzpsuxei@ssel.zvjiqa.net                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (221, N'Monica Nunez', N'0963620445', N'125 White Hague Blvd.', N'bcjfj.wvvi@kbzshfzb.eoemgf.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (222, N'Brent Salas', N'9316949792', N'360 North Green Cowley Boulevard', N'fgokoqks.mbwxwhj@kpivrn.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (223, N'Amelia Aguilar', N'7283822027', N'93 North New Avenue', N'uzwp.rqcpwwk@ltm-qh.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (224, N'Marcus Paul', N'0803880766', N'820 White Oak Parkway', N'dsmz.kwwat@zvvpeg.net                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (225, N'Damian Daniels', N'7608401018', N'33 Clarendon Boulevard', N'msiwp.enxocbsxel@rsawq.hmxrkl.org                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (226, N'Karla Vasquez', N'0963340999', N'679 West Green Second Freeway', N'frae@ribemq.org                                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (227, N'Clyde Garrett', N'3852551190', N'79 West Green Nobel Road', N'qdbm@syhk.mbkmev.org                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (228, N'Eva Tapia', N'6951891732', N'649 White Clarendon Street', N'aifv674@fzbgko.eddldq.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (229, N'Marlene Sawyer', N'7995632551', N'86 East Clarendon St.', N'fgrrhvfa.vrszv@nqeelway.pwtndo.org                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (230, N'Lydia Bass', N'6543700480', N'480 Old Road', N'vlbtdva.lpxcfjbf@jzsjqs.net                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (231, N'Kate Bradshaw', N'4492839053', N'626 Green First Street', N'ihbqgkme447@aklbikns.nowgba.com                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (232, N'Isabel Zamora', N'3232288985', N'35 Rocky Second Drive', N'gqrrjvim.zatffftszf@uuosbq.com                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (233, N'Clinton Morse', N'4962911586', N'36 Rocky Oak St.', N'cipledm.pcpsio@hjqmja.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (234, N'Bridgette Peck', N'3494625871', N'96 Nobel Way', N'qwwcqtr.yqkhbbtf@cbwlgwd.gxssfi.org               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (235, N'Jennifer Park', N'6131920013', N'92 Cowley Freeway', N'hpkawk.kyhigixh@dhtkq.mzk-rf.com                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (236, N'Clay Duncan', N'9139522700', N'959 Clarendon Parkway', N'entduzor0@unyzkj.eutxyd.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (237, N'Todd Schneider', N'2113413153', N'99 North Green Old Road', N'zrre.etotmjdmx@iqsmmagw.vitvep.com                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (238, N'Martha Cain', N'2974257229', N'922 Rocky New Drive', N'rsxxt7@xzltxopq.ukmqjg.net                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (239, N'Kenny Hancock', N'2147013097', N'161 White Fabien Blvd.', N'uytowxm.ikpgcsdui@blffob.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (240, N'Erick Manning', N'4095098868', N'573 East Cowley Way', N'ebmqzzv.rbczys@bhsskwbk.gism-u.org                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (241, N'Stacie Thompson', N'8340964469', N'756 East First Blvd.', N'qcvtpgg.chujeta@uyotfl.osmbcq.org                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (242, N'Belinda Lara', N'0395021643', N'253 Fabien Avenue', N'thpk04@ttpacp.net                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (243, N'Cheri Duncan', N'6583351578', N'383 Oak Avenue', N'mahrwx0@vilazp.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (244, N'Martha Phillips', N'1550907035', N'892 Oak Street', N'ppbunswm.npxjse@blszxl.r-nhrq.com                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (245, N'Lynn Reeves', N'5225930757', N'638 Green Clarendon Road', N'mcvkguz79@wmrg.kokkps.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (246, N'Wesley Rhodes', N'4763137934', N'24 New Freeway', N'vsheazd28@tbjggz.net                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (247, N'Elijah Bowman', N'6146066028', N'76 East White Clarendon St.', N'vnxbvf.amdux@sgrxir.com                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (248, N'Donald Schultz', N'9514511625', N'120 Green Fabien St.', N'umvqmae6@dkcdtg.com                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (249, N'Kenny Juarez', N'6593742704', N'951 Hague Avenue', N'tszbuwr.bpujic@ojvwdk.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (250, N'Jocelyn Stein', N'8083310099', N'415 South First Road', N'zbieodcg05@phdsqb.org                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (251, N'Theodore Peck', N'0398947140', N'407 White First Way', N'wioee.nohxzv@vaymoi.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (252, N'Joan Ibarra', N'9917301818', N'532 Oak Parkway', N'aftu.luzajf@jyepnx.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (253, N'Sherry Burch', N'9923322859', N'38 Old Way', N'uavyi.pmgbi@lbbubn.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (254, N'Perry Floyd', N'3038257920', N'742 Green Fabien Way', N'lpkg.hyvx@lsyojub.nbdqal.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (255, N'Ramona Buck', N'0774469161', N'67 Old Road', N'nsvgruog.ztioldccmt@limoli.sefldk.org             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (256, N'Phillip Levy', N'6839628803', N'671 Rocky Clarendon Blvd.', N'ztqdrzhu960@ztyygm.net                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (257, N'Guadalupe Buck', N'0423248559', N'75 White Oak Blvd.', N'jgvvxthe01@pmod.dnlrjd.org                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (258, N'Otis Padilla', N'5385904513', N'18 East Hague Avenue', N'sfmupeq@jaavvh.net                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (259, N'Gerard Cruz', N'9810600474', N'95 Rocky Clarendon Parkway', N'pddmjd.owokrr@zrolys.spktlc.net                   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (260, N'Andres Odonnell', N'3490751374', N'81 Hague Drive', N'jlurd.crqpb@lmsomwd.nlwokw.net                    ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (261, N'Jermaine Meyers', N'0854565480', N'346 North Cowley Drive', N'nmwfezx92@vjqdid.net                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (262, N'April Osborne', N'6727793130', N'13 Clarendon Blvd.', N'xqvnpxiu.wdhccfeem@enqowr.org                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (263, N'Walter Atkins', N'8065072795', N'261 First Street', N'kbsaipw5@gvujlp.glzdrh.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (264, N'Darrick Mullins', N'7472815673', N'204 Rocky Oak Way', N'ceysf1@czmgdlqka.itgbgy.net                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (265, N'Levi Scott', N'4202871254', N'407 White First Freeway', N'lxasy.wuvvj@rfipfa.org                            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (266, N'Naomi Bates', N'2910100375', N'774 Cowley Blvd.', N'ohhxjj.lhkts@kaqmgruor.ra-tqs.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (267, N'Richard Rivas', N'0069329438', N'88 Clarendon Blvd.', N'xjtkan@oyyzmc.net                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (268, N'Randolph Wyatt', N'4689994528', N'170 Nobel Freeway', N'pobwts.rhwcuorhvv@acch.j-tvsn.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (269, N'Erin Martin', N'6931683245', N'375 Old Parkway', N'bceka.uxwccvpagq@tzpnmu.iswgzt.net                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (270, N'Arturo Boyd', N'7171599857', N'91 Cowley Way', N'slmwugj291@zmenxd.net                             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (271, N'Gregory Shah', N'6238537764', N'660 Green Second Road', N'psqxfi.xidnwo@jjjumg.com                          ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (272, N'Gloria Frey', N'1419228979', N'661 Green Hague Blvd.', N'fosjb@fvufwa.org                                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (273, N'Darrick Rowe', N'6485123364', N'678 White Nobel Blvd.', N'mirbjyl.dmubzhf@rpoom.iapszm.com                  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (274, N'Marcy Greene', N'5908874288', N'590 Hague Road', N'joayvov.rqhjalhop@jkrywesii.sypcjm.net            ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (275, N'Jolene Ballard', N'4498616384', N'57 Green Milton Road', N'jlxaixy363@hjzywbb.wmhoyr.com                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (276, N'Randi Savage', N'4818673909', N'587 Oak Boulevard', N'qyhfguf706@rzniqgd.qxgrok.net                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (277, N'Marshall Carney', N'6487859757', N'679 Rocky Clarendon Avenue', N'yfnwr.zemeqwcbjo@ibqbk.dgjxne.net                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (278, N'Melvin Ramos', N'0329305307', N'454 Second Freeway', N'ivueg.xoee@powxdd.jrhdct.com                      ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (279, N'Lynn Ruiz', N'6547538170', N'74 White Hague Drive', N'rbqhia.hfhtwknmw@ptoakb.fqnpam.org                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (280, N'Marc Camacho', N'4192740695', N'966 North Rocky Second St.', N'gmnwtn57@sydvhu.org                               ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (281, N'Stephen Mitchell', N'1311978708', N'526 Old Parkway', N'rdbf786@unid-y.org                                ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (282, N'Randall Cantrell', N'6475514959', N'284 First Drive', N'bnlzhn.hmshghg@khqqtd.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (283, N'Teddy Dougherty', N'4329144798', N'74 North Rocky Milton Parkway', N'obvj.whfdkgets@kkzjxm.org                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (284, N'Dwight Dunlap', N'6020869090', N'63 Rocky Second Drive', N'aoqjxg@mveni.--dvoz.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (285, N'Christina Decker', N'8777228895', N'68 Green Hague Parkway', N'ccitq.oovtpg@w-kbae.net                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (286, N'Donnie Diaz', N'8398549193', N'118 Old Boulevard', N'ycdjwjl.xagvyqeoby@ttpcsgv.xqkjrk.com             ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (287, N'Rose Bowers', N'0281582704', N'891 Cowley Drive', N'duecxs.rmykgnzgk@jnhdcqte.pvdnzr.com              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (288, N'Frederick O''Neill', N'3416809325', N'48 Second Avenue', N'telbbkk49@dzqghz.qbldnk.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (289, N'Marco Cole', N'6834146136', N'254 West First Road', N'ilko5@cidwxu.utplvm.org                           ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (290, N'Renee Clayton', N'6621177479', N'616 Fabien Road', N'ropqs6@ywzjgx.com                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (291, N'Jeannie Rodriguez', N'2992285692', N'57 Milton Street', N'adywz.gjtvdzvd@ncwnip.net                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (292, N'Nicolas Cantrell', N'5528436832', N'981 First Freeway', N'izxfkms.metuowilxt@octhms.net                     ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (293, N'Dan Wagner', N'1571205737', N'27 Rocky Old Blvd.', N'frngo.lbyhc@izyb.goblvx.com                       ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (294, N'Warren Werner', N'7691212705', N'735 Green Oak St.', N'wdxxt.wvqmgxcwkz@jruuj.slecer.com                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (295, N'Justin Walter', N'2273749407', N'333 North Clarendon Boulevard', N'xxid1@milvcfsrm.efbbio.com                        ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (296, N'Toni Powers', N'8746594405', N'421 Green Second Way', N'mwtqzdiz2@mdqgkx.com                              ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (297, N'Myra Huffman', N'0492744339', N'91 North Second Road', N'gnlsi8@oomrig.net                                 ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (298, N'Nick Merritt', N'8907270993', N'76 Rocky Hague Road', N'imcadko0@xqvkf.gxqzrd.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (299, N'Austin Patel', N'4377349447', N'21 New St.', N'sjlvv06@gjbexm.j--xtb.com                         ')
GO
INSERT [dbo].[KHACHHANG] ([MaKhachHang], [HoTen], [SDT], [DiaChi], [Email]) VALUES (300, N'Thomas Curry', N'9932176586', N'23 First Drive', N'zysi.qorf@g-jv-r.net                              ')
GO
SET IDENTITY_INSERT [dbo].[KHACHHANG] OFF
GO
SET IDENTITY_INSERT [dbo].[TAIXE] ON 
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (1, 14188343, N'Lance Martinez', N'3583126314', N'550 South New Freeway', N'XX662               ', N'MO', N'mhspkdfs.lynpmhd@ivuuzfyvx.dowwrv.org             ', N'5154086308006479    ', 59493, N'NJ')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (2, 82937892, N'Brandie Savage', N'9668815653', N'371 First Freeway', N'LD854               ', N'GA', N'egcox.spzfoxb@yermti.com                          ', N'4777131842213478    ', 59710, N'LA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (3, 75420314, N'Douglas Lopez', N'3652684904', N'12 Nobel St.', N'GL020               ', N'NJ', N'hcszpbw.pzvxtxxh@ypiscw.yldpyu.net                ', N'4499694910313758    ', 154391, N'MD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (4, 47780568, N'Jeffrey Shannon', N'4318047210', N'763 Green Hague Way', N'LC925               ', N'MO', N'hudnd.meicweehug@mtykp.ucjotp.org                 ', N'4292131383120567    ', 70213, N'LA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (5, 93576514, N'Cody Gonzalez', N'1213870411', N'86 Clarendon Freeway', N'ZK089               ', N'CT', N'emcuudcv300@djjlbh.org                            ', N'370318942706035     ', 122507, N'WA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (6, 91686270, N'Kara Mckenzie', N'6192694557', N'65 White First Blvd.', N'MI050               ', N'MT', N'kokiktw9@rezlip.com                               ', N'342636076770096     ', 70625, N'AL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (7, 76094244, N'Lamont Rowland', N'4794665907', N'15 White Cowley Freeway', N'QL990               ', N'OH', N'vapce231@desfj.rafsrb.org                         ', N'5259106395256573    ', 55868, N'MO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (8, 96202818, N'Charity Cummings', N'2188808884', N'543 Second Blvd.', N'RD656               ', N'OK', N'bzkxc4@yhcanr.org                                 ', N'4870393792074500    ', 80843, N'OK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (9, 36072704, N'Claude Perez', N'8688237964', N'48 West Cowley Road', N'VN468               ', N'NH', N'vcwnmt9@bhlynh.org                                ', N'4282629559636847    ', 192502, N'AR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (10, 38149476, N'Janette Bell', N'8440728891', N'13 Rocky Cowley Road', N'SB754               ', N'MO', N'mbpc.ihcrqn@dgbunl.com                            ', N'342349530957776     ', 140556, N'WI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (11, 14827111, N'Tom Bradford', N'9185764494', N'11 Cowley Drive', N'CB605               ', N'TN', N'oobb435@wolf-b.net                                ', N'373063566293038     ', 56463, N'RI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (12, 97834957, N'Rebekah Sanchez', N'0078235444', N'40 Rocky Hague Street', N'QV250               ', N'ND', N'mzxgcuke@tepna-.net                               ', N'342289489014783     ', 51449, N'SC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (13, 74414235, N'Karl Davis', N'0979496691', N'521 South Fabien Blvd.', N'GU233               ', N'IL', N'gusbxes0@rhdwq.zg-xgn.net                         ', N'5163111020050891    ', 97784, N'AL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (14, 13528215, N'Raquel Winters', N'6987257521', N'20 First Freeway', N'VC812               ', N'AL', N'oqyy@yshvjx.hldubb.com                            ', N'370455112480494     ', 134865, N'CA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (15, 95043457, N'Damien Randall', N'7381577144', N'210 East Rocky Fabien Road', N'KD455               ', N'VT', N'uwtbkgjn960@wcgcj.ouybes.com                      ', N'342938311812117     ', 199071, N'OH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (16, 61198197, N'Allen Walsh', N'1040749964', N'66 South New Drive', N'BI406               ', N'UT', N'ssxdoebk.jofc@gzcsgs.net                          ', N'371205122061092     ', 161755, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (17, 37403597, N'Clint Dorsey', N'9918161796', N'532 Green Second Boulevard', N'SS171               ', N'UT', N'crfbvzfn.lnammzrl@sufmfmuf.rv-xxa.net             ', N'4670212097893731    ', 68372, N'NV')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (18, 72625745, N'Clay Camacho', N'1131491508', N'191 East Milton Road', N'GL111               ', N'MT', N'apyu.vqbkum@vnohhltvj.zzfnkp.org                  ', N'4474845073393420    ', 105267, N'WY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (19, 36887332, N'Neal Guerrero', N'6950886669', N'92 Second St.', N'ZF828               ', N'AZ', N'parwgm.kvebaskqa@ptmfegtu.jgekhh.net              ', N'370945004420624     ', 68235, N'DE')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (20, 27436085, N'Max Singh', N'2268257320', N'277 First Parkway', N'SW957               ', N'NM', N'kyhckdby.egopnyins@mqnra.bpstru.org               ', N'5339022666337121    ', 166615, N'FL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (21, 28328819, N'Rolando Arnold', N'6097992259', N'215 Green Oak Boulevard', N'MK264               ', N'HI', N'bfffqlh.onhu@cuqujx.org                           ', N'5447418360813244    ', 141058, N'OR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (22, 82124634, N'Randall Estrada', N'5649707591', N'570 West Oak Way', N'JO314               ', N'NH', N'kjjyi.mlijltc@rmzrydsyi.pza-wi.net                ', N'340585282860914     ', 95580, N'NV')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (23, 52795684, N'Hannah Leonard', N'3718158525', N'668 White Milton Blvd.', N'RS432               ', N'NM', N'vvgmzo094@amodxx.wgqjqy.com                       ', N'4695524830047347    ', 68638, N'IA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (24, 24628686, N'Laurie Bonilla', N'6458987112', N'104 Rocky First St.', N'CE879               ', N'MI', N'llmari82@fvatmy.net                               ', N'341291965330163     ', 121781, N'TN')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (25, 44636079, N'Sherman Montes', N'5129677601', N'630 Rocky First Road', N'WI232               ', N'UT', N'nmxzld.ewwafxq@lrdtzt.net                         ', N'340624936748256     ', 74075, N'IL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (26, 22503651, N'Isaac Cantu', N'9513406021', N'631 Rocky Fabien Road', N'BQ461               ', N'NH', N'mjafxxr@onoo.shyile.com                           ', N'4286577537994760    ', 126344, N'DE')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (27, 58055960, N'Yvette Rivera', N'4426953567', N'522 First Way', N'RB140               ', N'CA', N'khbhqvnt.ytnihy@lwsc.wbj-ru.com                   ', N'4280536756648503    ', 149770, N'NE')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (28, 12505719, N'Lillian Bender', N'2729972781', N'243 Cowley St.', N'DO141               ', N'GA', N'havu.kmymf@pvfj--.org                             ', N'5242999125575944    ', 57439, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (29, 53610773, N'Gilberto Middleton', N'9611368450', N'307 White Second Avenue', N'FE951               ', N'NY', N'tmmiie78@rrsrnr.org                               ', N'371775984472173     ', 118072, N'OR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (30, 65691379, N'Kelvin Becker', N'9725742515', N'276 Clarendon Freeway', N'FP723               ', N'SC', N'lnjmn21@ujinni.com                                ', N'5540619552597448    ', 81733, N'AL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (31, 70328517, N'Dena Peters', N'8005601855', N'96 North White Oak Blvd.', N'CI714               ', N'SC', N'rffeqhd@vjxlcg.-tgwxc.org                         ', N'5352062086198952    ', 183470, N'IL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (32, 47058024, N'Tamika Stokes', N'2434889257', N'188 South Fabien Road', N'DC389               ', N'KS', N'dbieejb52@fjuje.ugxyfh.com                        ', N'4784644021873848    ', 66477, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (33, 41539835, N'Ernest Atkins', N'2987847058', N'778 Oak Boulevard', N'TR914               ', N'MN', N'szuiczl979@ylxww.ujmmtn.com                       ', N'372635799589331     ', 149856, N'AR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (34, 20160943, N'Guillermo Rocha', N'5101294207', N'28 East Second Blvd.', N'LN101               ', N'UT', N'gcbw.jlrfejhbhw@jailaj.com                        ', N'4491229347238118    ', 190605, N'WI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (35, 89327871, N'Erika Casey', N'0152821987', N'23 Rocky Oak Boulevard', N'LK163               ', N'KY', N'oimgooqn.vxffknursn@cpxne.ouarkr.com              ', N'340252318250590     ', 106161, N'OR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (36, 55487851, N'Dora Sheppard', N'5619280552', N'60 West Milton Road', N'GL369               ', N'SD', N'ykqpsueg0@vrkrxz.ewiaji.net                       ', N'4889095798206007    ', 190145, N'WI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (37, 78499222, N'Kenny Underwood', N'0447461751', N'519 Old Drive', N'CS617               ', N'IA', N'zelnsjok835@emzqsc.com                            ', N'4895408390475031    ', 167365, N'NM')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (38, 52870771, N'Matt Robles', N'7813328487', N'93 New Street', N'YZ097               ', N'AL', N'nrrvbapf@wgmlhhhj.brfihd.com                      ', N'5138089087047459    ', 59358, N'PA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (39, 42295779, N'Mathew Wiggins', N'2435194803', N'425 Second Road', N'UO139               ', N'WY', N'rfzieyv5@wlmmosy.nilvgk.com                       ', N'343327048230323     ', 125594, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (40, 59498817, N'Sandra Mills', N'4960103188', N'178 West Green Milton Street', N'SJ156               ', N'ND', N'kmtw@bzshqk.net                                   ', N'4880340461168707    ', 105681, N'WA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (41, 24141447, N'Victor Durham', N'1513375550', N'547 Rocky Fabien Avenue', N'FS447               ', N'KS', N'xysrf.pgmwi@asmvqa.net                            ', N'4385317951064810    ', 143131, N'MD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (42, 33663762, N'Charles Huffman', N'1734733970', N'104 Green New Parkway', N'VX830               ', N'IA', N'ibtwko.jdoryi@uqqdpo.net                          ', N'4685466027162863    ', 69872, N'MA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (43, 80953219, N'Tammy Patrick', N'5903717905', N'23 Old Blvd.', N'KM654               ', N'KY', N'vyxzvuu.kqqxijgpqd@bes-sa.net                     ', N'5147832532294211    ', 57570, N'NY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (44, 98817739, N'Michele Randolph', N'2142818841', N'40 White Fabien Parkway', N'XU293               ', N'PA', N'pxtckbl.toivrorbwl@oymfpst.ycsuij.com             ', N'4897813097918068    ', 63694, N'HI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (45, 61365374, N'Craig Gonzales', N'3711174870', N'76 South White Hague Avenue', N'IL519               ', N'WI', N'nngx.xokykq@wpry.ygxuis.com                       ', N'370213963656146     ', 132295, N'AR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (46, 17450672, N'Alfredo Silva', N'4630106773', N'141 North Milton Parkway', N'HH502               ', N'TN', N'qvnlhcun489@uqid.-gccki.com                       ', N'5559283232256509    ', 121021, N'LA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (47, 55064329, N'Krystal Barajas', N'9129847736', N'900 New Road', N'RE091               ', N'IL', N'qsyec.swmdogknl@cxjceapib.sj-ynd.net              ', N'4292539534452954    ', 89842, N'NM')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (48, 68920638, N'Lonnie Nguyen', N'6049649507', N'33 Green New Way', N'XA020               ', N'WI', N'gfsku@owptswhg.gnnxpu.com                         ', N'370012991816312     ', 52544, N'AK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (49, 46782478, N'Lorenzo Underwood', N'9556825511', N'994 First Street', N'YI439               ', N'CO', N'zmle581@scdfava.lp-nsr.net                        ', N'343119572953127     ', 111448, N'MT')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (50, 99749476, N'Rex Lynch', N'0616475538', N'751 Cowley Drive', N'LY208               ', N'MI', N'jcjq.xflr@ucxnvx.nchnbo.com                       ', N'4469302943161535    ', 173780, N'WV')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (51, 53462437, N'Lesley Tucker', N'6275501596', N'40 North Oak Street', N'EN515               ', N'SC', N'hzysmced.llufy@ulqisl.net                         ', N'340162227108849     ', 69860, N'IL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (52, 78113650, N'Richard Walters', N'8966389608', N'58 South Old Freeway', N'PA020               ', N'NJ', N'djub.apwpfnznm@csjlui.org                         ', N'5549698104435019    ', 192153, N'MD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (53, 54363611, N'Damon Farmer', N'3902684955', N'723 West White New Street', N'LZ884               ', N'WI', N'fhdrrp837@eokwxpsgj.zajoth.com                    ', N'5543098336307233    ', 73661, N'VT')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (54, 29296264, N'Gilberto Underwood', N'4990825521', N'689 Second Freeway', N'ZJ624               ', N'UT', N'aqnjyxx730@fxyda.xtlhw-.org                       ', N'342813623534073     ', 122763, NULL)
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (55, 94237897, N'Marilyn Maxwell', N'3843620037', N'88 Rocky Second Street', N'GX831               ', N'PA', N'hatxn.tovpmy@zygaev.com                           ', N'341485001628743     ', 102309, N'OH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (56, 68151803, N'Elizabeth Hodges', N'1203492972', N'75 Cowley Road', N'MI050               ', N'WA', N'pitmh497@azko.blicnn.net                          ', N'5348233479390756    ', 163914, N'NV')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (57, 56966292, N'Abel Smith', N'9588498813', N'591 Old Parkway', N'IY191               ', N'NH', N'emjpyxv.dotmkpji@ruozns.net                       ', N'4381607012128727    ', 191073, N'AK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (58, 43967880, N'Joshua O''Neill', N'7838073173', N'43 South Milton Parkway', N'YT237               ', N'FL', N'jcmbuchc.xzwlb@vutrvz.net                         ', N'4786775256982421    ', 82609, N'AR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (59, 86696197, N'Adriana Rivas', N'8114364195', N'60 North White Nobel Avenue', N'EC900               ', N'NY', N'wzkp@ulsxau.com                                   ', N'4485882015612317    ', 196139, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (60, 75350064, N'Gina Armstrong', N'1132102431', N'833 East New Parkway', N'CK996               ', N'NV', N'hxolrvfs.ryblncrfyc@eyawa-.com                    ', N'371661188917710     ', 196164, N'CA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (61, 22231852, N'Bernard Cordova', N'0450188188', N'40 West Rocky First Freeway', N'RD230               ', N'MI', N'uadok.jeaurqj@bjxp.wwohus.com                     ', N'5545824011116336    ', 120856, N'SC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (62, 67312327, N'Carey Brandt', N'6957531702', N'28 Rocky First Road', N'LQ322               ', N'MT', N'vtfjhir.apriaxi@vucv.bslydo.org                   ', N'371610726965764     ', 198429, N'MO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (63, 14573592, N'Emma Herrera', N'3941577441', N'60 South White Old Parkway', N'DM935               ', N'AR', N'fvzjg.jbndoiiy@zfdywv.org                         ', N'5152633947239755    ', 162772, N'SD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (64, 70788856, N'Lora Bartlett', N'4480490946', N'273 West Green Milton Boulevard', N'FN409               ', N'SC', N'bdqvjmgg83@swmugy.org                             ', N'5542010007133492    ', 160769, N'WI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (65, 17600761, N'Nick Weeks', N'4363584565', N'487 Old Freeway', N'NG940               ', N'OK', N'uunceic.asiflrnr@hyyb.ehmgkb.com                  ', N'4871433223352528    ', 157086, N'AZ')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (66, 35419336, N'Jana Miller', N'0892855623', N'360 First Parkway', N'QO075               ', N'MT', N'trjwihi.sbvpilhfz@bzlvsxxw.uffljo.com             ', N'5145991641094136    ', 189986, N'OK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (67, 76788323, N'Darius Zavala', N'2468250678', N'787 South Rocky Old Avenue', N'MJ770               ', N'HI', N'uekszcfx882@aghugnd.jkcjlu.com                    ', N'4696536894231459    ', 101594, N'MA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (68, 26916449, N'Shari Carney', N'0355880738', N'993 South Fabien Road', N'YO515               ', N'MD', N'twekuso@mxbz.sufebt.org                           ', N'4671881672735894    ', 107179, N'OR')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (69, 33607668, N'Susan Knox', N'0170596176', N'736 Cowley Road', N'PP304               ', N'ND', N'ruagws.wtcabrrirf@ppmhln.net                      ', N'370202794222897     ', 78703, N'AZ')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (70, 62245485, N'Edgar Raymond', N'7821498875', N'73 White Old Drive', N'JI810               ', N'CA', N'oddzo.aried@qdzyn.cxnwvg.net                      ', N'5440287319900684    ', 58926, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (71, 64915906, N'Yesenia Beard', N'2612591671', N'42 White Clarendon St.', N'XR606               ', N'NH', N'gsuibcns.lmyqqjavpt@in-pnq.com                    ', N'371664283015448     ', 194390, N'OK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (72, 61388324, N'Angel Joseph', N'6862028065', N'69 Milton Drive', N'EP283               ', NULL, N'ehprtyn.jiymwnadmh@asfb.ighknw.org                ', N'373212301077145     ', 59013, N'PA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (73, 39935440, N'Rose Mendoza', N'1860619730', N'644 Rocky First Avenue', N'RH348               ', N'TX', N'xexgwrw2@wmaamakmk.oipwpg.com                     ', N'5141574590908623    ', 179674, N'SC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (74, 14924435, N'Erica Marshall', N'4122311823', N'813 Old Drive', N'ZE608               ', N'MT', N'ulwcz865@hmuaaw.gymlp-.net                        ', N'342910958308006     ', 162555, N'KS')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (75, 63632708, N'Derrick Navarro', N'8314853204', N'421 Green First Street', N'AE604               ', N'ME', N'oqabpr02@rxpkue.net                               ', N'5453704715307466    ', 73483, N'HI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (76, 73757169, N'Esther Norman', N'3693854526', N'967 Second Freeway', N'WZ096               ', N'IA', N'copw.gshzgcftnf@szfbtu.org                        ', N'5261952333625742    ', 121185, N'RI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (77, 11109746, N'Lawrence Acosta', N'5547223658', N'669 South Green First Parkway', N'AB213               ', N'VA', N'ojicrkg.zbdiokj@zrhykkuhm.q-uupj.com              ', N'5458020296360567    ', 88009, N'KY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (78, 38243781, N'Cory Barrera', N'7839752001', N'306 New St.', N'BZ614               ', N'ID', N'jfhv.goemedpw@vnaqzy.org                          ', N'4697711732096617    ', 54943, N'WA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (79, 82427376, N'Brandon Hall', N'7678990371', N'72 New Blvd.', N'NG986               ', N'UT', N'ynfmegn.maytdvyrvg@idubbybiv.kxxwhc.net           ', N'341078001682495     ', 189487, N'CA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (80, 84017779, N'Summer Dominguez', N'8698876472', N'595 New Boulevard', N'KT785               ', N'MS', N'xyfbcwa.scydry@jlldhl.gno-vg.com                  ', N'5246966135246507    ', 153054, N'PA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (81, 70046551, N'Julie Dominguez', N'3220512809', N'17 Rocky Old Boulevard', N'HM516               ', N'AK', N'ymik.ayabhjfw@ypgyrh.org                          ', N'4294038003474829    ', 86501, N'VA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (82, 12137079, N'Pete Clarke', N'9266753634', N'52 New Drive', N'CP944               ', N'KY', N'nptoh.kegaqiokh@kbackks.bfzodp.org                ', N'4680406838480331    ', 147225, NULL)
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (83, 98836049, N'Frederick Schneider', N'5190568216', N'87 White Nobel St.', N'FL990               ', N'CO', N'xhnmq@zwekid.net                                  ', N'371180339605645     ', 145992, N'NV')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (84, 53735211, N'Wendy Koch', N'0789783061', N'26 Cowley Way', N'TZ103               ', N'AR', N'exepk84@kpbjjp.net                                ', N'5248456901697297    ', 144292, N'MO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (85, 86770934, N'Jessica Riley', N'9895648492', N'94 Hague St.', N'IM278               ', N'GA', N'twwjdexl.ksbazzs@mbdqddako.luurae.net             ', N'5438997281537215    ', 61873, N'FL')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (86, 58565741, N'Ernesto Conner', N'4791552441', N'984 New St.', N'MH989               ', N'AL', N'obknuwh846@ilfbq.rfbtio.org                       ', N'340236398160597     ', 191318, N'RI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (87, 43192747, N'Yesenia Hines', N'1698699410', N'14 West Fabien Parkway', N'QO321               ', N'GA', N'oaaug.atyhhibyf@stmilz.com                        ', N'5241545685465249    ', 192816, N'RI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (88, 25396187, N'Shanna Weeks', N'4994423502', N'69 Milton Way', N'IO854               ', N'LA', N'qizqef.nevqjmo@guiyr.xtjvgf.org                   ', N'4898221760543644    ', 77092, N'UT')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (89, 84352771, N'Abigail Pittman', N'3679264146', N'79 South First Boulevard', N'NC133               ', N'NJ', N'beuzva@tnukio.edreeg.com                          ', N'4376379331007803    ', 138295, N'MO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (90, 87063228, N'Lori Bradshaw', N'9918155772', N'165 Old Drive', N'CZ751               ', N'CO', N'acwt33@lpmrgo.com                                 ', N'5354289703197947    ', 142248, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (91, 72619188, N'Elena Berg', N'2542622703', N'585 Second Way', N'DX109               ', N'MD', N'vednn@aniwxg.org                                  ', N'340748878601718     ', 199072, N'MA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (92, 88583373, N'Andy Murray', N'0570246932', N'68 Cowley Street', N'LE814               ', N'ID', N'yfar11@ysnxbt.com                                 ', N'370863313347760     ', 134756, N'OH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (93, 19808762, N'Deanna Thomas', N'3243334847', N'868 West Rocky Old Street', N'YO232               ', N'CT', N'ivmolx.gugxoimw@lauuyiw.xvndko.com                ', N'5252207071483643    ', 63219, N'VA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (94, 74810543, N'Brian Preston', N'7813584926', N'929 Rocky Cowley Avenue', N'ES566               ', N'MD', N'yejjuc.ekxshq@osimro.csv-yw.org                   ', N'341665859320499     ', 129430, N'AZ')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (95, 15103042, N'Kevin Fry', N'3789991303', N'36 Second Blvd.', N'OG694               ', N'MN', N'rndkhny.dfqoldhg@psgxti.org                       ', N'5434516450059134    ', 184826, N'NC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (96, 41523062, N'Morgan Villa', N'4335738881', N'159 Rocky Milton Blvd.', N'RY454               ', N'ID', N'rzcysba129@ezilyi.ontizm.com                      ', N'4369210681357333    ', 144703, N'VT')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (97, 99241925, N'Roman Howe', N'4065036577', N'94 Nobel Way', N'YP198               ', N'SD', NULL, N'343283207983006     ', 107101, N'MN')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (98, 71206195, N'Jose Graham', N'0979345900', N'74 Rocky Oak Avenue', N'KJ197               ', N'ID', N'qjbzih.fmonfycbq@ngnhkz.com                       ', N'370582252511109     ', 96802, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (99, 57301678, N'Rebecca Brooks', N'1934488375', N'66 North Cowley Boulevard', N'FB425               ', N'NV', N'kiptojvo.zvipsdyju@ksselc.org                     ', N'372637987450482     ', 106608, N'MI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (100, 31460510, N'Paula Whitaker', N'7779354811', N'914 Rocky Oak Blvd.', N'XF197               ', N'AK', N'aqzveeyq.ejkh@xryoji.org                          ', N'5556147995554439    ', 142309, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (101, 27275930, N'Vernon Hinton', N'9051165932', N'49 White First Road', N'QQ879               ', N'MN', N'ymzpvnc4@zzckun.org                               ', N'5562746337930454    ', 69427, N'MO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (102, 45242173, N'Carol Singleton', N'4902734215', N'27 White Milton Road', N'CO783               ', N'NY', N'qdfevch.psrouwsei@xxsymh.com                      ', N'342065786164269     ', 182663, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (103, 89697748, N'Terri Sharp', N'8815848230', N'807 Cowley St.', N'XA072               ', N'TX', N'ootw5@vutfhb.org                                  ', N'4298101975922203    ', 173842, N'NY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (104, 84702551, N'Blanca Cisneros', N'3251016692', N'891 North Rocky Fabien Street', N'XC292               ', N'IA', N'czfdl79@lgrnl.epuvnx.org                          ', N'4890908409600029    ', 102521, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (105, 97746283, N'Cedric Torres', N'2035842073', N'27 Green Clarendon Blvd.', N'KE909               ', N'AK', N'ljoazpup34@hhbcdw.com                             ', N'5452660112919785    ', 179390, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (106, 86670028, N'Trenton Kane', N'6206958445', N'49 East Old Avenue', N'TU187               ', N'TX', N'egiwcmhx.abzwxsaxyv@ezobintk.hrkegs.org           ', N'4669499260201379    ', 60846, N'SC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (107, 22280040, N'Tina Horn', N'4501128742', N'23 White Oak Avenue', N'NI416               ', N'WV', N'hiivhk.ljjdhyozw@hbeteehs.oqq-wj.com              ', N'370812351353057     ', 62478, N'GA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (108, 70709804, N'Stacey Allen', N'9230515757', N'963 East Green Old Freeway', N'EP257               ', N'AR', N'smwpvx.jgmjdliekv@oeqzrjout.fwg-gj.org            ', N'341398875339299     ', 111107, N'MN')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (109, 36168186, N'Jaime Costa', N'1491977519', N'240 Cowley Parkway', N'OT872               ', NULL, N'ldhqv.jgeim@ymznvx.net                            ', N'4374431520077899    ', 99280, N'CA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (110, 62492243, N'Terrell Ewing', N'7140565740', N'231 New Boulevard', N'JI743               ', N'NM', N'ickzap199@hvxird.org                              ', N'5352897682594389    ', 181124, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (111, 94543242, N'Chandra Mac Donald', N'9563005409', N'14 Fabien Road', N'GE943               ', N'NH', N'klgufxub.ivzuffv@gc-jny.net                       ', N'4390213182920198    ', 125905, N'VA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (112, 36030628, N'Elisabeth Villarreal', N'0631440171', N'18 South White Hague Road', N'TG759               ', N'TN', N'rbees.yqdfushb@pvknpsn.yazjas.net                 ', N'4383895280013832    ', 186129, N'HI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (113, 37478335, N'Ricky Anderson', N'9446868753', N'957 Rocky Milton Road', N'OV410               ', N'OH', N'hcaojq8@qcmybp.net                                ', N'4275995240142837    ', 93122, N'CO')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (114, 11941285, N'Karin Stephenson', N'2824582498', N'28 Fabien Way', N'AU153               ', N'OK', N'chcb4@iookig.com                                  ', N'5138915880305621    ', 93084, N'WI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (115, 74198395, N'Cherie Mc Dowell', N'4645049933', N'268 White Clarendon Parkway', N'AA728               ', N'OK', N'avazptr8@bwtaut.org                               ', N'372257388568020     ', 159662, N'SD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (116, 93073607, N'Krystal Day', N'5587218679', N'16 Green Hague Blvd.', N'LI143               ', N'NJ', N'arwzwshh2@tbuzym.com                              ', N'5365417172626255    ', 173631, N'GA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (117, 25535187, N'Leanne Lloyd', N'2213249486', N'346 Nobel Blvd.', N'NT125               ', N'HI', N'bsutik@pageiy.cwljzz.com                          ', N'340430387369232     ', 102436, N'ID')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (118, 26957245, N'Shawn Jefferson', N'7231269212', N'93 White Cowley Street', N'MZ239               ', N'KS', N'ijuzb.ttzzcfnhu@brvwot.zupa-a.net                 ', N'340417704568158     ', 68479, N'WY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (119, 41914129, N'Candy Mckinney', N'8619198591', N'130 Green Milton Avenue', N'KM992               ', N'MI', N'zzbrvks42@vpor.lyxylu.org                         ', N'340301272561102     ', 148896, N'NC')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (120, 27222131, N'Shonda Morrow', N'1804459688', N'720 Green Old Road', N'GC202               ', N'UT', N'cbrrsxhw2@cijokj.yde-ic.com                       ', N'4769069241702149    ', 165769, N'HI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (121, 30515159, N'Trina Nixon', N'8189579365', N'916 West Fabien Drive', N'NL764               ', N'RI', N'ianhq.rrpthbap@ogjqokbk.eywpho.org                ', N'370444595552888     ', 197171, N'IA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (122, 91900507, N'Jeffery Richardson', N'3420453988', N'41 Clarendon Parkway', N'AG283               ', N'NE', N'ofaymz.syqbjy@suwfct.com                          ', N'4498315133748247    ', 74501, N'TX')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (123, 49084164, N'Norma Olson', N'1285068816', N'59 Clarendon Blvd.', N'AJ997               ', N'FL', N'wzmjua954@jbhozwlli.fitxms.org                    ', N'4895502341725328    ', 168885, N'VA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (124, 18251986, N'Jack Glass', N'1155204772', N'580 Rocky Hague Freeway', N'VL400               ', N'NY', N'upncmmk.rlcvnf@toreyean.f--ctl.net                ', N'5447738239070035    ', 136455, N'LA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (125, 23956394, N'Vicki Ford', N'3463655507', N'199 Milton Way', N'RD126               ', N'IN', N'runhpvdc@lscsot.org                               ', N'373279853389772     ', 59854, N'NY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (126, 11608848, N'Angelica Gaines', N'4320365920', N'955 Second Parkway', N'NZ656               ', N'IN', N'ewknotf@zeqvkm.org                                ', N'370800969662092     ', 109634, N'ND')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (127, 76282540, N'Nick Reese', N'5397256037', N'99 Green Nobel Parkway', N'GX192               ', N'TX', N'tnctkahg.inah@ukas.ptfqwz.org                     ', N'4479915939399039    ', 195794, N'SD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (128, 80296598, N'Linda James', N'0085638219', N'27 Rocky Hague Street', N'SM140               ', N'MN', N'xseo.wcdamgn@n-wssq.org                           ', N'342491599776323     ', 100244, N'OK')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (129, 68780587, N'Brock Rogers', N'6125071793', N'97 Green New Avenue', N'AD632               ', N'MN', N'miicuwcn46@zkwqxrjom.yfrpzg.org                   ', N'4294593132993289    ', 177730, N'DE')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (130, 82616291, N'Janine Roberson', N'2688671444', N'58 Milton Way', N'CY665               ', N'AR', N'vrsfgibg49@jlamwbtjq.v-dnel.com                   ', N'4384494033964464    ', 128780, N'MI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (131, 36748959, N'Gina Thornton', N'1015902024', N'519 Fabien Freeway', N'KZ406               ', N'CT', N'zguml.norqxcmgxx@nlflma.jfdnao.net                ', N'342912025388441     ', 64084, N'PA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (132, 26565505, N'Robyn Mayo', N'3708050900', N'63 Rocky Old Street', N'NO189               ', N'MO', N'avgwz35@twjuh.yw-htv.org                          ', N'5252197771289053    ', 191207, N'HI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (133, 31467032, N'Janelle Sullivan', N'4138556179', N'99 First Avenue', N'RR752               ', N'OH', N'rjxjap@kqagiec.htgw-l.net                         ', N'4771331857539231    ', 148335, N'VT')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (134, 97423573, N'Kimberly Norton', N'2514496251', N'18 White Second Street', N'WE130               ', N'OH', N'csyj943@ylmqvl.net                                ', N'5554632021285878    ', 97177, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (135, 40341098, N'Curtis Dunn', N'9010511166', N'721 Clarendon Freeway', N'ZN267               ', N'TN', N'qqrovfa1@lmcmjz.org                               ', N'4284219797352965    ', 133627, N'NJ')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (136, 26169775, N'Marisa Ramirez', N'7478359764', N'69 Rocky Fabien Street', N'NA330               ', N'AL', N'ktoyltd@ldcghkd.cfmhgm.com                        ', N'4773380141810153    ', 103838, N'CA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (137, 56738805, N'Serena Walker', N'1669583286', N'204 Nobel Blvd.', N'OB524               ', NULL, NULL, N'4282304862553853    ', 173384, N'IN')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (138, 62965199, N'Christina Dyer', N'6985168622', N'201 North Rocky Second Boulevard', N'HC129               ', N'MA', N'ljzg.rzxbsdcc@lsjfif.net                          ', N'342089498649870     ', 93470, N'WY')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (139, 75113501, N'Danny Norman', N'1200025872', N'579 East Rocky Old Boulevard', N'UF764               ', N'MO', N'gwxzwkhl.rxwwp@cjfsaab.wwochp.org                 ', N'4895796788781030    ', 164902, N'TN')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (140, 11482220, N'Gretchen Barnett', N'9322899893', N'252 White Milton Street', N'BV126               ', N'TN', N'xaanrc@jkwupdjt.wqjfvv.com                        ', N'4369498021285179    ', 51026, N'ME')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (141, 72938668, N'Alma Bush', N'7781722359', N'38 White Old Way', N'RI110               ', N'AZ', N'nsjpdmkz.nvawklu@pagkto.com                       ', N'4694240468135418    ', 178840, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (142, 28350343, N'Carol Wagner', N'3383656905', N'360 East Green Cowley Parkway', N'DQ067               ', N'LA', N'wmufrdb.xrgylvtovy@fzld.xyggp-.net                ', N'342755693217685     ', 131709, N'KS')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (143, 95402301, N'Gregg Quinn', N'1015573011', N'329 West Hague Way', N'LQ387               ', N'AR', N'nmcjwryy1@dgnwx.biqnia.com                        ', N'372379024042374     ', 177813, N'RI')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (144, 51368099, N'Steven Mahoney', N'1965578608', N'822 New Road', N'UM769               ', N'CO', N'crviqmu.rfzgibxm@mustk.jruwys.org                 ', N'372348164841531     ', 157171, N'SD')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (145, 80389639, N'Amelia Bray', N'1165016837', N'918 West Milton Parkway', N'FM072               ', N'OR', N'lvgmemz.xwqxjuhtb@aljxlqg.-ajywp.net              ', N'5464076520251271    ', 66343, N'MS')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (146, 23966610, N'Kelvin Cordova', N'6599461806', N'772 Rocky Clarendon Boulevard', N'TM092               ', N'AL', N'ukhvto.xtuax@xrzjzk.com                           ', N'372359350591673     ', 62943, N'GA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (147, 95793919, N'Chad Braun', N'0204644656', N'69 North Hague Drive', N'PO078               ', N'IN', N'ofexenyu2@tfplxoa.wfxnyl.org                      ', N'373263789330597     ', 91633, N'NH')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (148, 36098618, N'Bobbie Baxter', N'8999055886', N'20 Rocky New Parkway', N'EV484               ', N'OK', N'fwbm5@ihzzll.com                                  ', N'371329119110926     ', 170136, N'WA')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (149, 71894671, N'Hugh Fisher', N'1486180639', N'36 Green Milton Freeway', N'WS517               ', N'NE', N'tdmkybxi9@gbswcrf.--qaun.org                      ', N'4294084707546660    ', 169769, N'ID')
GO
INSERT [dbo].[TAIXE] ([MaTaiXe], [CMND], [HoTen], [SDT], [DiaChi], [BienSoXe], [KhuVucHoatDong], [Email], [SoTaiKhoanNganHang], [PhiThueChan], [KhuVucDangKy]) VALUES (150, 94453202, N'Kerrie Blair', N'8445709263', N'73 Oak Road', N'DJ840               ', N'MI', N'rkthmeit.uedzbpgh@hckukatd.hdnrgr.org             ', N'4769099277454406    ', 61194, N'MS')
GO
SET IDENTITY_INSERT [dbo].[TAIXE] OFF
GO
SET IDENTITY_INSERT [dbo].[DONHANG] ON 
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (1, 25, 60, 218, 748845, N'TIENMAT   ', N'741 South Rocky Old Avenue', 19492, N'CHUAGIAO  ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (2, 223, 80, 246, 348061, N'TIENMAT   ', N'589 Hague Boulevard', 38557, N'DAGIAO    ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (3, 280, 128, 231, NULL, N'TIENMAT   ', N'22 Hague St.', 38630, N'DAGIAO    ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (4, 270, 72, 168, NULL, N'THE       ', N'17 Rocky Cowley Freeway', 22580, N'CHUAGIAO  ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (5, 45, 120, 62, NULL, N'THE       ', N'59 First Blvd.', 36081, N'DAGIAO    ', N'NV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (6, 270, 72, 168, 1143435, N'TIENMAT   ', N'985 Green First Freeway', 16463, N'DAGIAO    ', N'VA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (7, 244, 5, 272, 125568, N'TIENMAT   ', N'29 Rocky Milton Road', 21306, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (8, 138, 144, 133, NULL, N'THE       ', N'81 White Milton Avenue', 44132, N'DAGIAO    ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (9, 299, 44, 294, 3248927, N'TIENMAT   ', N'45 Oak Road', 33487, N'CHUAGIAO  ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (10, 233, 66, 83, 6004778, N'THE       ', N'27 Oak Road', 20378, N'CHUAGIAO  ', N'WY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (11, 143, 9, 88, 891678, N'THE       ', N'60 West Second Parkway', 13890, N'CHUAGIAO  ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (12, 17, 29, 141, NULL, N'TIENMAT   ', N'991 Green Fabien Freeway', 39548, N'CHUAGIAO  ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (13, 118, 81, 190, NULL, N'THE       ', N'349 First Way', 19774, N'CHUAGIAO  ', N'NM')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (14, 17, 29, 141, NULL, N'TIENMAT   ', N'622 North White Fabien Street', 13075, N'CHUAGIAO  ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (15, 72, 83, 295, NULL, N'THE       ', N'561 West Green Oak Avenue', 48669, N'CHUAGIAO  ', N'ME')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (16, 170, 82, 10, NULL, N'TIENMAT   ', N'586 East Fabien St.', 27584, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (17, 292, 92, 259, NULL, N'THE       ', N'351 New Blvd.', 33825, N'DAGIAO    ', N'MI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (18, 289, 50, 299, 454306, N'THE       ', N'29 Hague Parkway', 44104, N'DAGIAO    ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (19, 38, 18, 204, 1556953, N'THE       ', N'787 Nobel Road', 39879, N'CHUAGIAO  ', N'SD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (20, 149, 19, 95, 4946264, N'TIENMAT   ', N'31 Nobel Boulevard', 10648, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (21, 223, 80, 246, 475049, N'THE       ', N'998 New Way', 49390, N'DAGIAO    ', N'IL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (22, 182, 85, 255, 168426, N'THE       ', N'85 West Hague Street', 28581, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (23, 16, 97, 298, NULL, N'TIENMAT   ', N'573 New Boulevard', 26778, N'CHUAGIAO  ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (24, 170, 82, 10, 294949, N'THE       ', N'220 West Second Parkway', 25951, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (25, 116, 115, 210, 1839204, N'THE       ', N'289 New St.', 42696, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (26, 7, 27, 158, 449547, N'TIENMAT   ', N'99 White Nobel Boulevard', 30247, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (27, 21, 143, 281, 373083, N'THE       ', N'136 South Green Oak Road', 31987, N'DAGIAO    ', N'IN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (28, 96, 76, 207, 642236, N'THE       ', N'110 First Parkway', 47564, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (29, 272, 45, 165, 276280, N'TIENMAT   ', N'137 Hague Street', 43950, N'DAGIAO    ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (30, 145, 46, 25, 1248690, N'THE       ', N'793 Oak Drive', 28860, N'DAGIAO    ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (31, 211, 68, 57, 2766092, N'TIENMAT   ', N'147 North Rocky Fabien Road', 46936, N'DAGIAO    ', N'ND')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (32, 80, 23, 136, 789742, N'THE       ', N'847 Hague Road', 18460, N'DAGIAO    ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (33, 107, 148, 90, 1188247, N'TIENMAT   ', N'54 East White Oak Parkway', 18472, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (34, 94, 97, 297, 334178, N'THE       ', N'309 South Milton Drive', 44133, N'CHUAGIAO  ', N'VA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (35, 28, 108, 193, NULL, N'THE       ', N'180 East New Parkway', 22903, N'CHUAGIAO  ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (36, 101, 37, 229, 1174090, N'TIENMAT   ', N'72 North First Road', 33154, N'CHUAGIAO  ', N'ND')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (37, 170, 82, 10, 888172, N'TIENMAT   ', N'30 Hague St.', 39904, N'CHUAGIAO  ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (38, 263, 39, 115, 704064, N'TIENMAT   ', N'35 Cowley Way', 32826, N'DAGIAO    ', N'WA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (39, 226, 78, 103, NULL, N'THE       ', N'39 Fabien Boulevard', 49589, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (40, 248, 134, 288, 5502022, N'THE       ', N'569 Milton Boulevard', 36140, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (41, 181, 137, 152, NULL, N'THE       ', N'62 Clarendon Blvd.', 24464, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (42, 142, 139, 215, 1475423, N'TIENMAT   ', N'534 Old St.', 35087, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (43, 247, 61, 36, NULL, N'TIENMAT   ', N'265 Rocky Milton St.', 35475, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (44, 233, 66, 83, NULL, N'TIENMAT   ', N'23 Rocky Clarendon Drive', 33414, N'CHUAGIAO  ', N'SD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (45, 245, 55, 273, 5450604, N'TIENMAT   ', N'243 Hague Way', 16252, N'CHUAGIAO  ', N'HI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (46, 4, 79, 239, 1029952, N'TIENMAT   ', N'134 South Hague St.', 12417, N'CHUAGIAO  ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (47, 152, 10, 102, 492908, N'THE       ', N'358 South Oak Parkway', 20612, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (48, 18, 38, 138, 1890505, N'THE       ', N'564 Green Old Parkway', 39375, N'CHUAGIAO  ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (49, 48, 41, 45, 2409633, N'THE       ', N'850 Rocky Milton Drive', 49365, N'DAGIAO    ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (50, 110, 21, 67, NULL, N'TIENMAT   ', N'961 North New Parkway', 30490, N'CHUAGIAO  ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (51, 162, 102, 124, NULL, N'THE       ', N'902 First Parkway', 13760, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (52, 55, 139, 216, 2371523, N'TIENMAT   ', N'17 South Clarendon Freeway', 47708, N'DAGIAO    ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (53, 37, 129, 186, NULL, N'TIENMAT   ', N'95 Clarendon Street', 30239, N'DAGIAO    ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (54, 199, 47, 147, 690729, N'THE       ', N'79 Cowley Avenue', 25179, N'CHUAGIAO  ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (55, 26, 118, 59, NULL, N'TIENMAT   ', N'24 First Avenue', 39489, N'CHUAGIAO  ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (56, 63, 103, 264, 226008, N'TIENMAT   ', N'75 North Green Second Blvd.', 40912, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (57, 29, 89, 248, 918418, N'TIENMAT   ', N'84 White Milton St.', 21778, N'DAGIAO    ', N'NV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (58, 58, 7, 221, 2311707, N'THE       ', N'711 Second Avenue', 22679, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (59, 111, 90, 258, 3138855, N'TIENMAT   ', N'63 White Milton St.', 29885, N'CHUAGIAO  ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (60, 38, 18, 204, NULL, N'THE       ', N'23 West White Hague Blvd.', 15834, N'CHUAGIAO  ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (61, 252, 48, 188, 2891197, N'THE       ', N'35 South White Old Road', 34477, N'CHUAGIAO  ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (62, 221, 20, 66, 2236668, N'THE       ', N'92 White Second Avenue', 23743, N'DAGIAO    ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (63, 59, 116, 269, NULL, N'THE       ', N'37 Oak Blvd.', 10181, N'DAGIAO    ', N'MN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (64, 59, 116, 269, NULL, N'TIENMAT   ', N'212 North Oak Avenue', 14626, N'DAGIAO    ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (65, 144, 46, 26, 918226, N'TIENMAT   ', N'40 North Old Drive', 23442, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (66, 259, 106, 252, 2582230, N'THE       ', N'66 Clarendon Street', 45430, N'DAGIAO    ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (67, 97, 117, 52, 1711105, N'THE       ', N'31 Old Freeway', 31075, N'CHUAGIAO  ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (68, 242, 108, 194, 1526428, N'TIENMAT   ', N'458 White First St.', 25642, N'DAGIAO    ', N'OK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (69, 190, 104, 249, NULL, N'TIENMAT   ', N'911 First Blvd.', 40172, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (70, 221, 20, 66, 135867, N'TIENMAT   ', N'27 Green Old Way', 25515, N'DAGIAO    ', N'OK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (71, 22, 50, 300, NULL, N'TIENMAT   ', N'540 Green Hague Road', 37680, N'DAGIAO    ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (72, 121, 53, 145, NULL, N'THE       ', N'74 Second Street', 10999, N'CHUAGIAO  ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (73, 76, 64, 196, 3512735, N'THE       ', N'764 Hague Drive', 44515, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (74, 55, 139, 216, 1509816, N'TIENMAT   ', N'12 South New Avenue', 13739, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (75, 195, 2, 243, 117418, N'TIENMAT   ', N'36 Second Drive', 36185, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (76, 117, 93, 31, 1489597, N'THE       ', N'267 New Way', 24302, N'DAGIAO    ', N'AR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (77, 31, 3, 219, 1038987, N'TIENMAT   ', N'99 North Old St.', 43107, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (78, 55, 139, 216, NULL, N'THE       ', N'61 Hague Drive', 43365, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (79, 27, 107, 38, 1016652, N'THE       ', N'986 Green Milton Road', 19698, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (80, 244, 5, 272, 809740, N'TIENMAT   ', N'26 North Cowley Avenue', 40279, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (81, 211, 68, 57, NULL, N'THE       ', N'97 Green Second Boulevard', 19635, N'CHUAGIAO  ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (82, 179, 84, 144, NULL, N'TIENMAT   ', N'77 Green Nobel Road', 42612, N'CHUAGIAO  ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (83, 51, 16, 163, 1029319, N'THE       ', N'85 Rocky Clarendon St.', 48199, N'DAGIAO    ', N'WY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (84, 284, 17, 98, 147260, N'TIENMAT   ', N'306 North Old Boulevard', 23460, N'DAGIAO    ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (85, 158, 91, 202, 3730060, N'THE       ', N'396 White Old Freeway', 25100, N'DAGIAO    ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (86, 17, 29, 141, NULL, N'TIENMAT   ', N'820 West Old Boulevard', 49229, N'CHUAGIAO  ', N'SD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (87, 240, 106, 251, 1116600, N'THE       ', N'192 East Green Cowley Street', 38222, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (88, 195, 2, 243, 525138, N'TIENMAT   ', N'90 Rocky Hague Blvd.', 43293, N'DAGIAO    ', N'ID')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (89, 4, 79, 239, 437229, N'TIENMAT   ', N'90 Fabien Road', 14643, N'CHUAGIAO  ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (90, 98, 37, 230, 264188, N'TIENMAT   ', N'718 White Nobel Freeway', 31992, N'CHUAGIAO  ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (91, 229, 143, 282, 109093, N'TIENMAT   ', N'274 Green First Parkway', 21375, N'DAGIAO    ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (92, 216, 148, 89, NULL, N'TIENMAT   ', N'811 White Cowley Way', 27225, N'CHUAGIAO  ', N'MD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (93, 131, 27, 157, NULL, N'THE       ', N'454 East Rocky Fabien Boulevard', 12941, N'CHUAGIAO  ', N'HI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (94, 157, 149, 200, 144777, N'TIENMAT   ', N'658 South Rocky Oak Road', 43755, N'DAGIAO    ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (95, 225, 113, 100, 4460030, N'THE       ', N'22 Old Freeway', 11662, N'CHUAGIAO  ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (96, 104, 9, 87, 722528, N'TIENMAT   ', N'940 Milton Drive', 10720, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (97, 136, 89, 247, NULL, N'THE       ', N'45 White Milton Parkway', 34905, N'CHUAGIAO  ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (98, 110, 21, 67, 2449424, N'TIENMAT   ', N'68 Nobel Drive', 30848, N'CHUAGIAO  ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (99, 211, 68, 57, NULL, N'TIENMAT   ', N'638 Green First Avenue', 19971, N'DAGIAO    ', N'MS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (100, 109, 74, 21, 1216075, N'TIENMAT   ', N'75 Rocky Nobel Freeway', 20823, N'DAGIAO    ', N'ME')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (101, 252, 48, 188, NULL, N'THE       ', N'386 Hague St.', 31342, N'DAGIAO    ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (102, 206, 76, 208, 494596, N'THE       ', N'80 Nobel Avenue', 44971, N'CHUAGIAO  ', N'ID')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (103, 118, 81, 190, 2907796, N'TIENMAT   ', N'30 South Nobel Parkway', 49204, N'CHUAGIAO  ', N'ND')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (104, 231, 15, 279, NULL, N'THE       ', N'47 South Green Old Road', 33850, N'DAGIAO    ', N'MS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (105, 110, 21, 67, NULL, N'TIENMAT   ', N'82 Cowley Drive', 42810, N'DAGIAO    ', N'MO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (106, 231, 15, 279, 632801, N'TIENMAT   ', N'118 Green Cowley Boulevard', 12761, N'DAGIAO    ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (107, 88, 11, 20, NULL, N'TIENMAT   ', N'44 Rocky Oak Parkway', 13193, N'DAGIAO    ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (108, 180, 5, 271, NULL, N'THE       ', N'405 Rocky First Freeway', 26499, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (109, 38, 18, 204, 3039437, N'THE       ', N'688 Old Way', 38995, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (110, 79, 124, 29, NULL, N'THE       ', N'75 West Second Avenue', 25187, N'CHUAGIAO  ', N'AR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (111, 48, 41, 45, 345211, N'THE       ', N'39 Rocky First Road', 47805, N'CHUAGIAO  ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (112, 175, 34, 33, NULL, N'TIENMAT   ', N'753 Oak Avenue', 28414, N'CHUAGIAO  ', N'NJ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (113, 82, 56, 183, NULL, N'TIENMAT   ', N'83 Nobel Street', 12981, N'CHUAGIAO  ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (114, 8, 8, 286, 751295, N'THE       ', N'364 Old Drive', 39607, N'CHUAGIAO  ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (115, 68, 47, 148, 258842, N'THE       ', N'27 Cowley Drive', 46199, N'DAGIAO    ', N'VA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (116, 48, 41, 45, NULL, N'TIENMAT   ', N'811 West Clarendon Freeway', 41866, N'CHUAGIAO  ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (117, 38, 18, 204, 2248264, N'THE       ', N'93 Hague Parkway', 25544, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (118, 154, 110, 171, NULL, N'THE       ', N'492 Rocky Cowley Boulevard', 36722, N'CHUAGIAO  ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (119, 95, 21, 68, NULL, N'TIENMAT   ', N'25 Cowley Boulevard', 39527, N'DAGIAO    ', N'WY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (120, 37, 129, 186, NULL, N'TIENMAT   ', N'73 East Second Avenue', 24214, N'DAGIAO    ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (121, 32, 77, 2, 191496, N'TIENMAT   ', N'495 Green Fabien Freeway', 17208, N'DAGIAO    ', N'AZ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (122, 122, 96, 109, NULL, N'TIENMAT   ', N'61 Rocky Nobel Parkway', 37783, N'CHUAGIAO  ', N'AZ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (123, 198, 85, 256, NULL, N'THE       ', N'792 South Green Clarendon St.', 20998, N'DAGIAO    ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (124, 235, 11, 19, 2385271, N'TIENMAT   ', N'970 Clarendon Parkway', 18179, N'DAGIAO    ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (125, 147, 112, 85, NULL, N'THE       ', N'615 Fabien Road', 14139, N'CHUAGIAO  ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (126, 238, 13, 212, NULL, N'THE       ', N'57 Hague Road', 20455, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (127, 248, 134, 288, 482758, N'THE       ', N'386 Second St.', 48058, N'DAGIAO    ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (128, 94, 97, 297, NULL, N'THE       ', N'36 Old Blvd.', 10759, N'DAGIAO    ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (129, 256, 87, 117, 3664396, N'TIENMAT   ', N'51 Second Avenue', 12076, N'CHUAGIAO  ', N'UT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (130, 131, 27, 157, NULL, N'TIENMAT   ', N'52 Green Clarendon Road', 35465, N'DAGIAO    ', N'WY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (131, 147, 112, 85, NULL, N'TIENMAT   ', N'57 Rocky Old St.', 39397, N'CHUAGIAO  ', N'LA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (132, 181, 137, 152, NULL, N'TIENMAT   ', N'58 White Milton Drive', 22258, N'CHUAGIAO  ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (133, 105, 86, 160, 303569, N'THE       ', N'862 Oak Avenue', 33393, N'CHUAGIAO  ', N'MS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (134, 155, 63, 18, NULL, N'TIENMAT   ', N'100 Rocky Milton Drive', 48876, N'CHUAGIAO  ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (135, 147, 112, 85, 1274779, N'THE       ', N'96 Milton Way', 18936, N'CHUAGIAO  ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (136, 140, 36, 149, 3742505, N'TIENMAT   ', N'656 Rocky Nobel Drive', 24665, N'CHUAGIAO  ', N'NM')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (137, 64, 59, 254, NULL, N'THE       ', N'74 Second Parkway', 43409, N'CHUAGIAO  ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (138, 278, 56, 184, 734185, N'TIENMAT   ', N'502 Cowley St.', 24349, N'DAGIAO    ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (139, 41, 93, 32, 1506810, N'THE       ', N'990 White Cowley St.', 30650, N'DAGIAO    ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (140, 166, 127, 223, 423598, N'THE       ', N'19 First Blvd.', 22338, N'CHUAGIAO  ', N'WA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (141, 52, 25, 121, 4661716, N'TIENMAT   ', N'49 Cowley St.', 46036, N'CHUAGIAO  ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (142, 21, 143, 281, NULL, N'THE       ', N'743 West Cowley Parkway', 21723, N'CHUAGIAO  ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (143, 134, 26, 40, 901642, N'THE       ', N'342 North First Avenue', 14298, N'CHUAGIAO  ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (144, 116, 115, 210, 2085892, N'THE       ', N'152 Old Parkway', 39457, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (145, 85, 129, 185, 4051691, N'THE       ', N'897 Oak Street', 34187, N'DAGIAO    ', N'NV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (146, 54, 104, 250, NULL, N'TIENMAT   ', N'770 Nobel Blvd.', 42962, N'CHUAGIAO  ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (147, 215, 141, 206, 793152, N'TIENMAT   ', N'64 South Cowley Road', 24244, N'DAGIAO    ', N'IL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (148, 154, 110, 171, 1565479, N'THE       ', N'28 Oak Avenue', 23335, N'DAGIAO    ', N'ND')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (149, 97, 117, 52, 1130095, N'TIENMAT   ', N'70 Hague Road', 47557, N'CHUAGIAO  ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (150, 153, 132, 56, NULL, N'TIENMAT   ', N'821 Oak Freeway', 19797, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (151, 82, 56, 183, NULL, N'TIENMAT   ', N'554 South Fabien Blvd.', 35176, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (152, 213, 100, 76, 872869, N'TIENMAT   ', N'774 North Clarendon Drive', 48184, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (153, 22, 50, 300, 1648707, N'THE       ', N'580 North Milton Street', 41322, N'DAGIAO    ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (154, 154, 110, 171, 1072958, N'THE       ', N'85 South White Nobel Blvd.', 45758, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (155, 88, 11, 20, 1345660, N'THE       ', N'11 Green Cowley Avenue', 13615, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (156, 214, 69, 80, 183624, N'TIENMAT   ', N'16 East Nobel St.', 43560, N'DAGIAO    ', N'MO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (157, 183, 59, 253, 2866416, N'THE       ', N'83 Clarendon Way', 33972, N'DAGIAO    ', N'IN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (158, 154, 110, 171, 2293050, N'TIENMAT   ', N'22 Hague Freeway', 41024, N'CHUAGIAO  ', N'IN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (159, 242, 108, 194, NULL, N'TIENMAT   ', N'79 New St.', 29711, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (160, 11, 99, 155, 232678, N'THE       ', N'35 Green Hague Drive', 32354, N'CHUAGIAO  ', N'NJ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (161, 275, 12, 292, NULL, N'THE       ', N'74 Old Way', 14703, N'DAGIAO    ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (162, 274, 95, 24, 3622186, N'TIENMAT   ', N'27 Rocky Old Boulevard', 12433, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (163, 77, 57, 154, 4226102, N'THE       ', N'994 Oak Freeway', 24422, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (164, 173, 24, 47, 982913, N'TIENMAT   ', N'722 East Old Road', 13529, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (165, 112, 80, 245, 130430, N'THE       ', N'15 Old Freeway', 35790, N'DAGIAO    ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (166, 28, 108, 193, 6260437, N'TIENMAT   ', N'366 White Hague Avenue', 35547, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (167, 176, 138, 173, NULL, N'THE       ', N'493 Green Fabien Freeway', 45021, N'DAGIAO    ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (168, 250, 45, 166, 4248290, N'THE       ', N'647 Clarendon Drive', 14105, N'CHUAGIAO  ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (169, 158, 91, 202, NULL, N'TIENMAT   ', N'536 First Avenue', 30670, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (170, 289, 50, 299, NULL, N'THE       ', N'128 East Old Road', 31534, N'DAGIAO    ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (171, 130, 109, 91, 6926101, N'THE       ', N'59 Fabien St.', 48457, N'DAGIAO    ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (172, 88, 11, 20, 656107, N'THE       ', N'39 Second Way', 11195, N'DAGIAO    ', N'MO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (173, 115, 51, 140, 1198987, N'THE       ', N'16 White Fabien Blvd.', 16071, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (174, 121, 53, 145, NULL, N'THE       ', N'554 North Rocky Oak Boulevard', 27188, N'CHUAGIAO  ', N'AR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (175, 277, 20, 65, 2192803, N'TIENMAT   ', N'35 Fabien Drive', 28179, N'CHUAGIAO  ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (176, 168, 74, 22, NULL, N'THE       ', N'744 East Green New Blvd.', 45486, N'CHUAGIAO  ', N'ID')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (177, 218, 142, 70, 1945948, N'TIENMAT   ', N'96 White First Boulevard', 33484, N'DAGIAO    ', N'OK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (178, 246, 41, 46, NULL, N'THE       ', N'58 Green Second Avenue', 31541, N'CHUAGIAO  ', N'IL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (179, 44, 23, 135, NULL, N'TIENMAT   ', N'86 Clarendon Avenue', 33992, N'DAGIAO    ', N'UT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (180, 80, 23, 136, NULL, N'THE       ', N'32 White Milton Parkway', 21177, N'DAGIAO    ', N'AZ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (181, 67, 126, 6, NULL, N'TIENMAT   ', N'578 Cowley Boulevard', 46212, N'DAGIAO    ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (182, 256, 87, 117, NULL, N'THE       ', N'233 Green New Blvd.', 34723, N'DAGIAO    ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (183, 112, 80, 245, 5986965, N'THE       ', N'113 Rocky Cowley St.', 13203, N'DAGIAO    ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (184, 222, 120, 61, 2226304, N'THE       ', N'61 Rocky Nobel Way', 42280, N'DAGIAO    ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (185, 204, 150, 275, 1661194, N'THE       ', N'950 East Cowley St.', 10288, N'DAGIAO    ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (186, 230, 82, 9, 3770273, N'TIENMAT   ', N'87 New Way', 41214, N'CHUAGIAO  ', N'MN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (187, 243, 57, 153, NULL, N'THE       ', N'32 New Boulevard', 30937, N'DAGIAO    ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (188, 161, 105, 289, 4276961, N'THE       ', N'691 Rocky Clarendon Blvd.', 37636, N'CHUAGIAO  ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (189, 289, 50, 299, NULL, N'THE       ', N'142 East Nobel Way', 45261, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (190, 67, 126, 6, 1507647, N'THE       ', N'739 Cowley Boulevard', 25377, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (191, 35, 98, 197, 2248113, N'TIENMAT   ', N'24 Rocky Nobel Way', 40693, N'CHUAGIAO  ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (192, 282, 66, 84, 137024, N'THE       ', N'329 Milton Drive', 12384, N'DAGIAO    ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (193, 74, 12, 291, 5129198, N'TIENMAT   ', N'35 First Street', 44639, N'DAGIAO    ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (194, 276, 71, 177, 1362018, N'TIENMAT   ', N'612 Oak Boulevard', 48297, N'CHUAGIAO  ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (195, 13, 128, 232, 643895, N'THE       ', N'392 Rocky New Boulevard', 17635, N'DAGIAO    ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (196, 284, 17, 98, 3128662, N'THE       ', N'597 Milton Freeway', 43602, N'CHUAGIAO  ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (197, 191, 32, 127, 1480673, N'TIENMAT   ', N'17 East Rocky Clarendon Blvd.', 47301, N'CHUAGIAO  ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (198, 208, 44, 293, NULL, N'THE       ', N'148 Fabien St.', 10768, N'CHUAGIAO  ', N'MI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (199, 42, 6, 266, 728314, N'TIENMAT   ', N'198 North Green Clarendon Way', 13666, N'DAGIAO    ', N'WI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (200, 275, 12, 292, 417265, N'TIENMAT   ', N'45 Fabien Drive', 48641, N'DAGIAO    ', N'NE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (201, 30, 133, 77, NULL, N'THE       ', N'265 West Green Second Street', 47942, N'CHUAGIAO  ', N'MD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (202, 134, 26, 40, 1438388, N'THE       ', N'56 Old Parkway', 20138, N'DAGIAO    ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (203, 202, 116, 270, NULL, N'THE       ', N'427 Cowley Street', 42665, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (204, 165, 136, 54, 6081163, N'TIENMAT   ', N'866 South Cowley Avenue', 26023, N'DAGIAO    ', N'LA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (205, 236, 6, 265, NULL, N'THE       ', N'29 White Fabien Way', 21340, N'DAGIAO    ', N'OK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (206, 203, 16, 164, 1845911, N'THE       ', N'11 Hague Way', 33980, N'DAGIAO    ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (207, 174, 43, 236, 1917458, N'TIENMAT   ', N'788 West Nobel Way', 42112, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (208, 11, 99, 155, 1054415, N'THE       ', N'79 Rocky Milton Drive', 24133, N'CHUAGIAO  ', N'WI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (209, 186, 73, 106, NULL, N'THE       ', N'41 Rocky New Avenue', 27578, N'DAGIAO    ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (210, 16, 97, 298, 4521330, N'TIENMAT   ', N'103 South Rocky Cowley Freeway', 18130, N'CHUAGIAO  ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (211, 185, 28, 11, NULL, N'THE       ', N'97 First Parkway', 20075, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (212, 206, 76, 208, 771140, N'TIENMAT   ', N'442 West White New St.', 12430, N'CHUAGIAO  ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (213, 65, 107, 37, NULL, N'THE       ', N'672 Hague Blvd.', 17031, N'DAGIAO    ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (214, 26, 118, 59, 890189, N'THE       ', N'827 East Rocky New St.', 18533, N'DAGIAO    ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (215, 140, 36, 149, 1933620, N'TIENMAT   ', N'639 First Street', 36142, N'DAGIAO    ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (216, 123, 75, 175, 3028933, N'TIENMAT   ', N'38 West Nobel Freeway', 29981, N'DAGIAO    ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (217, 24, 69, 79, NULL, N'THE       ', N'23 Hague Way', 49231, N'CHUAGIAO  ', N'LA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (218, 78, 131, 94, 461198, N'THE       ', N'80 Green Cowley Road', 32143, N'DAGIAO    ', N'ID')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (219, 172, 121, 73, 548345, N'TIENMAT   ', N'746 New Street', 13241, N'CHUAGIAO  ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (220, 174, 43, 236, 1663149, N'TIENMAT   ', N'831 Old Boulevard', 44577, N'CHUAGIAO  ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (221, 134, 26, 40, 2554589, N'TIENMAT   ', N'10 Rocky Second St.', 14609, N'CHUAGIAO  ', N'VT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (222, 278, 56, 184, NULL, N'THE       ', N'725 Hague Way', 17385, N'DAGIAO    ', N'NM')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (223, 270, 72, 168, 1460277, N'TIENMAT   ', N'49 Rocky Clarendon Parkway', 18845, N'DAGIAO    ', N'MI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (224, 35, 98, 197, NULL, N'THE       ', N'14 Second Freeway', 15293, N'CHUAGIAO  ', N'OK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (225, 226, 78, 103, NULL, N'THE       ', N'429 South New St.', 40841, N'CHUAGIAO  ', N'WI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (226, 120, 114, 7, NULL, N'TIENMAT   ', N'911 Rocky New Way', 46073, N'CHUAGIAO  ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (227, 139, 124, 30, NULL, N'TIENMAT   ', N'31 Hague St.', 16557, N'DAGIAO    ', N'UT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (228, 63, 103, 264, NULL, N'TIENMAT   ', N'445 Rocky Old Avenue', 17775, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (229, 34, 94, 214, 2379872, N'THE       ', N'987 First Drive', 19553, N'DAGIAO    ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (230, 177, 122, 268, 429284, N'TIENMAT   ', N'630 Rocky Hague St.', 34578, N'CHUAGIAO  ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (231, 76, 64, 196, 1527321, N'TIENMAT   ', N'125 Green Fabien Blvd.', 48185, N'CHUAGIAO  ', N'MS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (232, 30, 133, 77, 3294799, N'THE       ', N'20 Fabien Boulevard', 32715, N'DAGIAO    ', N'IN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (233, 214, 69, 80, NULL, N'THE       ', N'81 Rocky Oak Freeway', 27875, N'CHUAGIAO  ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (234, 267, 84, 143, 793288, N'THE       ', N'15 Milton Parkway', 35352, N'CHUAGIAO  ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (235, 26, 118, 59, NULL, N'TIENMAT   ', N'272 Clarendon Way', 23235, N'DAGIAO    ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (236, 114, 122, 267, 3729236, N'TIENMAT   ', N'34 Green Cowley Freeway', 36074, N'CHUAGIAO  ', N'AL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (237, 68, 47, 148, NULL, N'THE       ', N'80 Oak Boulevard', 42058, N'CHUAGIAO  ', N'TX')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (238, 93, 31, 192, NULL, N'TIENMAT   ', N'79 Hague Drive', 37180, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (239, 297, 19, 96, 2057440, N'THE       ', N'742 Oak Parkway', 30939, N'CHUAGIAO  ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (240, 241, 33, 111, NULL, N'TIENMAT   ', N'39 East Old Avenue', 26308, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (241, 184, 121, 74, 2732174, N'THE       ', N'560 New Parkway', 49102, N'DAGIAO    ', N'IL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (242, 289, 50, 299, NULL, N'TIENMAT   ', N'443 North White Second Way', 16803, N'CHUAGIAO  ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (243, 278, 56, 184, 2179769, N'TIENMAT   ', N'145 First Drive', 20057, N'DAGIAO    ', N'KY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (244, 296, 77, 1, NULL, N'TIENMAT   ', N'637 Oak Road', 37131, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (245, 239, 83, 296, 2957464, N'THE       ', N'132 Rocky Old Way', 15301, N'CHUAGIAO  ', N'MA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (246, 161, 105, 289, 1953062, N'TIENMAT   ', N'19 Green Clarendon Avenue', 38262, N'DAGIAO    ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (247, 71, 24, 48, 707209, N'THE       ', N'48 First St.', 45353, N'DAGIAO    ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (248, 13, 128, 232, 2223305, N'THE       ', N'464 Green First Way', 36105, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (249, 163, 65, 28, 5746697, N'TIENMAT   ', N'657 South Clarendon Street', 22154, N'DAGIAO    ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (250, 125, 68, 58, 3627439, N'THE       ', N'36 South Milton Street', 37655, N'DAGIAO    ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (251, 235, 11, 19, 1771019, N'TIENMAT   ', N'76 North Old Blvd.', 44371, N'DAGIAO    ', N'MO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (252, 192, 34, 34, 7369880, N'TIENMAT   ', N'37 Old Way', 25158, N'DAGIAO    ', N'MT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (253, 129, 3, 220, 1169558, N'TIENMAT   ', N'48 Oak Way', 47528, N'CHUAGIAO  ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (254, 117, 93, 31, 1105729, N'THE       ', N'636 Clarendon Boulevard', 19089, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (255, 259, 106, 252, 117232, N'TIENMAT   ', N'92 Second Drive', 44031, N'CHUAGIAO  ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (256, 28, 108, 193, 2552690, N'THE       ', N'50 East Hague Road', 40557, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (257, 108, 110, 172, NULL, N'THE       ', N'84 Green Old Boulevard', 11292, N'DAGIAO    ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (258, 172, 121, 73, 3867616, N'TIENMAT   ', N'87 Green Fabien St.', 37372, N'DAGIAO    ', N'AR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (259, 259, 106, 252, 173752, N'THE       ', N'531 South Rocky Clarendon Freeway', 35182, N'CHUAGIAO  ', N'MD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (260, 111, 90, 258, 2113172, N'THE       ', N'146 Rocky New Blvd.', 25268, N'CHUAGIAO  ', N'WI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (261, 44, 23, 135, NULL, N'TIENMAT   ', N'96 South Old Boulevard', 27423, N'CHUAGIAO  ', N'NV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (262, 245, 55, 273, 901776, N'TIENMAT   ', N'86 East White First St.', 34336, N'CHUAGIAO  ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (263, 73, 130, 241, NULL, N'THE       ', N'734 North Oak Blvd.', 14580, N'DAGIAO    ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (264, 56, 51, 139, 1135221, N'TIENMAT   ', N'58 East Oak Road', 43001, N'CHUAGIAO  ', N'ID')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (265, 226, 78, 103, 3924665, N'THE       ', N'42 East Cowley Way', 19945, N'CHUAGIAO  ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (266, 258, 145, 234, 91298, N'THE       ', N'38 Second Parkway', 37361, N'CHUAGIAO  ', N'MO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (267, 126, 4, 129, 1488190, N'TIENMAT   ', N'43 West Clarendon Blvd.', 34556, N'CHUAGIAO  ', N'OR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (268, 271, 64, 195, 2016950, N'TIENMAT   ', N'310 Fabien Blvd.', 31680, N'DAGIAO    ', N'AR')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (269, 22, 50, 300, 1665370, N'THE       ', N'545 White Clarendon Parkway', 45298, N'CHUAGIAO  ', N'GA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (270, 82, 56, 183, 281820, N'TIENMAT   ', N'17 Green Second Drive', 10068, N'DAGIAO    ', N'WV')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (271, 81, 65, 27, 1577868, N'TIENMAT   ', N'42 Green Cowley Street', 37923, N'DAGIAO    ', N'AZ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (272, 252, 48, 188, 4930932, N'TIENMAT   ', N'97 Green Nobel St.', 22050, N'CHUAGIAO  ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (273, 16, 97, 298, 515593, N'THE       ', N'91 Rocky Oak St.', 11203, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (274, 39, 35, 262, NULL, N'TIENMAT   ', N'28 New Parkway', 36933, N'CHUAGIAO  ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (275, 209, 40, 162, 887336, N'THE       ', N'418 Rocky Milton Boulevard', 45476, N'DAGIAO    ', N'AK')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (276, 262, 125, 42, NULL, N'TIENMAT   ', N'653 New Way', 47807, N'CHUAGIAO  ', N'PA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (277, 296, 77, 1, 652110, N'THE       ', N'91 Green Cowley Blvd.', 47328, N'DAGIAO    ', N'IA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (278, 270, 72, 168, NULL, N'THE       ', N'874 West Rocky Milton Street', 31715, N'DAGIAO    ', N'LA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (279, 158, 91, 202, 2216884, N'THE       ', N'48 Cowley Parkway', 49992, N'DAGIAO    ', N'KS')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (280, 237, 119, 114, NULL, N'TIENMAT   ', N'361 Green New Blvd.', 12578, N'CHUAGIAO  ', N'NC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (281, 232, 92, 260, 2424762, N'TIENMAT   ', N'978 East White Nobel Avenue', 10719, N'CHUAGIAO  ', N'NH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (282, 284, 17, 98, 2027287, N'THE       ', N'482 West Milton Drive', 30453, N'CHUAGIAO  ', N'CA')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (283, 174, 43, 236, NULL, N'TIENMAT   ', N'567 Milton Street', 45622, N'DAGIAO    ', N'NJ')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (284, 279, 99, 156, NULL, N'THE       ', N'53 Green Milton Blvd.', 31899, N'DAGIAO    ', N'DE')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (285, 190, 104, 249, NULL, N'TIENMAT   ', N'80 West Clarendon Parkway', 40207, N'CHUAGIAO  ', N'MN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (286, 51, 16, 163, 3387993, N'TIENMAT   ', N'994 West Oak Avenue', 33027, N'DAGIAO    ', N'WI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (287, 131, 27, 157, NULL, N'THE       ', N'44 Milton Freeway', 35188, N'CHUAGIAO  ', N'NY')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (288, 75, 88, 49, 2049505, N'THE       ', N'147 Rocky New Avenue', 18785, N'DAGIAO    ', N'NM')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (289, 83, 31, 191, 3873062, N'THE       ', N'239 White Second Freeway', 41322, N'DAGIAO    ', N'OH')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (290, 250, 45, 166, NULL, N'TIENMAT   ', N'21 First Street', 32679, N'DAGIAO    ', N'UT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (291, 149, 19, 95, 416491, N'TIENMAT   ', N'63 East Second St.', 34781, N'CHUAGIAO  ', N'SD')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (292, 298, 100, 75, 2881289, N'TIENMAT   ', N'62 West Oak Way', 14685, N'DAGIAO    ', N'RI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (293, 73, 130, 241, 1831504, N'TIENMAT   ', N'931 White Fabien Drive', 11998, N'DAGIAO    ', N'SC')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (294, 56, 51, 139, 1386371, N'TIENMAT   ', N'780 Oak Freeway', 15671, N'DAGIAO    ', N'FL')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (295, 12, 111, 277, 2444344, N'THE       ', N'31 South First Avenue', 48886, N'DAGIAO    ', N'CT')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (296, 152, 10, 102, 2420085, N'THE       ', N'38 Hague Blvd.', 24765, N'DAGIAO    ', N'HI')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (297, 125, 68, 58, 5518569, N'TIENMAT   ', N'326 Old Parkway', 12223, N'DAGIAO    ', N'TN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (298, 246, 41, 46, 4726972, N'THE       ', N'938 Green Milton Boulevard', 27056, N'CHUAGIAO  ', N'CO')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (299, 169, 149, 199, 5569265, N'TIENMAT   ', N'575 Green Second Way', 27185, N'CHUAGIAO  ', N'MN')
GO
INSERT [dbo].[DONHANG] ([MaDonHang], [MaDT], [MaTaiXe], [MaKhachHang], [TongTien], [HinhThucThanhToan], [DiaChiGiaoHang], [PhiVanChuyen], [TinhTrangDonHang], [KhuVuc]) VALUES (300, 45, 120, 62, 2918995, N'THE       ', N'547 South Hague Road', 27941, N'DAGIAO    ', N'WA')
GO
SET IDENTITY_INSERT [dbo].[DONHANG] OFF
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (218, 169, 299)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (246, 275, 200)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (231, 244, 7)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (168, 279, 284)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (62, 235, 124)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (168, 206, 212)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (272, 82, 113)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (133, 78, 218)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (294, 130, 171)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (83, 180, 108)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (88, 230, 186)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (141, 149, 20)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (190, 131, 287)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (141, 292, 17)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (295, 77, 163)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (10, 203, 206)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (259, 256, 129)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (299, 172, 219)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (204, 140, 136)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (95, 79, 110)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (246, 256, 182)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (255, 93, 238)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (298, 59, 63)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (10, 211, 81)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (210, 38, 19)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (158, 221, 70)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (281, 131, 93)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (207, 48, 49)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (165, 55, 78)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (25, 30, 232)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (57, 231, 104)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (136, 21, 27)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (90, 29, 57)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (297, 32, 121)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (193, 108, 257)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (229, 211, 31)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (10, 149, 291)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (115, 218, 177)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (103, 37, 53)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (288, 115, 173)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (152, 154, 158)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (215, 259, 259)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (36, 250, 290)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (83, 17, 14)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (273, 216, 92)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (239, 85, 145)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (102, 190, 285)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (138, 134, 202)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (45, 247, 43)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (67, 80, 180)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (124, 157, 94)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (216, 28, 166)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (186, 206, 102)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (147, 179, 82)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (59, 143, 11)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (264, 125, 250)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (248, 68, 115)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (221, 68, 237)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (258, 186, 209)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (204, 240, 87)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (188, 51, 83)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (66, 63, 56)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (269, 242, 159)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (269, 107, 33)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (26, 184, 241)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (252, 221, 62)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (52, 80, 32)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (194, 117, 76)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (249, 172, 258)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (66, 71, 247)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (300, 278, 138)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (145, 52, 141)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (196, 297, 239)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (216, 31, 77)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (243, 166, 140)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (31, 120, 226)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (219, 96, 28)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (216, 109, 100)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (38, 4, 89)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (272, 161, 188)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (57, 41, 139)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (144, 209, 275)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (163, 144, 65)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (98, 147, 135)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (202, 152, 296)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (141, 7, 26)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (251, 81, 271)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (243, 298, 292)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (239, 284, 282)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (230, 215, 147)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (282, 245, 262)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (89, 158, 85)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (157, 248, 40)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (200, 76, 231)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (100, 110, 105)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (87, 239, 245)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (247, 88, 155)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (67, 139, 227)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (57, 4, 46)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (21, 153, 150)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (188, 18, 48)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (208, 181, 132)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (190, 181, 41)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (279, 174, 207)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (67, 101, 36)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (279, 211, 99)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (20, 28, 35)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (271, 177, 230)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (204, 252, 101)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (29, 17, 86)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (45, 17, 12)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (33, 250, 168)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (183, 223, 21)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (286, 154, 148)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (148, 147, 125)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (45, 116, 25)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (204, 231, 106)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (171, 104, 96)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (68, 111, 260)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (186, 142, 42)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (2, 11, 208)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (109, 13, 248)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (256, 123, 216)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (19, 185, 211)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (85, 241, 240)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (212, 263, 38)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (288, 214, 233)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (297, 162, 51)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (117, 152, 47)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (157, 65, 213)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (85, 138, 8)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (152, 11, 160)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (160, 44, 179)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (18, 45, 300)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (85, 252, 61)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (149, 213, 152)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (254, 112, 165)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (184, 274, 162)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (32, 72, 15)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (223, 229, 91)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (121, 165, 204)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (281, 275, 161)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (40, 170, 37)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (210, 27, 79)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (185, 226, 225)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (250, 83, 289)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (206, 282, 192)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (171, 37, 120)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (52, 30, 201)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (56, 38, 60)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (183, 51, 286)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (76, 259, 66)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (300, 94, 34)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (171, 262, 276)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (20, 232, 281)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (80, 289, 170)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (253, 12, 295)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (171, 16, 273)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (194, 121, 174)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (155, 296, 244)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (292, 289, 18)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (24, 105, 133)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (154, 208, 198)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (47, 118, 13)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (245, 22, 269)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (193, 226, 265)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (173, 258, 266)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (166, 173, 164)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (202, 26, 55)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (299, 88, 107)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (91, 111, 59)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (20, 25, 1)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (140, 242, 68)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (145, 21, 142)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (65, 199, 54)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (22, 195, 75)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (70, 110, 50)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (46, 226, 39)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (135, 270, 223)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (136, 272, 29)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (6, 192, 252)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (117, 140, 215)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (245, 16, 23)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (61, 276, 194)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (275, 154, 154)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (9, 59, 64)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (153, 75, 288)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (289, 56, 264)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (299, 13, 195)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (6, 73, 293)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (197, 44, 261)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (84, 114, 236)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (291, 112, 183)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (177, 26, 214)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (232, 147, 131)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (98, 136, 97)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (127, 174, 283)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (293, 238, 126)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (266, 64, 137)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (292, 284, 84)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (77, 198, 123)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (40, 97, 149)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (270, 174, 220)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (54, 121, 72)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (265, 299, 9)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (164, 131, 130)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (236, 134, 143)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (155, 42, 199)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (106, 126, 267)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (298, 22, 153)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (11, 270, 6)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (208, 67, 190)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (37, 289, 242)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (59, 191, 197)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (149, 252, 272)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (175, 88, 172)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (79, 225, 95)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (94, 202, 203)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (73, 16, 210)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (236, 161, 246)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (40, 175, 112)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (184, 26, 235)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (168, 110, 98)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (197, 170, 24)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (103, 63, 228)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (7, 236, 205)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (30, 38, 109)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (264, 244, 80)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (214, 24, 217)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (268, 97, 67)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (196, 248, 127)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (77, 246, 298)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (80, 278, 222)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (143, 145, 30)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (59, 155, 134)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (267, 116, 144)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (148, 158, 169)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (192, 246, 178)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (96, 122, 122)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (111, 55, 74)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (74, 74, 193)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (299, 39, 274)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (184, 118, 103)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (1, 267, 234)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (296, 204, 185)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (289, 48, 116)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (48, 289, 189)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (232, 82, 151)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (28, 222, 184)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (58, 284, 196)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (19, 125, 297)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (34, 233, 10)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (220, 35, 191)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (31, 182, 22)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (252, 28, 256)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (193, 214, 156)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (172, 73, 263)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (73, 170, 16)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (252, 38, 117)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (258, 271, 268)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (135, 54, 146)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (273, 134, 221)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (241, 163, 249)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (139, 55, 52)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (103, 223, 2)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (234, 94, 128)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (129, 45, 5)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (195, 22, 71)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (300, 117, 254)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (183, 243, 187)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (27, 58, 58)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (188, 195, 88)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (298, 95, 119)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (262, 98, 90)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (162, 176, 167)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (42, 270, 4)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (1, 233, 44)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (168, 8, 114)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (202, 34, 229)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (114, 235, 251)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (260, 280, 3)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (98, 56, 294)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (236, 245, 45)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (156, 82, 270)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (249, 48, 111)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (163, 168, 176)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (157, 237, 280)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (49, 35, 224)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (191, 190, 69)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (166, 129, 253)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (95, 296, 277)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (75, 259, 255)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (241, 278, 243)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (139, 76, 73)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (277, 67, 181)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (102, 277, 175)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (58, 183, 157)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (46, 158, 279)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (199, 270, 278)
GO
INSERT [dbo].[HD_DT] ([MaHD], [MaDT], [MaChiNhanh]) VALUES (62, 154, 118)
GO
SET IDENTITY_INSERT [dbo].[SANPHAM] ON 
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (1, 299, 169, N'Zeevenax', 31711)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (2, 200, 275, N'Grobanistor', 103168)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (3, 282, 284, N'Klitinanax', 53168)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (4, 286, 51, N'Supbaninin', 151622)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (5, 56, 63, N'Barwerpentor', 90527)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (6, 286, 51, N'Adsapilor', 160996)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (7, 119, 95, N'Unwerpantor', 104262)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (8, 202, 134, N'Tupnipopax', 110590)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (9, 171, 130, N'Mondudegower', 160772)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (10, 240, 241, N'Zeetanistor', 119688)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (11, 59, 111, N'Frotumover', 146298)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (12, 160, 11, N'Supnipentor', 103986)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (13, 287, 131, N'Rapdudommor', 135208)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (14, 160, 11, N'Parmunantor', 156370)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (15, 163, 77, N'Klitumepex', 101863)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (16, 291, 149, N'Truzapower', 155384)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (17, 137, 64, N'Resapicator', 198871)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (18, 219, 172, N'Tipvenar', 31554)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (19, 38, 263, N'Tupericax', 79846)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (20, 203, 202, N'Barwerewicator', 154238)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (21, 200, 275, N'Empebicantor', 32743)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (22, 209, 186, N'Qwifropanan', 46615)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (23, 34, 94, N'Parbanower', 95807)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (24, 291, 149, N'Adtinicower', 89666)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (25, 278, 270, N'Monjubackazz', 99806)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (26, 96, 104, N'Cipfropantor', 83860)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (27, 84, 284, N'Ciprobupentor', 170548)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (28, 19, 38, N'Trurobepazz', 45744)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (29, 214, 26, N'Windudan', 116165)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (30, 241, 184, N'Windimollistor', 81322)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (31, 197, 191, N'Endbanommover', 93764)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (32, 152, 213, N'Dopglibower', 85698)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (33, 222, 278, N'Barquestistor', 77985)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (34, 63, 59, N'Winquestackor', 58009)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (35, 106, 231, N'Upnipax', 101193)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (36, 90, 98, N'Unkilimover', 95078)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (37, 291, 149, N'Surbanor', 70689)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (38, 5, 45, N'Uppeban', 111873)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (39, 251, 235, N'Qwitinex', 107689)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (40, 18, 289, N'Varhupollicator', 143839)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (41, 187, 243, N'Unfropar', 103005)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (42, 217, 24, N'Cipdudicator', 120028)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (43, 112, 175, N'Injubicator', 180224)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (44, 240, 241, N'Thrududopistor', 158980)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (45, 113, 82, N'Klisapicin', 123508)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (46, 268, 271, N'Cipsipazz', 59855)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (47, 228, 63, N'Gropebazz', 118074)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (48, 169, 158, N'Trudimover', 185113)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (49, 189, 289, N'Klifropantor', 196689)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (50, 255, 259, N'Groweror', 192365)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (51, 30, 145, N'Raperan', 149002)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (52, 128, 94, N'Grosapedgex', 136695)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (53, 76, 117, N'Tuptumexor', 38670)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (54, 288, 75, N'Wintinax', 39150)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (55, 227, 139, N'Superupar', 117148)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (56, 181, 67, N'Tippebaquor', 185096)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (57, 62, 221, N'Truvenollistor', 37360)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (58, 151, 82, N'Wincadanax', 163502)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (59, 129, 256, N'Lomtinicentor', 81815)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (60, 38, 263, N'Endhupexex', 36666)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (61, 257, 108, N'Doptuminar', 190448)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (62, 196, 284, N'Supvenplicator', 88517)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (63, 92, 216, N'Tupdudonentor', 194425)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (64, 92, 216, N'Klitanexazz', 109449)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (65, 184, 222, N'Partuman', 55924)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (66, 216, 123, N'Surwerpupentor', 90600)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (67, 139, 41, N'Unnipepar', 56001)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (68, 261, 44, N'Unhupower', 107199)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (69, 243, 278, N'Klitinaquor', 85176)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (70, 196, 284, N'Tupnipedgantor', 36784)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (71, 138, 278, N'Klicadax', 114695)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (72, 213, 65, N'Inwerpedower', 116998)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (73, 132, 181, N'Surmunegantor', 123865)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (74, 128, 94, N'Undimex', 136007)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (75, 182, 256, N'Rapwerpax', 81233)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (76, 109, 38, N'Survenar', 112715)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (77, 91, 229, N'Varpebor', 66392)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (78, 128, 94, N'Uphupefin', 136828)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (79, 149, 97, N'Lomglibupistor', 166159)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (80, 119, 95, N'Upkilicex', 69951)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (81, 197, 191, N'Barfropollicator', 165786)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (82, 82, 179, N'Barcadin', 185436)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (83, 263, 73, N'Truglibollin', 49056)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (84, 285, 190, N'Recadover', 123800)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (85, 49, 48, N'Tupvenilicator', 132320)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (86, 160, 11, N'Winhupan', 157069)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (87, 295, 12, N'Inerinower', 77027)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (88, 182, 256, N'Rapkilexistor', 68835)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (89, 268, 271, N'Tipsapover', 140862)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (90, 7, 244, N'Happickedax', 116098)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (91, 183, 112, N'Happebedicator', 87718)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (92, 236, 114, N'Monquestamar', 107187)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (93, 120, 37, N'Innipinower', 60057)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (94, 79, 27, N'Uprobazz', 101022)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (95, 53, 37, N'Emsapepicator', 153392)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (96, 186, 230, N'Lombanexicator', 44488)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (97, 271, 81, N'Rappebistor', 125604)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (98, 255, 259, N'Adkilazz', 100774)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (99, 197, 191, N'Surbanan', 133055)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (100, 58, 58, N'Frocadollicator', 62908)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (101, 257, 108, N'Doppickexower', 33854)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (102, 118, 154, N'Upkilaquor', 40875)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (103, 287, 131, N'Truericator', 129936)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (104, 99, 211, N'Haprobedgantor', 189904)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (105, 255, 259, N'Hapwerpollicator', 107670)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (106, 99, 211, N'Varwerex', 62004)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (107, 133, 105, N'Parfropackax', 42829)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (108, 188, 161, N'Lomtanazz', 102663)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (109, 38, 263, N'Partinan', 157918)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (110, 15, 72, N'Gropebopover', 34432)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (111, 189, 289, N'Upbanopar', 148703)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (112, 242, 289, N'Emmunicower', 100532)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (113, 156, 214, N'Tupbanplax', 197344)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (114, 148, 154, N'Varzapewover', 41864)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (115, 158, 154, N'Uphupexantor', 70881)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (116, 189, 289, N'Truwerupistor', 35012)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (117, 38, 263, N'Varpebimicator', 69460)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (118, 42, 142, N'Qwikililower', 100624)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (119, 260, 111, N'Unbanommin', 177130)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (120, 76, 117, N'Wincadan', 98855)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (121, 234, 267, N'Fronipepower', 43572)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (122, 47, 152, N'Varpickor', 187166)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (123, 144, 116, N'Redudonor', 166337)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (124, 75, 195, N'Lombanopazz', 169078)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (125, 279, 158, N'Zeerobantor', 149067)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (126, 259, 259, N'Dopwerpower', 37507)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (127, 18, 289, N'Unpebopicator', 86940)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (128, 63, 59, N'Trusipor', 52842)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (129, 146, 54, N'Tipcadupex', 182616)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (130, 120, 37, N'Winglibanex', 66744)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (131, 279, 158, N'Hapwerover', 187112)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (132, 187, 243, N'Grofropommin', 165619)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (133, 273, 16, N'Untumistor', 33772)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (134, 211, 185, N'Varcadar', 133250)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (135, 279, 158, N'Winhuponantor', 66097)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (136, 164, 173, N'Dopnipadan', 154910)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (137, 9, 299, N'Surpebax', 85499)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (138, 231, 76, N'Cipmunistor', 59153)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (139, 22, 182, N'Zeevenin', 46130)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (140, 143, 134, N'Kliwerexazz', 100315)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (141, 29, 272, N'Cipweristor', 144240)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (142, 84, 284, N'Trutanax', 174365)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (143, 12, 17, N'Adtumommentor', 110918)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (144, 278, 270, N'Klipickewex', 136429)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (145, 127, 248, N'Dopcadentor', 167396)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (146, 165, 112, N'Frowerpicower', 187187)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (147, 100, 109, N'Kliglibar', 109844)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (148, 42, 142, N'Adsipupan', 48192)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (149, 139, 41, N'Qwivenover', 60141)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (150, 134, 155, N'Zeebanaquistor', 148379)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (151, 156, 214, N'Supkilinistor', 175028)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (152, 245, 239, N'Rappebanan', 54979)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (153, 138, 278, N'Suppebor', 123645)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (154, 42, 142, N'Advenilax', 64200)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (155, 133, 105, N'Qwizapupax', 49335)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (156, 85, 158, N'Barrobover', 46688)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (157, 238, 93, N'Klidudan', 74538)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (158, 42, 142, N'Tupnipantor', 160859)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (159, 261, 44, N'Klikilor', 70837)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (160, 69, 190, N'Rapbanicator', 100162)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (161, 107, 88, N'Haptumover', 175064)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (162, 232, 30, N'Lomwerpazz', 189987)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (163, 70, 221, N'Winzapentor', 120048)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (164, 32, 80, N'Incadower', 121173)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (165, 115, 68, N'Raptanover', 47320)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (166, 106, 231, N'Tupjubar', 183085)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (167, 225, 226, N'Emkilommax', 96759)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (168, 284, 279, N'Thruzapax', 94093)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (169, 49, 48, N'Thrutumefar', 175767)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (170, 219, 172, N'Barquestaquex', 115971)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (171, 105, 110, N'Unzapefex', 149514)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (172, 133, 105, N'Growerpplistor', 40307)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (173, 20, 149, N'Adfropinover', 84494)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (174, 213, 65, N'Froerazz', 106814)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (175, 54, 199, N'Surtinentor', 154616)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (176, 297, 125, N'Dopbanegax', 69208)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (177, 193, 74, N'Gropebex', 106248)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (178, 4, 270, N'Inwerpar', 59908)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (179, 125, 147, N'Barvenan', 31682)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (180, 152, 213, N'Endsapepar', 161881)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (181, 64, 59, N'Varsapommover', 127664)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (182, 146, 54, N'Rebananantor', 68747)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (183, 115, 68, N'Unmunex', 192702)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (184, 124, 235, N'Inwerpicator', 64236)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (185, 185, 204, N'Groquesticator', 91717)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (186, 206, 203, N'Inhupar', 162133)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (187, 65, 144, N'Endsapex', 71974)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (188, 274, 39, N'Truzapicor', 169573)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (189, 219, 172, N'Lomhupefistor', 113915)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (190, 64, 59, N'Wincadamazz', 49409)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (191, 87, 240, N'Tipkilopex', 110371)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (192, 298, 246, N'Qwirobower', 124640)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (193, 195, 13, N'Qwiwerexar', 188317)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (194, 103, 118, N'Qwisipommistor', 145969)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (195, 3, 280, N'Hapvenollan', 125252)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (196, 285, 190, N'Qwirobepazz', 154253)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (197, 199, 42, N'Qwipickower', 84316)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (198, 121, 32, N'Dopvenower', 189746)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (199, 33, 107, N'Windimistor', 119108)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (200, 107, 88, N'Groglibadicator', 184312)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (201, 95, 225, N'Endglibollentor', 120427)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (202, 12, 17, N'Cipvenor', 45750)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (203, 154, 154, N'Haprobicover', 72426)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (204, 104, 231, N'Frofropar', 144170)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (205, 230, 177, N'Adfropantor', 198866)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (206, 172, 88, N'Dopvenex', 164721)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (207, 140, 166, N'Qwisipex', 170486)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (208, 69, 190, N'Rejubaquax', 46831)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (209, 2, 223, N'Zeekilicax', 109585)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (210, 34, 94, N'Tupbanonar', 180128)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (211, 81, 211, N'Unweronax', 140441)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (212, 118, 154, N'Upcadilex', 44630)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (213, 37, 170, N'Supzapilar', 159177)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (214, 227, 139, N'Rapdimin', 108957)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (215, 164, 173, N'Haphupistor', 172498)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (216, 41, 181, N'Klimunan', 136316)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (217, 8, 138, N'Thrutinefex', 197286)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (218, 294, 56, N'Winsipistor', 85811)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (219, 123, 198, N'Cipjubistor', 59456)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (220, 140, 166, N'Zeewerpinentor', 85188)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (221, 12, 17, N'Refropanantor', 141110)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (222, 231, 76, N'Rapdimanower', 127186)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (223, 286, 51, N'Upmunazz', 180179)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (224, 87, 240, N'Happickentor', 156358)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (225, 251, 235, N'Qwitumilistor', 35600)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (226, 44, 233, N'Parsapommar', 54873)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (227, 168, 250, N'Inpebewan', 51990)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (228, 181, 67, N'Varmunar', 138525)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (229, 45, 245, N'Doperistor', 181563)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (230, 116, 48, N'Zeebanicator', 30362)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (231, 132, 181, N'Trumunupicator', 184892)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (232, 95, 225, N'Trujubaman', 116503)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (233, 85, 158, N'Zeetinupax', 140800)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (234, 253, 129, N'Upwerpepistor', 47371)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (235, 227, 139, N'Recadistor', 71453)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (236, 159, 242, N'Upjubex', 111914)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (237, 158, 154, N'Varhupilantor', 196322)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (238, 296, 152, N'Requestan', 78531)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (239, 16, 170, N'Zeeerilan', 65371)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (240, 177, 218, N'Rerobommicator', 126996)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (241, 277, 296, N'Parwerpentor', 191648)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (242, 219, 172, N'Supquestilicator', 55142)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (243, 231, 76, N'Hapweredgentor', 89988)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (244, 208, 11, N'Varquestilazz', 133787)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (245, 51, 162, N'Trududax', 108969)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (246, 274, 39, N'Kliwerpicistor', 95740)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (247, 46, 4, N'Rapbanicor', 165464)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (248, 3, 280, N'Dopnipicin', 109360)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (249, 226, 120, N'Qwimunilistor', 173471)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (250, 194, 276, N'Klinipentor', 188936)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (251, 75, 195, N'Tupdudazz', 156968)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (252, 89, 4, N'Qwipebazz', 198506)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (253, 191, 35, N'Grosipefantor', 160290)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (254, 109, 38, N'Lomvenilor', 63920)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (255, 216, 123, N'Tupfropimex', 73201)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (256, 106, 231, N'Klihupegover', 193241)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (257, 162, 274, N'Addimicator', 65572)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (258, 123, 198, N'Cippickonover', 116068)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (259, 216, 123, N'Retanex', 138570)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (260, 129, 256, N'Dopzapin', 173992)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (261, 125, 147, N'Truzapex', 142731)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (262, 113, 82, N'Rapnipefex', 61960)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (263, 258, 172, N'Insipax', 65269)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (264, 17, 292, N'Supfropover', 109222)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (265, 251, 235, N'Varhupax', 195236)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (266, 269, 22, N'Enddudefistor', 53937)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (267, 198, 208, N'Remunommicator', 103831)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (268, 192, 282, N'Parsipar', 141805)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (269, 138, 278, N'Frosapepantor', 67503)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (270, 156, 214, N'Emkilan', 90584)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (271, 175, 277, N'Klisipan', 139995)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (272, 257, 108, N'Klisapex', 148754)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (273, 34, 94, N'Raptumommower', 50439)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (274, 250, 125, N'Lomwerpedazz', 132460)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (275, 98, 110, N'Frorobaquazz', 93540)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (276, 43, 247, N'Klipebax', 115968)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (277, 208, 11, N'Gropebentor', 67198)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (278, 286, 51, N'Uppebover', 76391)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (279, 49, 48, N'Tipzapower', 77389)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (280, 283, 174, N'Monglibex', 139860)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (281, 80, 244, N'Uphupefor', 89409)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (282, 285, 190, N'Grohupepazz', 142631)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (283, 140, 166, N'Barfropin', 165054)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (284, 276, 262, N'Adtuman', 192627)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (285, 243, 278, N'Truweradentor', 73394)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (286, 263, 73, N'Cipdimar', 186387)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (287, 120, 37, N'Trutinewan', 156213)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (288, 201, 30, N'Haperupor', 106880)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (289, 101, 252, N'Doperupex', 174170)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (290, 284, 279, N'Inweregower', 78212)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (291, 203, 202, N'Rewerpar', 76342)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (292, 170, 289, N'Bardiman', 110254)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (293, 258, 172, N'Qwisiponax', 139962)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (294, 17, 292, N'Ciperonor', 91380)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (295, 207, 174, N'Untanantor', 184266)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (296, 228, 63, N'Unsipinor', 159688)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (297, 194, 276, N'Sursapopazz', 189874)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (298, 4, 270, N'Qwiwerpupazz', 180766)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (299, 24, 170, N'Unrobollover', 138552)
GO
INSERT [dbo].[SANPHAM] ([MaSanPham], [MaChiNhanh], [MaDT], [TenSanPham], [DonGia]) VALUES (300, 56, 63, N'Gropebexower', 85031)
GO
SET IDENTITY_INSERT [dbo].[SANPHAM] OFF
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (218, 218, N'Winsipistor', 5, 429055)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (246, 246, N'Kliwerpicistor', 13, 1244620)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (231, 231, N'Trumunupicator', 8, 1479136)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (168, 168, N'Thruzapax', 7, 658651)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (62, 62, N'Supvenplicator', 5, 442585)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (168, 168, N'Thruzapax', 19, 1787767)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (272, 272, N'Klisapex', 18, 2677572)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (133, 133, N'Untumistor', 8, 270176)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (294, 294, N'Ciperonor', 15, 1370700)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (83, 83, N'Truglibollin', 12, 588672)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (88, 88, N'Rapkilexistor', 7, 481845)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (141, 141, N'Cipweristor', 15, 2163600)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (190, 190, N'Wincadamazz', 12, 592908)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (141, 141, N'Cipweristor', 11, 1586640)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (295, 295, N'Untanantor', 13, 2395458)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (10, 10, N'Zeetanistor', 19, 2274072)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (259, 259, N'Retanex', 1, 138570)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (299, 299, N'Unrobollover', 13, 1801176)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (204, 204, N'Frofropar', 4, 576680)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (95, 95, N'Emsapepicator', 10, 1533920)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (246, 246, N'Kliwerpicistor', 7, 670180)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (255, 255, N'Tupfropimex', 1, 73201)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (298, 298, N'Qwiwerpupazz', 13, 2349958)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (10, 10, N'Zeetanistor', 11, 1316568)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (210, 210, N'Tupbanonar', 15, 2701920)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (158, 158, N'Tupnipantor', 14, 2252026)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (281, 281, N'Uphupefor', 7, 625863)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (207, 207, N'Qwisipex', 11, 1875346)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (165, 165, N'Raptanover', 2, 94640)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (25, 25, N'Monjubackazz', 18, 1796508)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (57, 57, N'Truvenollistor', 8, 298880)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (136, 136, N'Dopnipadan', 15, 2323650)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (90, 90, N'Happickedax', 2, 232196)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (297, 297, N'Sursapopazz', 9, 1708866)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (193, 193, N'Qwiwerexar', 17, 3201389)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (229, 229, N'Doperistor', 13, 2360319)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (10, 10, N'Zeetanistor', 20, 2393760)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (115, 115, N'Uphupexantor', 3, 212643)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (103, 103, N'Truericator', 12, 1559232)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (288, 288, N'Haperupor', 11, 1175680)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (152, 152, N'Rappebanan', 1, 54979)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (215, 215, N'Haphupistor', 11, 1897478)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (36, 36, N'Unkilimover', 12, 1140936)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (83, 83, N'Truglibollin', 8, 392448)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (273, 273, N'Raptumommower', 6, 302634)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (239, 239, N'Zeeerilan', 20, 1307420)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (102, 102, N'Upkilaquor', 3, 122625)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (138, 138, N'Cipmunistor', 12, 709836)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (45, 45, N'Klisapicin', 11, 1358588)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (67, 67, N'Unnipepar', 7, 392007)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (124, 124, N'Lombanopazz', 14, 2367092)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (216, 216, N'Klimunan', 3, 408948)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (186, 186, N'Inhupar', 4, 648532)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (147, 147, N'Kliglibar', 7, 768908)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (59, 59, N'Lomtinicentor', 18, 1472670)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (264, 264, N'Supfropover', 4, 436888)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (248, 248, N'Dopnipicin', 20, 2187200)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (221, 221, N'Refropanantor', 18, 2539980)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (258, 258, N'Cippickonover', 13, 1508884)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (204, 204, N'Frofropar', 11, 1585870)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (188, 188, N'Truzapicor', 13, 2204449)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (66, 66, N'Surwerpupentor', 8, 724800)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (269, 269, N'Frosapepantor', 7, 472521)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (269, 269, N'Frosapepantor', 17, 1147551)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (26, 26, N'Cipfropantor', 5, 419300)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (252, 252, N'Qwipebazz', 13, 2580578)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (52, 52, N'Grosapedgex', 14, 1913730)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (194, 194, N'Qwisipommistor', 4, 583876)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (249, 249, N'Qwimunilistor', 15, 2602065)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (66, 66, N'Surwerpupentor', 20, 1812000)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (300, 300, N'Gropebexower', 19, 1615589)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (145, 145, N'Dopcadentor', 18, 3013128)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (196, 196, N'Qwirobepazz', 1, 154253)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (216, 216, N'Klimunan', 14, 1908424)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (243, 243, N'Hapweredgentor', 9, 809892)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (31, 31, N'Endbanommover', 17, 1593988)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (219, 219, N'Cipjubistor', 9, 535104)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (216, 216, N'Klimunan', 5, 681580)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (38, 38, N'Uppeban', 6, 671238)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (272, 272, N'Klisapex', 15, 2231310)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (57, 57, N'Truvenollistor', 12, 448320)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (144, 144, N'Klipickewex', 15, 2046435)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (163, 163, N'Winzapentor', 20, 2400960)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (98, 98, N'Adkilazz', 16, 1612384)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (202, 202, N'Cipvenor', 4, 183000)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (141, 141, N'Cipweristor', 6, 865440)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (251, 251, N'Tupdudazz', 11, 1726648)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (243, 243, N'Hapweredgentor', 15, 1349820)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (239, 239, N'Zeeerilan', 11, 719081)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (230, 230, N'Zeebanicator', 13, 394706)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (282, 282, N'Grohupepazz', 14, 1996834)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (89, 89, N'Tipsapover', 3, 422586)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (157, 157, N'Klidudan', 11, 819918)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (200, 200, N'Groglibadicator', 2, 368624)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (100, 100, N'Frocadollicator', 19, 1195252)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (87, 87, N'Inerinower', 14, 1078378)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (247, 247, N'Rapbanicor', 4, 661856)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (67, 67, N'Unnipepar', 15, 840015)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (57, 57, N'Truvenollistor', 4, 149440)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (21, 21, N'Empebicantor', 13, 425659)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (188, 188, N'Truzapicor', 7, 1187011)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (208, 208, N'Rejubaquax', 19, 889789)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (190, 190, N'Wincadamazz', 18, 889362)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (279, 279, N'Tipzapower', 11, 851279)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (67, 67, N'Unnipepar', 8, 448008)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (279, 279, N'Tipzapower', 17, 1315613)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (20, 20, N'Barwerewicator', 2, 308476)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (271, 271, N'Klisipan', 11, 1539945)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (204, 204, N'Frofropar', 19, 2739230)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (29, 29, N'Windudan', 2, 232330)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (45, 45, N'Klisapicin', 15, 1852620)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (33, 33, N'Barquestistor', 15, 1169775)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (183, 183, N'Unmunex', 12, 2312424)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (286, 286, N'Cipdimar', 18, 3354966)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (148, 148, N'Adsipupan', 19, 915648)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (45, 45, N'Klisapicin', 18, 2223144)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (204, 204, N'Frofropar', 8, 1153360)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (171, 171, N'Unzapefex', 12, 1794168)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (68, 68, N'Unhupower', 14, 1500786)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (186, 186, N'Inhupar', 19, 3080527)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (2, 2, N'Grobanistor', 3, 309504)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (109, 109, N'Partinan', 19, 3000442)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (256, 256, N'Klihupegover', 13, 2512133)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (19, 19, N'Tupericax', 2, 159692)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (85, 85, N'Tupvenilicator', 7, 926240)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (212, 212, N'Upcadilex', 17, 758710)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (288, 288, N'Haperupor', 8, 855040)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (297, 297, N'Sursapopazz', 20, 3797480)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (117, 117, N'Varpebimicator', 16, 1111360)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (157, 157, N'Klidudan', 15, 1118070)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (85, 85, N'Tupvenilicator', 13, 1720160)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (152, 152, N'Rappebanan', 14, 769706)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (160, 160, N'Rapbanicator', 2, 200324)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (18, 18, N'Tipvenar', 13, 410202)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (85, 85, N'Tupvenilicator', 8, 1058560)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (149, 149, N'Qwivenover', 13, 781833)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (254, 254, N'Lomvenilor', 17, 1086640)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (184, 184, N'Inwerpicator', 9, 578124)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (32, 32, N'Dopglibower', 9, 771282)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (223, 223, N'Upmunazz', 8, 1441432)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (121, 121, N'Fronipepower', 4, 174288)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (281, 281, N'Uphupefor', 20, 1788180)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (40, 40, N'Varhupollicator', 17, 2445263)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (210, 210, N'Tupbanonar', 10, 1801280)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (185, 185, N'Groquesticator', 18, 1650906)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (250, 250, N'Klinipentor', 19, 3589784)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (206, 206, N'Dopvenex', 11, 1811931)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (171, 171, N'Unzapefex', 13, 1943682)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (52, 52, N'Grosapedgex', 3, 410085)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (56, 56, N'Tippebaquor', 1, 185096)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (183, 183, N'Unmunex', 7, 1348914)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (76, 76, N'Survenar', 13, 1465295)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (300, 300, N'Gropebexower', 2, 170062)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (171, 171, N'Unzapefex', 5, 747570)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (20, 20, N'Barwerewicator', 11, 1696618)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (80, 80, N'Upkilicex', 8, 559608)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (253, 253, N'Grosipefantor', 7, 1122030)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (171, 171, N'Unzapefex', 16, 2392224)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (194, 194, N'Qwisipommistor', 5, 729845)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (155, 155, N'Qwizapupax', 11, 542685)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (292, 292, N'Bardiman', 9, 992286)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (24, 24, N'Adtinicower', 3, 268998)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (154, 154, N'Advenilax', 16, 1027200)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (47, 47, N'Gropebazz', 4, 472296)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (245, 245, N'Trududax', 10, 1089690)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (193, 193, N'Qwiwerexar', 1, 188317)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (173, 173, N'Adfropinover', 14, 1182916)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (166, 166, N'Tupjubar', 19, 3478615)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (202, 202, N'Cipvenor', 11, 503250)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (299, 299, N'Unrobollover', 7, 969864)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (91, 91, N'Happebedicator', 1, 87718)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (20, 20, N'Barwerewicator', 19, 2930522)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (140, 140, N'Kliwerexazz', 4, 401260)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (145, 145, N'Dopcadentor', 6, 1004376)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (65, 65, N'Partuman', 16, 894784)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (22, 22, N'Qwifropanan', 3, 139845)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (70, 70, N'Tupnipedgantor', 3, 110352)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (46, 46, N'Cipsipazz', 4, 239420)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (135, 135, N'Winhuponantor', 5, 330485)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (136, 136, N'Dopnipadan', 9, 1394190)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (6, 6, N'Adsapilor', 6, 965976)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (117, 117, N'Varpebimicator', 16, 1111360)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (245, 245, N'Trududax', 17, 1852473)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (61, 61, N'Doptuminar', 15, 2856720)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (275, 275, N'Frorobaquazz', 9, 841860)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (9, 9, N'Mondudegower', 20, 3215440)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (153, 153, N'Suppebor', 13, 1607385)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (289, 289, N'Doperupex', 18, 3135060)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (299, 299, N'Unrobollover', 3, 415656)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (6, 6, N'Adsapilor', 1, 160996)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (197, 197, N'Qwipickower', 7, 590212)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (84, 84, N'Recadover', 1, 123800)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (291, 291, N'Rewerpar', 5, 381710)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (177, 177, N'Gropebex', 18, 1912464)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (232, 232, N'Trujubaman', 19, 2213557)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (98, 98, N'Adkilazz', 2, 201548)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (127, 127, N'Unpebopicator', 5, 434700)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (293, 293, N'Qwisiponax', 13, 1819506)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (266, 266, N'Enddudefistor', 1, 53937)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (292, 292, N'Bardiman', 17, 1874318)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (77, 77, N'Varpebor', 5, 331960)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (40, 40, N'Varhupollicator', 12, 1726068)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (270, 270, N'Emkilan', 3, 271752)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (54, 54, N'Wintinax', 17, 665550)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (265, 265, N'Varhupax', 20, 3904720)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (164, 164, N'Incadower', 8, 969384)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (236, 236, N'Upjubex', 9, 1007226)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (155, 155, N'Qwizapupax', 16, 789360)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (106, 106, N'Varwerex', 10, 620040)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (298, 298, N'Qwiwerpupazz', 8, 1446128)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (11, 11, N'Frotumover', 6, 877788)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (208, 208, N'Rejubaquax', 3, 140493)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (37, 37, N'Surbanor', 12, 848268)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (59, 59, N'Lomtinicentor', 16, 1309040)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (149, 149, N'Qwivenover', 5, 300705)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (175, 175, N'Surtinentor', 14, 2164624)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (79, 79, N'Lomglibupistor', 6, 996954)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (94, 94, N'Uprobazz', 1, 101022)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (73, 73, N'Surmunegantor', 15, 1857975)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (236, 236, N'Upjubex', 10, 1119140)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (40, 40, N'Varhupollicator', 9, 1294551)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (184, 184, N'Inwerpicator', 16, 1027776)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (168, 168, N'Thruzapax', 17, 1599581)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (197, 197, N'Qwipickower', 10, 843160)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (103, 103, N'Truericator', 1, 129936)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (7, 7, N'Unwerpantor', 1, 104262)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (30, 30, N'Windimollistor', 15, 1219830)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (264, 264, N'Supfropover', 6, 655332)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (214, 214, N'Rapdimin', 8, 871656)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (268, 268, N'Parsipar', 14, 1985270)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (196, 196, N'Qwirobepazz', 19, 2930807)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (77, 77, N'Varpebor', 10, 663920)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (80, 80, N'Upkilicex', 3, 209853)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (143, 143, N'Adtumommentor', 8, 887344)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (59, 59, N'Lomtinicentor', 4, 327260)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (267, 267, N'Remunommicator', 14, 1453634)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (148, 148, N'Adsipupan', 13, 626496)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (192, 192, N'Qwirobower', 1, 124640)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (96, 96, N'Lombanexicator', 16, 711808)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (111, 111, N'Upbanopar', 2, 297406)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (74, 74, N'Undimex', 11, 1496077)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (299, 299, N'Unrobollover', 17, 2355384)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (184, 184, N'Inwerpicator', 9, 578124)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (1, 1, N'Zeevenax', 15, 475665)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (296, 296, N'Unsipinor', 15, 2395320)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (289, 289, N'Doperupex', 4, 696680)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (48, 48, N'Trudimover', 10, 1851130)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (232, 232, N'Trujubaman', 9, 1048527)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (28, 28, N'Trurobepazz', 13, 594672)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (58, 58, N'Wincadanax', 5, 817510)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (19, 19, N'Tupericax', 17, 1357382)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (34, 34, N'Winquestackor', 5, 290045)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (220, 220, N'Zeewerpinentor', 19, 1618572)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (31, 31, N'Endbanommover', 12, 1125168)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (252, 252, N'Qwipebazz', 8, 1588048)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (193, 193, N'Qwiwerexar', 9, 1694853)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (172, 172, N'Growerpplistor', 16, 644912)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (73, 73, N'Surmunegantor', 13, 1610245)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (252, 252, N'Qwipebazz', 16, 3176096)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (258, 258, N'Cippickonover', 20, 2321360)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (135, 135, N'Winhuponantor', 14, 925358)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (273, 273, N'Raptumommower', 4, 201756)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (241, 241, N'Parwerpentor', 9, 1724832)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (139, 139, N'Zeevenin', 16, 738080)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (103, 103, N'Truericator', 9, 1169424)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (234, 234, N'Upwerpepistor', 16, 757936)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (129, 129, N'Tipcadupex', 20, 3652320)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (195, 195, N'Hapvenollan', 5, 626260)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (300, 300, N'Gropebexower', 13, 1105403)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (183, 183, N'Unmunex', 12, 2312424)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (27, 27, N'Ciprobupentor', 2, 341096)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (188, 188, N'Truzapicor', 5, 847865)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (298, 298, N'Qwiwerpupazz', 5, 903830)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (262, 262, N'Rapnipefex', 14, 867440)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (162, 162, N'Lomwerpazz', 19, 3609753)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (42, 42, N'Cipdudicator', 12, 1440336)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (1, 1, N'Zeevenax', 8, 253688)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (168, 168, N'Thruzapax', 2, 188186)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (202, 202, N'Cipvenor', 16, 732000)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (114, 114, N'Varzapewover', 17, 711688)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (260, 260, N'Dopzapin', 12, 2087904)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (98, 98, N'Adkilazz', 6, 604644)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (236, 236, N'Upjubex', 14, 1566796)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (156, 156, N'Barrobover', 3, 140064)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (249, 249, N'Qwimunilistor', 18, 3122478)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (163, 163, N'Winzapentor', 15, 1800720)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (157, 157, N'Klidudan', 12, 894456)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (49, 49, N'Klifropantor', 12, 2360268)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (191, 191, N'Tipkilopex', 20, 2207420)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (166, 166, N'Tupjubar', 15, 2746275)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (95, 95, N'Emsapepicator', 19, 2914448)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (75, 75, N'Rapwerpax', 1, 81233)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (241, 241, N'Parwerpentor', 5, 958240)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (139, 139, N'Zeevenin', 16, 738080)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (277, 277, N'Gropebentor', 9, 604782)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (102, 102, N'Upkilaquor', 8, 327000)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (58, 58, N'Wincadanax', 9, 1471518)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (46, 46, N'Cipsipazz', 13, 778115)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (199, 199, N'Windimistor', 6, 714648)
GO
INSERT [dbo].[DH_SP] ([MaDonHang], [MaSanPham], [TenSanPham], [SoLuong], [ThanhTien]) VALUES (62, 62, N'Supvenplicator', 20, 1770340)
GO
SET IDENTITY_INSERT [dbo].[Administrator] ON 
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (1, N'Stefanie Alexander', N'E5Z3BSG8            ', CAST(N'1976-03-01' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (2, N'Lee Buckley', N'R10IDAP8            ', CAST(N'1984-08-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (3, N'Daniel Gallagher', N'32CBQWTN            ', CAST(N'1988-03-01' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (4, N'Myra Lucero', N'3OXZ31CU            ', CAST(N'1974-03-03' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (5, N'Annie Brennan', N'QO3199HY            ', CAST(N'1981-10-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (6, N'Jenifer Harvey', N'0HCHNM2W            ', CAST(N'1973-10-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (7, N'Chastity Shea', N'F2F3ANVC            ', CAST(N'1975-04-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (8, N'Jeannie Rich', N'3SXY6JLY            ', CAST(N'1989-11-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (9, N'Bobbie Dalton', N'M1T2TRCS            ', CAST(N'1977-04-28' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (10, N'Shawna Merritt', N'LM1AW7FW            ', CAST(N'1977-12-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (11, N'Tasha Russell', N'9NEF5XQE            ', CAST(N'1980-07-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (12, N'Otis Daniel', N'M1BTWO2F            ', CAST(N'1986-12-31' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (13, N'Peggy Rice', N'SC8NQIHA            ', CAST(N'1984-08-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (14, N'Vicky Nunez', N'HSVPI9RC            ', CAST(N'1970-08-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (15, N'Miranda Sanford', N'57VVCELP            ', CAST(N'1971-09-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (16, N'Rosemary Mckee', N'URPD8GCN            ', CAST(N'1988-12-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (17, N'Lindsay Thomas', N'JLWVYV68            ', CAST(N'1972-08-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (18, N'Tammie Hurley', N'AWI21JDW            ', CAST(N'1987-12-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (19, N'Cesar Peterson', N'YW0T21RN            ', CAST(N'1985-12-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (20, N'Sonja Velasquez', N'04JEDVP8            ', CAST(N'1980-01-01' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (21, N'Stephan Bolton', N'E980O3SA            ', CAST(N'1974-07-12' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (22, N'Earnest O''Connor', N'8SP6ZB8E            ', CAST(N'1982-04-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (23, N'Erin Tanner', N'JPIV4BC6            ', CAST(N'1980-06-23' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (24, N'Carla French', N'3WJNCTSZ            ', CAST(N'1971-09-11' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (25, N'Jean Fletcher', N'ZY7W1R8J            ', CAST(N'1990-11-15' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (26, N'Kirsten Rice', N'SU476Y36            ', CAST(N'1979-07-29' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (27, N'Marie Barry', N'8J5XNIYO            ', CAST(N'1980-10-12' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (28, N'Shaun Hicks', N'9KFWD0O8            ', CAST(N'1981-06-23' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (29, N'Tasha Myers', N'JMNQMLGK            ', CAST(N'1977-11-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (30, N'Heather Hogan', N'ZVPKJ6AK            ', CAST(N'1980-06-10' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (31, N'Theodore Phillips', N'H1AOXCDZ            ', CAST(N'1976-03-10' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (32, N'Phillip Silva', N'FWH4JXIJ            ', CAST(N'1975-02-12' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (33, N'Alejandro Byrd', N'VHWJH36Z            ', CAST(N'1980-07-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (34, N'Chandra Chambers', N'OO09LSK6            ', CAST(N'1971-05-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (35, N'Myron Nixon', N'4VOBDNM1            ', CAST(N'1984-06-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (36, N'Laura Garza', N'UVCS1ZNF            ', CAST(N'1988-10-02' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (37, N'Johnathan Weaver', N'JYK7IYIO            ', CAST(N'1980-10-28' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (38, N'Jamal Benitez', N'Y6BOKCQE            ', CAST(N'1978-12-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (39, N'Clifton Howe', N'UK48WGFB            ', CAST(N'1987-12-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (40, N'Trent Stevens', N'HWM0L5Q0            ', CAST(N'1983-11-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (41, N'Becky Cohen', N'MWCPSODO            ', CAST(N'1986-12-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (42, N'Charlene Hartman', N'C6AZ2NBS            ', CAST(N'1981-07-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (43, N'Summer O''Connor', N'XB24S6V1            ', CAST(N'1987-07-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (44, N'Corey Garcia', N'NXK5YK44            ', CAST(N'1982-11-15' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (45, N'Miriam Fry', N'C4RGV7L2            ', CAST(N'1980-04-07' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (46, N'Marci Frost', N'SIUYPT9S            ', CAST(N'1979-03-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (47, N'Gerard Robinson', N'6I45UQVP            ', CAST(N'1977-07-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (48, N'Kara Carlson', N'A78QVY6Y            ', CAST(N'1980-08-03' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (49, N'Stanley Clarke', N'3HFUIQ12            ', CAST(N'1979-03-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (50, N'Tania Stevens', N'YP8QV5VX            ', CAST(N'1982-12-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (51, N'Abraham Bowen', N'D6A1K6GA            ', CAST(N'1985-12-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (52, N'Jana Cortez', N'X1MWSQ66            ', CAST(N'1971-06-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (53, N'Susana Chambers', N'9BZD4R7X            ', CAST(N'1986-10-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (54, N'Marisa Fox', N'JKB2VXCT            ', CAST(N'1972-01-31' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (55, N'Elisa Saunders', N'C2X9D8V4            ', CAST(N'1986-09-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (56, N'Nakia Herrera', N'W2WHKPUM            ', CAST(N'1984-11-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (57, N'Lloyd Ashley', N'MZ2ITM6X            ', CAST(N'1974-03-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (58, N'Trina Fleming', N'JU6OJYYT            ', CAST(N'1986-06-21' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (59, N'Neal Walter', N'DZYQHZRB            ', CAST(N'1974-04-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (60, N'Casey Kemp', N'210L88BQ            ', CAST(N'1972-03-13' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (61, N'Rebekah Summers', N'PU9A2GIC            ', CAST(N'1984-01-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (62, N'Mitchell Holmes', N'T7IYJQMH            ', CAST(N'1984-10-11' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (63, N'Everett Gonzalez', N'NVI2RIR3            ', CAST(N'1982-01-03' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (64, N'Stacy Wood', N'PXLYDT48            ', CAST(N'1987-11-19' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (65, N'Ted Hudson', N'U2XH84PX            ', CAST(N'1971-10-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (66, N'Sheryl Madden', N'B4I9ZQMN            ', CAST(N'1975-06-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (67, N'Karl Duffy', N'BN2RIZKT            ', CAST(N'1976-06-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (68, N'Vicki Ellis', N'OVUPTARS            ', CAST(N'1983-04-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (69, N'Jeannette Shannon', N'P6NDDUEF            ', CAST(N'1977-02-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (70, N'Chasity Stewart', N'DFYUBQYS            ', CAST(N'1973-12-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (71, N'Tonia Hudson', N'X2JYXEP0            ', CAST(N'1978-02-27' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (72, N'Gregory Weaver', N'9MA7I6CW            ', CAST(N'1984-08-28' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (73, N'Cody O''Neal', N'7Y97C2Z7            ', CAST(N'1990-12-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (74, N'Tamiko Lynch', N'GTJ4Q0PU            ', CAST(N'1972-01-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (75, N'Monica Massey', N'VR98NCT4            ', CAST(N'1984-01-11' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (76, N'Brady Vargas', N'O5XRIF8Q            ', CAST(N'1983-12-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (77, N'Danny Nash', N'BPPGYP09            ', CAST(N'1985-09-21' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (78, N'Latoya Mathis', N'H5V9INHG            ', CAST(N'1988-08-09' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (79, N'Demond Shelton', N'8YAWE89B            ', CAST(N'1982-06-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (80, N'Abigail Underwood', N'GPA4V06D            ', CAST(N'1981-09-14' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (81, N'Sandra Bolton', N'0ETJ7E5B            ', CAST(N'1972-01-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (82, N'Armando Cook', N'XEN9A190            ', CAST(N'1970-03-11' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (83, N'Preston Landry', N'KEAH7MOK            ', CAST(N'1972-03-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (84, N'Antonio Byrd', N'WDAV34IH            ', CAST(N'1985-11-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (85, N'Casey Ali', N'CORVR38B            ', CAST(N'1985-07-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (86, N'Marla Hopkins', N'E6E8UU8L            ', CAST(N'1974-09-13' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (87, N'Jonathon Boyle', N'UI76VMU9            ', CAST(N'1979-04-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (88, N'Emily Durham', N'P2BIQTZX            ', CAST(N'1978-06-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (89, N'Laura Morton', N'0ON79VP9            ', CAST(N'1975-08-19' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (90, N'Gene Wolfe', N'5NIFNH5O            ', CAST(N'1990-08-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (91, N'Zachary Ponce', N'U5T41I4J            ', CAST(N'1984-07-31' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (92, N'Jason Knox', N'LVFL9WJ7            ', CAST(N'1985-05-09' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (93, N'Helen Krueger', N'BM9BGL8P            ', CAST(N'1974-08-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (94, N'Holly Yu', N'F9FTD2U4            ', CAST(N'1985-10-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (95, N'Leon Curry', N'HWN52PM4            ', CAST(N'1990-11-12' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (96, N'Kimberly Hoover', N'YJDLWFKT            ', CAST(N'1972-03-12' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (97, N'Mike Barber', N'PJO7VBWP            ', CAST(N'1990-07-13' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (98, N'Allan Mc Daniel', N'TRIDR441            ', CAST(N'1990-08-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (99, N'Albert Zamora', N'A6JJPC8A            ', CAST(N'1981-01-30' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (100, N'Miranda Fuller', N'7UDZ9JZ4            ', CAST(N'1974-11-02' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (101, N'Desiree Mc Daniel', N'390B8DGT            ', CAST(N'1972-09-30' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (102, N'Alisa Hicks', N'VKR9GV4A            ', CAST(N'1985-04-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (103, N'Misty Duke', N'I5TCZL5P            ', CAST(N'1973-06-13' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (104, N'Amelia Harding', N'VTIYDMJ1            ', CAST(N'1975-04-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (105, N'Wallace Hammond', N'AYY53VYD            ', CAST(N'1974-10-26' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (106, N'Kristie Nichols', N'EYDIVZWH            ', CAST(N'1971-04-11' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (107, N'Carmen Martinez', N'RQAF5JIK            ', CAST(N'1971-07-10' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (108, N'Sheri Curtis', N'UW74PF3U            ', CAST(N'1984-10-02' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (109, N'Tasha Shaw', N'OC2XDMWQ            ', CAST(N'1979-01-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (110, N'Rachelle Mc Bride', N'HDXI2WOS            ', CAST(N'1972-09-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (111, N'Patrick Bautista', N'HUTFMIW3            ', CAST(N'1990-03-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (112, N'Bryant Wise', N'HA9YE1N7            ', CAST(N'1976-07-26' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (113, N'Marco Haas', N'VTCNJES1            ', CAST(N'1974-01-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (114, N'Keith Espinoza', N'1CTBGX4M            ', CAST(N'1983-08-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (115, N'Jim Nguyen', N'I9QJ1A5E            ', CAST(N'1970-02-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (116, N'Angelo Alexander', N'HJYWUURS            ', CAST(N'1983-10-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (117, N'Evan Harding', N'YTBENLBU            ', CAST(N'1982-07-17' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (118, N'Rafael Morgan', N'N6TBTS15            ', CAST(N'1987-02-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (119, N'Grace Church', N'EBR2I4YA            ', CAST(N'1972-05-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (120, N'Malcolm Wilson', N'85HYJOZ5            ', CAST(N'1988-02-03' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (121, N'James Leon', N'O4M487IH            ', CAST(N'1987-02-12' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (122, N'Stephen Duncan', N'M5P6UPVD            ', CAST(N'1988-12-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (123, N'Sam Reid', N'6WB6GC33            ', CAST(N'1977-08-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (124, N'Justin Neal', N'AON5CNZD            ', CAST(N'1977-07-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (125, N'Marianne Phelps', N'C93KK0WB            ', CAST(N'1980-05-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (126, N'Caleb Ryan', N'S1AS267S            ', CAST(N'1983-10-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (127, N'Roderick Vaughn', N'HHO914I7            ', CAST(N'1980-01-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (128, N'Angie Shaw', N'KHT27HNJ            ', CAST(N'1975-03-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (129, N'Mark Zavala', N'CMBAA47B            ', CAST(N'1972-03-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (130, N'Aimee Dixon', N'EILGYJEH            ', CAST(N'1981-11-01' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (131, N'Damian Ellis', N'D28Z1C8B            ', CAST(N'1984-06-16' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (132, N'Kristy Boyd', N'BQUT4J2V            ', CAST(N'1986-01-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (133, N'Monica Clay', N'X76J2Q24            ', CAST(N'1977-07-11' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (134, N'Aaron Goodwin', N'63J9NPKA            ', CAST(N'1977-08-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (135, N'Bethany Foster', N'VDKZ2YAV            ', CAST(N'1978-12-16' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (136, N'Stephanie Rogers', N'8LE2E2DG            ', CAST(N'1977-10-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (137, N'Randal Ross', N'PUZIXXM1            ', CAST(N'1987-09-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (138, N'Janice Nelson', N'B2248T27            ', CAST(N'1987-12-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (139, N'Carlos Logan', N'MY48874T            ', CAST(N'1981-02-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (140, N'Bobbi Patel', N'B4PGW7EU            ', CAST(N'1984-03-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (141, N'Henry Garrison', N'GDFMD1QZ            ', CAST(N'1973-03-07' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (142, N'Krista Jennings', N'J3CKZ6KQ            ', CAST(N'1985-07-23' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (143, N'Jeannie Jacobs', N'6HLSD3EB            ', CAST(N'1990-06-09' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (144, N'Gwendolyn Joseph', N'IU6UQDDM            ', CAST(N'1972-11-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (145, N'April Lane', N'2ZL3I8DL            ', CAST(N'1970-06-03' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (146, N'Lance Pittman', N'5R5IV5P8            ', CAST(N'1978-01-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (147, N'Lisa French', N'UNZC7157            ', CAST(N'1981-04-24' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (148, N'Alissa Soto', N'NODZ6DCI            ', CAST(N'1982-01-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (149, N'Rex Hogan', N'W2ZDFRC9            ', CAST(N'1985-08-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (150, N'Randi Bird', N'Q0Z04H0I            ', CAST(N'1977-01-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (151, N'Jessie Richmond', N'UQSJYB3Q            ', CAST(N'1980-08-26' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (152, N'Jeannie Henry', N'D6KS6DES            ', CAST(N'1973-06-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (153, N'Norman Shelton', N'EH88ZYIE            ', CAST(N'1988-04-16' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (154, N'Nichole Pham', N'5MJVZNFH            ', CAST(N'1983-12-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (155, N'Nicole Shannon', N'YD4N9PUZ            ', CAST(N'1978-09-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (156, N'Heather Hawkins', N'ZYTMMCCL            ', CAST(N'1974-10-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (157, N'Brent Carey', N'PMQT0K3Y            ', CAST(N'1977-08-19' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (158, N'Nick Rodgers', N'DH7WCOLF            ', CAST(N'1986-11-26' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (159, N'Audrey Cameron', N'1Q8JD0WJ            ', CAST(N'1985-11-16' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (160, N'Amelia Villa', N'DJZ7JDMP            ', CAST(N'1982-01-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (161, N'Molly Wells', N'15CKKBLH            ', CAST(N'1982-04-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (162, N'Albert Carrillo', N'V2M407XB            ', CAST(N'1987-05-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (163, N'Jeannie Hart', N'T68QXH5Q            ', CAST(N'1982-07-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (164, N'Marvin Torres', N'35YTANTJ            ', CAST(N'1988-03-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (165, N'Alejandro Sosa', N'2G6WXWI0            ', CAST(N'1979-04-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (166, N'Sidney Snow', N'T9ISA8IS            ', CAST(N'1974-02-12' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (167, N'Vickie Richmond', N'MB7VFTWH            ', CAST(N'1990-01-15' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (168, N'Dominick Dorsey', N'I1RYAHXV            ', CAST(N'1987-06-13' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (169, N'Carey Bright', N'OW8C7W0C            ', CAST(N'1974-08-21' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (170, N'Jeanette Ball', N'VBVQAH47            ', CAST(N'1983-05-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (171, N'Danielle Robinson', N'171CZGK0            ', CAST(N'1987-01-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (172, N'Tommy Rojas', N'PUY1UEDU            ', CAST(N'1985-07-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (173, N'Carmen Aguilar', N'A93BU3C1            ', CAST(N'1976-01-02' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (174, N'Sherrie Boyer', N'GSQ9U38V            ', CAST(N'1979-02-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (175, N'Gena Vincent', N'TCWSS7XB            ', CAST(N'1984-11-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (176, N'Katina Jones', N'JUHGCGLT            ', CAST(N'1971-07-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (177, N'Melissa Barber', N'5QCXZYA3            ', CAST(N'1989-06-29' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (178, N'Kristie Salas', N'8F0USYQK            ', CAST(N'1974-09-18' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (179, N'Darlene Carr', N'ZIHVEJLT            ', CAST(N'1977-02-15' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (180, N'Esmeralda Parrish', N'O0GAO053            ', CAST(N'1972-05-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (181, N'Levi Chase', N'BVCYHO0O            ', CAST(N'1972-06-29' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (182, N'Angelo Mckinney', N'HO1JPRYL            ', CAST(N'1988-12-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (183, N'Marcie Pena', N'G9CTC6RM            ', CAST(N'1980-07-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (184, N'Kristy Munoz', N'QXRZPPTF            ', CAST(N'1986-02-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (185, N'Kerrie Stark', N'510TVPO4            ', CAST(N'1971-03-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (186, N'Andrew Duarte', N'55AOB2PP            ', CAST(N'1981-01-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (187, N'Cody West', N'SIJ56VK9            ', CAST(N'1988-10-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (188, N'Adrienne Mc Donald', N'3HZBPA2S            ', CAST(N'1984-07-14' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (189, N'Audrey Baird', N'BMEN571L            ', CAST(N'1989-11-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (190, N'Chad Glover', N'S2LPAZV0            ', CAST(N'1974-02-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (191, N'Frances Bowman', N'60U48MYK            ', CAST(N'1970-03-03' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (192, N'Gerard Tyler', N'6UFZMJHE            ', CAST(N'1970-11-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (193, N'Noel Parsons', N'F5CB4LFR            ', CAST(N'1972-02-04' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (194, N'Demond Dickson', N'5E7ZFPDV            ', CAST(N'1990-01-31' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (195, N'Ruby Hardin', N'Q6EROKLU            ', CAST(N'1971-12-24' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (196, N'Melinda Stafford', N'1SF27WWF            ', CAST(N'1976-10-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (197, N'Forrest Frye', N'KVV9PGET            ', CAST(N'1972-12-26' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (198, N'Edith Braun', N'F6EPMRRR            ', CAST(N'1972-03-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (199, N'Lesley Frederick', N'NNGSQ9TD            ', CAST(N'1984-08-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (200, N'Kimberley Galloway', N'R26A2ZVT            ', CAST(N'1987-04-21' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (201, N'Demetrius George', N'WHHYCVD5            ', CAST(N'1978-12-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (202, N'Marla Lane', N'DC6OBGO9            ', CAST(N'1984-11-11' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (203, N'Frankie Newman', N'DR4MFCHN            ', CAST(N'1977-05-31' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (204, N'Kathy Levy', N'044ETSQV            ', CAST(N'1972-04-26' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (205, N'Kendall Ibarra', N'QPALEKLG            ', CAST(N'1980-12-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (206, N'Daniel Atkins', N'S3RQMT7I            ', CAST(N'1986-01-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (207, N'Jami Bolton', N'V915HP5D            ', CAST(N'1988-06-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (208, N'Bradford Hunter', N'KYIEXG5Y            ', CAST(N'1979-02-26' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (209, N'Marlene Hooper', N'HSCK1YAO            ', CAST(N'1990-01-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (210, N'Vernon Noble', N'YAIA6BQU            ', CAST(N'1977-02-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (211, N'Shelly Ferrell', N'8L8LF1I0            ', CAST(N'1976-04-27' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (212, N'Anitra Yang', N'IE5BKNAQ            ', CAST(N'1972-12-02' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (213, N'Mathew Howe', N'PB83US66            ', CAST(N'1979-10-12' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (214, N'Andrew Wheeler', N'J9S6N3UX            ', CAST(N'1983-07-02' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (215, N'Lisa Williamson', N'BWCB10HS            ', CAST(N'1979-07-09' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (216, N'Grace Hart', N'ENPU0FL0            ', CAST(N'1984-04-15' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (217, N'Cornelius Burton', N'C5QFE8YZ            ', CAST(N'1976-11-02' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (218, N'Paige Morton', N'PBQ2GMAY            ', CAST(N'1987-06-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (219, N'Kurt Estes', N'DE98L2HS            ', CAST(N'1987-01-15' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (220, N'Gary Gregory', N'DO9CLMKI            ', CAST(N'1989-03-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (221, N'Ramon Randolph', N'MVH3C19S            ', CAST(N'1976-05-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (222, N'Melisa Gill', N'KB62K1L7            ', CAST(N'1975-07-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (223, N'Charity Charles', N'93JOYMOK            ', CAST(N'1988-07-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (224, N'Daniel Carson', N'HCQ3HYUN            ', CAST(N'1970-06-30' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (225, N'Elijah Randolph', N'D918ZTLX            ', CAST(N'1983-03-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (226, N'Nora O''Neal', N'DA37RE0B            ', CAST(N'1986-03-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (227, N'Yolanda Cummings', N'9YXUFSQR            ', CAST(N'1983-06-24' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (228, N'Jordan Norris', N'QGU88XY7            ', CAST(N'1976-12-02' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (229, N'Alejandro Wood', N'L04P216B            ', CAST(N'1977-02-26' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (230, N'Julie Le', N'7AKC36JL            ', CAST(N'1978-01-30' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (231, N'Sergio Jacobson', N'6JU9I8DV            ', CAST(N'1989-07-28' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (232, N'Bryon Dickson', N'L5269KGF            ', CAST(N'1987-04-11' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (233, N'Alfred Harrington', N'AJVWO3II            ', CAST(N'1981-01-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (234, N'Kim Mcintosh', N'VEDNOM8S            ', CAST(N'1980-10-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (235, N'Ramiro O''Connor', N'3BIVB6KK            ', CAST(N'1984-05-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (236, N'Preston Berg', N'6100VNW9            ', CAST(N'1978-08-18' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (237, N'Omar Parsons', N'T9URQZQI            ', CAST(N'1981-07-22' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (238, N'Sherry Ayers', N'3YHFYGVC            ', CAST(N'1978-03-13' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (239, N'Milton Valenzuela', N'RE8OB3XB            ', CAST(N'1975-03-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (240, N'Hugh Odom', N'GVIPRFLE            ', CAST(N'1976-02-07' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (241, N'Karin Good', N'TCLJ4TPH            ', CAST(N'1983-08-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (242, N'Ann Acosta', N'OQ3K4JK4            ', CAST(N'1979-08-14' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (243, N'Kerri Potts', N'S5YRTEJA            ', CAST(N'1985-06-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (244, N'Timothy Garner', N'ZD62UJY2            ', CAST(N'1982-09-19' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (245, N'Roger Landry', N'I89FZUH8            ', CAST(N'1988-10-27' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (246, N'Levi Bullock', N'CWRZ5MKS            ', CAST(N'1988-04-01' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (247, N'Sally Mayo', N'K2I6ZU6P            ', CAST(N'1982-01-23' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (248, N'Jeff Rush', N'FMWJL1I2            ', CAST(N'1979-08-05' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (249, N'Yvette Herring', N'LD549KT6            ', CAST(N'1980-07-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (250, N'Elizabeth O''Neill', N'V08JH1AE            ', CAST(N'1978-09-09' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (251, N'Yvonne Richmond', N'HB8F99Q1            ', CAST(N'1990-12-29' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (252, N'Glenda Cameron', N'OSAPG2PZ            ', CAST(N'1976-07-21' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (253, N'Wanda David', N'3FSYCTGB            ', CAST(N'1976-03-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (254, N'Bobby Franco', N'VV5V9710            ', CAST(N'1986-05-29' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (255, N'Kevin Carson', N'O64VE7Y5            ', CAST(N'1980-12-16' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (256, N'Fred Hardy', N'35J5UIM7            ', CAST(N'1973-06-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (257, N'Regina Berger', N'7JZFYXKU            ', CAST(N'1987-04-17' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (258, N'Arturo Richmond', N'GTJ2NGC1            ', CAST(N'1976-12-01' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (259, N'Kimberly Miles', N'A81KZ6FC            ', CAST(N'1980-02-23' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (260, N'Johanna Sutton', N'5P1M819U            ', CAST(N'1985-09-24' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (261, N'Mindy Saunders', N'R976AJ1H            ', CAST(N'1972-08-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (262, N'Rita Taylor', N'T0H2TSPC            ', CAST(N'1981-07-06' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (263, N'Oliver O''Neill', N'WMJSZMSE            ', CAST(N'1971-12-31' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (264, N'Brock Kane', N'4UKHTTZK            ', CAST(N'1981-12-31' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (265, N'Trent Potter', N'L3XIJHUL            ', CAST(N'1978-08-03' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (266, N'Lamar Doyle', N'O2W9WW2D            ', CAST(N'1980-01-17' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (267, N'Dennis Henson', N'WZ9LEWFX            ', CAST(N'1982-11-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (268, N'Bridget Franklin', N'RB7O38Z4            ', CAST(N'1989-12-15' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (269, N'Matthew Beasley', N'1E32XDA4            ', CAST(N'1990-02-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (270, N'Katherine Gay', N'8VXOFGL2            ', CAST(N'1970-11-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (271, N'Aisha Nash', N'J0P13LU2            ', CAST(N'1972-09-25' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (272, N'Lawrence Bowen', N'40ZN9SO0            ', CAST(N'1989-08-22' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (273, N'Wendi Evans', N'4U1VBAK6            ', CAST(N'1982-04-06' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (274, N'Ronald Mc Bride', N'Q3WR20NG            ', CAST(N'1980-12-08' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (275, N'Angelica Shields', N'I0BH7V35            ', CAST(N'1975-08-26' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (276, N'Stacie Velez', N'CKL4ZEHG            ', CAST(N'1987-09-24' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (277, N'Noah Travis', N'JNPFGWJ4            ', CAST(N'1981-01-18' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (278, N'Mike Craig', N'DCXZ0SP5            ', CAST(N'1975-11-09' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (279, N'Felipe Zamora', N'NNN6S568            ', CAST(N'1972-09-02' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (280, N'Roland Mayer', N'GL3IAMS3            ', CAST(N'1985-12-03' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (281, N'Dora Hammond', N'E3KEX3VP            ', CAST(N'1974-03-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (282, N'Julian Valenzuela', N'6DKTFUET            ', CAST(N'1973-11-20' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (283, N'Kurt Villanueva', N'LDVK98A3            ', CAST(N'1987-05-10' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (284, N'Katherine Coleman', N'VV2B6WZA            ', CAST(N'1989-06-20' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (285, N'Damon Hernandez', N'F8QJA2CZ            ', CAST(N'1978-02-01' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (286, N'Floyd Mora', N'1N693GT7            ', CAST(N'1983-01-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (287, N'Lashonda Shaw', N'XUUB4TK0            ', CAST(N'1981-02-05' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (288, N'Jeremy Mcclain', N'QV6NT4RY            ', CAST(N'1985-08-29' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (289, N'Harvey Solis', N'212S79D8            ', CAST(N'1990-11-12' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (290, N'Antoine Villegas', N'CMSMIZ51            ', CAST(N'1980-12-08' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (291, N'Demond Whitney', N'844WZA8L            ', CAST(N'1982-05-04' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (292, N'Janelle Mc Daniel', N'ODT1H4VQ            ', CAST(N'1974-08-21' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (293, N'Felipe Taylor', N'O5MKXVC7            ', CAST(N'1989-01-18' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (294, N'Tom Kramer', N'13D7HROJ            ', CAST(N'1980-06-10' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (295, N'Garry Schmitt', N'G51SJL5O            ', CAST(N'1973-07-01' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (296, N'Jane Mckenzie', N'MA4NQRTH            ', CAST(N'1972-01-30' AS Date), N'KHOA      ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (297, N'Diana Burns', N'TN69JRV6            ', CAST(N'1977-08-14' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (298, N'Tyrone Lowe', N'QHV2DXAF            ', CAST(N'1973-06-16' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (299, N'Desiree Massey', N'4VL0E90P            ', CAST(N'1974-02-17' AS Date), N'MO        ')
GO
INSERT [dbo].[Administrator] ([UserID], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (300, N'Bridgette Walker', N'9ECLD0VU            ', CAST(N'1978-10-12' AS Date), N'KHOA      ')
GO
SET IDENTITY_INSERT [dbo].[Administrator] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN] ON 
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (1, N'Keri Michael', N'39IO9A8P            ', CAST(N'1975-01-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (2, N'Lena Beck', N'2NLFJCA9            ', CAST(N'1981-02-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (3, N'Marianne Garner', N'2K4TKRRU            ', CAST(N'1990-08-05' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (4, N'Manuel Sloan', N'U78TAFTV            ', CAST(N'1986-07-27' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (5, N'Marcus Rowe', N'KKJ07AJ2            ', CAST(N'1977-02-08' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (6, N'Garry Frye', N'3TN7DROT            ', CAST(N'1977-06-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (7, N'Lindsey Cherry', N'C9PRWFIE            ', CAST(N'1986-09-09' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (8, N'Darrin Stout', N'L9C6MOTP            ', CAST(N'1986-12-07' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (9, N'Allison Hutchinson', N'Y2CUAH0N            ', CAST(N'1988-05-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (10, N'Andrew Wu', N'3MTG4HJG            ', CAST(N'1978-01-09' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (11, N'Kirk Rasmussen', N'TTO3HSRY            ', CAST(N'1987-10-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (12, N'Roberto Wheeler', N'FX7YDO2P            ', CAST(N'1981-10-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (13, N'Clifford Marshall', N'IHZ7R9EF            ', CAST(N'1979-09-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (14, N'Hope Castillo', N'P44VN520            ', CAST(N'1990-05-20' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (15, N'Sammy Doyle', N'0ULK2BOK            ', CAST(N'1979-01-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (16, N'Cecilia Serrano', N'T484EFP0            ', CAST(N'1990-08-31' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (17, N'Bridgett Doyle', N'MM2EP202            ', CAST(N'1986-04-12' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (18, N'Jermaine Arroyo', N'PJ91WDT1            ', CAST(N'1989-03-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (19, N'Kelley Booker', N'6YFNJ6IK            ', CAST(N'1983-04-22' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (20, N'Staci Ewing', N'KKPO5M6G            ', CAST(N'1982-05-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (21, N'Darrick Spence', N'SL5JJZIY            ', CAST(N'1986-01-21' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (22, N'Ernest Malone', N'GS8UBCKJ            ', CAST(N'1981-02-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (23, N'Tyler Rivers', N'JY2WW4RG            ', CAST(N'1990-10-22' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (24, N'Jared Mays', N'40ENUFZ0            ', CAST(N'1989-10-02' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (25, N'Tyler Myers', N'PNEF5K42            ', CAST(N'1988-09-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (26, N'Amy Craig', N'1P8D4LKM            ', CAST(N'1981-07-30' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (27, N'Teddy Boyer', N'BVP0R3HE            ', CAST(N'1986-04-29' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (28, N'Tom Reed', N'MTXSVAWU            ', CAST(N'1980-12-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (29, N'Cari Fletcher', N'M4SHRUCP            ', CAST(N'1976-10-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (30, N'Jerome Patterson', N'9QVS28XN            ', CAST(N'1975-01-18' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (31, N'Dallas Kemp', N'QPVBXRNI            ', CAST(N'1984-07-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (32, N'Kelli Hart', N'U9UYGAPY            ', CAST(N'1976-02-27' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (33, N'Curtis Reilly', N'PT3VO1C8            ', CAST(N'1986-04-01' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (34, N'Xavier Roth', N'2URPU756            ', CAST(N'1982-01-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (35, N'Sidney Lopez', N'0B71U9LI            ', CAST(N'1977-08-01' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (36, N'Donna Hays', N'WBAL24Q8            ', CAST(N'1989-09-08' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (37, N'Jeanne Solis', N'1U0UYO4L            ', CAST(N'1980-08-24' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (38, N'Gavin Lang', N'G4EMSA5P            ', CAST(N'1979-03-22' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (39, N'Sandra Wheeler', N'AOZT96KF            ', CAST(N'1987-01-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (40, N'Julio Noble', N'CGRNZMD4            ', CAST(N'1976-08-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (41, N'Myra Daniels', N'46CIW9L4            ', CAST(N'1987-05-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (42, N'Tyrone Mc Cormick', N'2AI0FDHF            ', CAST(N'1982-09-19' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (43, N'Johanna Rivas', N'U7LU9IRR            ', CAST(N'1988-10-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (44, N'Omar Lucas', N'WT4R8OY1            ', CAST(N'1985-06-09' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (45, N'Noah Yang', N'9RRQ84SI            ', CAST(N'1984-09-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (46, N'Todd Miles', N'EC1D5J3J            ', CAST(N'1985-03-23' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (47, N'Kristian Chambers', N'Q9XUR55P            ', CAST(N'1982-03-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (48, N'Angel Colon', N'8A1U1EU7            ', CAST(N'1988-06-05' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (49, N'Gregory Olsen', N'R4ZG2QCC            ', CAST(N'1986-12-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (50, N'Eddie Buckley', N'3INLNPS8            ', CAST(N'1980-08-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (51, N'Latisha Gilbert', N'LF0MKJTJ            ', CAST(N'1982-12-31' AS Date), NULL)
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (52, N'Juan Weiss', N'4KBMJXVB            ', CAST(N'1978-05-06' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (53, N'Jesse Lambert', N'X976HEQ2            ', CAST(N'1981-05-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (54, N'Lakeisha Mejia', N'NNNB2SN8            ', CAST(N'1975-06-25' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (55, N'Ginger Fernandez', N'N4JGMJI8            ', CAST(N'1976-03-25' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (56, N'Adrian Bray', N'2GZQQBAV            ', CAST(N'1984-11-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (57, N'Jeannie Finley', N'KFYMWIC6            ', CAST(N'1981-04-26' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (58, N'Caroline Obrien', N'KSIJZA57            ', CAST(N'1975-11-03' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (59, N'Ruth Yoder', N'VGNON8LN            ', CAST(N'1988-11-10' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (60, N'Francis Adams', N'7WXB17T3            ', CAST(N'1986-07-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (61, N'Dianna Mac Donald', N'U1803FNY            ', CAST(N'1982-02-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (62, N'Grant Cook', N'AJHPKI4E            ', CAST(N'1980-09-10' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (63, N'Tracy Orozco', N'BVRP08W5            ', CAST(N'1985-02-19' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (64, N'Glenda Baird', N'Y9RBQWGB            ', CAST(N'1988-04-29' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (65, N'Teddy Bonilla', N'YUC70PTB            ', CAST(N'1984-06-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (66, N'Ronda Wiley', N'4ICE6MSH            ', CAST(N'1986-08-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (67, N'Shana Montes', N'241Z3Y6P            ', CAST(N'1986-07-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (68, N'Kendrick Alexander', N'OZTL89C5            ', CAST(N'1988-08-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (69, N'Kristen Edwards', N'14U1WO4S            ', CAST(N'1987-10-19' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (70, N'Clarissa Hahn', N'XJ35I8OE            ', CAST(N'1980-05-03' AS Date), NULL)
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (71, N'Jamie Hunter', N'4ZQE1B14            ', CAST(N'1985-01-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (72, N'Darren Carson', N'AJ92102R            ', CAST(N'1982-01-21' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (73, N'Connie Weeks', N'C08CVBB8            ', CAST(N'1977-03-13' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (74, N'Marc Walton', N'LIHKWU38            ', CAST(N'1981-08-24' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (75, N'Elena Fleming', N'TN3J0RCT            ', CAST(N'1985-12-18' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (76, N'Bernard Green', N'DUH23QVC            ', CAST(N'1978-05-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (77, N'Benny Michael', N'XR3F2T5F            ', CAST(N'1983-05-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (78, N'Willie Guzman', N'VQNFZTT8            ', CAST(N'1980-05-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (79, N'Kisha Hopkins', N'ATZH012Y            ', CAST(N'1980-01-22' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (80, N'Michele Klein', N'OIFQPJF5            ', CAST(N'1978-06-26' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (81, N'Nicholas Mendoza', N'2DL9DK5H            ', CAST(N'1990-05-12' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (82, N'Megan Bowman', N'LYVO8UML            ', CAST(N'1988-11-24' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (83, N'Clarissa Franklin', N'FGR2D3FH            ', CAST(N'1985-01-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (84, N'Ramon Mcfarland', N'6403ZUBR            ', CAST(N'1987-03-18' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (85, N'Beth Pitts', N'I0FECJYG            ', CAST(N'1983-01-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (86, N'Roy Morgan', N'I0AL4300            ', CAST(N'1981-03-27' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (87, N'Tisha Dean', N'P00HUWNY            ', CAST(N'1985-10-16' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (88, N'Darlene Clark', N'2IY0CHZ3            ', CAST(N'1985-10-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (89, N'Joan Newman', N'30384X2X            ', CAST(N'1980-11-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (90, N'Angel Larsen', N'ML0W2Y5M            ', CAST(N'1983-09-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (91, N'Joyce Pena', N'V15JQD6V            ', CAST(N'1983-05-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (92, N'David Hancock', N'1HOSM0IX            ', CAST(N'1979-10-22' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (93, N'Amelia Strong', N'LHW3EWF1            ', CAST(N'1981-05-12' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (94, N'Sheila Atkinson', N'B5GZVPQ3            ', CAST(N'1975-07-06' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (95, N'Nicolas Kane', N'FKAQ18Z0            ', CAST(N'1985-07-25' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (96, N'Marcella Holloway', N'STY0E5YK            ', CAST(N'1981-09-06' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (97, N'Meghan Cooper', N'USM83PZV            ', CAST(N'1988-07-31' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (98, N'Joe Zimmerman', N'H2LY2IY2            ', CAST(N'1975-06-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (99, N'Roberto Potts', N'PUFN3DGN            ', CAST(N'1975-12-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (100, N'Brent May', N'EBRA1ALW            ', CAST(N'1989-01-27' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (101, N'Matthew Richmond', N'F6GLQ6JH            ', CAST(N'1989-09-20' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (102, N'Brock Proctor', N'UURG1BS9            ', CAST(N'1984-08-02' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (103, N'Richard Moran', N'O6O8RGHK            ', CAST(N'1975-08-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (104, N'Nakia Elliott', N'X61BD66I            ', CAST(N'1981-08-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (105, N'Leah Massey', N'V4494LEM            ', CAST(N'1986-07-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (106, N'Leon Palmer', N'GY9FHSLW            ', CAST(N'1975-12-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (107, N'Alison Shields', N'N7E035LL            ', CAST(N'1976-02-23' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (108, N'Brandy Cohen', N'XJGL9JFX            ', CAST(N'1990-09-20' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (109, N'Tim Rivers', N'LE22T5M1            ', CAST(N'1980-07-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (110, N'Daphne Roach', N'BIP9QGGJ            ', CAST(N'1988-11-22' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (111, N'Francisco Hendrix', N'HU1YOIAH            ', CAST(N'1976-07-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (112, N'Karl Thornton', N'CUOQ0KNZ            ', CAST(N'1975-12-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (113, N'Helen Rosario', N'MKD9E1JA            ', CAST(N'1986-10-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (114, N'Adriana Garza', N'LOT04Q7Y            ', CAST(N'1985-05-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (115, N'Alyssa Hudson', N'3NQKSC1A            ', CAST(N'1987-03-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (116, N'Caleb Ellison', N'XLH5LQZT            ', CAST(N'1984-03-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (117, N'Kendall Curtis', N'X7GZEEFO            ', CAST(N'1986-08-23' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (118, N'Karen Porter', N'ACPYI1HK            ', CAST(N'1988-12-05' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (119, N'Meghan Norman', N'Q2R174UM            ', CAST(N'1980-04-12' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (120, N'Angelica Bryant', N'LG320BQ9            ', CAST(N'1978-03-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (121, N'Elijah Garcia', N'M38C53JR            ', CAST(N'1975-10-31' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (122, N'Jordan Gaines', N'HZ2FN1E8            ', CAST(N'1975-09-27' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (123, N'Tammie Cervantes', N'7W0B4SPT            ', CAST(N'1982-10-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (124, N'Tricia Jacobs', N'P8BE78BU            ', CAST(N'1979-02-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (125, N'Alberto Coffey', N'3EXOHG6D            ', CAST(N'1987-12-20' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (126, N'Abel Schaefer', N'M5T1NSJJ            ', CAST(N'1980-03-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (127, N'Jason Adkins', N'QAYFNBVU            ', CAST(N'1975-09-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (128, N'Jeanne Sandoval', N'L2RU4SKB            ', CAST(N'1976-09-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (129, N'Geoffrey James', N'UJFJ5R52            ', CAST(N'1987-01-31' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (130, N'Sharon Torres', N'FNKJUOVK            ', CAST(N'1979-04-13' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (131, N'Harvey Hoover', N'HNRLTNXK            ', CAST(N'1980-10-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (132, N'Otis Ramirez', N'VS10HCYP            ', CAST(N'1982-11-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (133, N'Joshua Church', N'X657AKOG            ', CAST(N'1979-05-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (134, N'Tia Osborne', N'Y273YJ82            ', CAST(N'1981-12-26' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (135, N'Antoine Payne', N'38QRMKGA            ', CAST(N'1979-10-07' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (136, N'Andrew Beck', N'ME68L4OY            ', CAST(N'1980-10-09' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (137, N'Dewayne Andrade', N'E9D6XDGY            ', CAST(N'1988-04-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (138, N'Jonathon Harris', N'3RTHSENV            ', CAST(N'1978-06-09' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (139, N'Willie Pruitt', N'A5JLRZ91            ', CAST(N'1975-08-21' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (140, N'Celeste Mack', N'0QH2F05T            ', CAST(N'1982-02-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (141, N'Charlene Frey', N'BWBCAO2D            ', CAST(N'1980-02-03' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (142, N'Aaron Snyder', N'H5MRKPNE            ', CAST(N'1986-01-27' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (143, N'Leigh Dickerson', N'TTIDWVBG            ', CAST(N'1980-04-02' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (144, N'Jocelyn Lowery', N'00CTBYLC            ', CAST(N'1982-12-14' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (145, N'Carlton Flores', N'5XVVJEGS            ', CAST(N'1982-02-06' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (146, N'Clyde Ho', N'F85RE17B            ', CAST(N'1982-06-02' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (147, N'Jeff Ibarra', N'AXZF1UF1            ', CAST(N'1984-01-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (148, N'Helen Duran', N'6NTN67RH            ', CAST(N'1986-12-26' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (149, N'Bonnie Nunez', N'XY94W4ZW            ', CAST(N'1979-05-05' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (150, N'Tabatha Simmons', N'28LBLZYA            ', CAST(N'1976-05-13' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (151, N'Randal Warner', N'ZQV1FH1A            ', CAST(N'1986-01-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (152, N'Edward Poole', N'3R1X0XKA            ', CAST(N'1990-08-26' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (153, N'Brock Estrada', N'Q60VG5LD            ', CAST(N'1986-03-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (154, N'Leigh Barber', N'RV1UPWSS            ', CAST(N'1988-10-15' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (155, N'Jimmy Willis', N'LWIS2MZW            ', CAST(N'1988-03-30' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (156, N'Bennie Wilkerson', N'758OQBL7            ', CAST(N'1988-12-24' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (157, N'Ben Shepherd', N'E39QF2PA            ', CAST(N'1976-10-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (158, N'Audrey Arnold', N'3925485Z            ', CAST(N'1987-07-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (159, N'Gerald Martin', N'UY3DWK0E            ', CAST(N'1984-08-23' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (160, N'Erin Sweeney', N'K24Q8HRE            ', CAST(N'1981-05-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (161, N'Terence Harvey', N'HUGG2S7V            ', CAST(N'1975-03-31' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (162, N'Dallas Harper', N'110ZJRWQ            ', CAST(N'1990-06-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (163, N'Sonya Snow', N'007PP1U4            ', CAST(N'1978-08-21' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (164, N'Kerri Ballard', N'AD0KDQKN            ', CAST(N'1976-03-27' AS Date), NULL)
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (165, N'Orlando Chambers', N'YEVB60XZ            ', CAST(N'1983-02-19' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (166, N'Carlos Rios', N'7KJDTH8Q            ', CAST(N'1984-09-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (167, N'Guy Hanson', N'GS4FLYKW            ', CAST(N'1987-07-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (168, N'Lindsey Berger', N'MHN9FVMY            ', CAST(N'1979-10-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (169, N'Everett Haas', N'DPU7RQON            ', CAST(N'1980-08-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (170, N'Ernest Craig', N'NXJJCND3            ', CAST(N'1981-05-24' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (171, N'Vicki Neal', N'0ITXQ9IB            ', CAST(N'1986-12-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (172, N'Dwayne Duffy', N'PY5OQU5U            ', CAST(N'1983-03-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (173, N'Rafael Ward', N'J80EQYDW            ', CAST(N'1988-04-16' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (174, N'Quentin Shea', N'Y250WB0M            ', CAST(N'1989-03-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (175, N'Rodolfo Frost', N'IGYKPG8Z            ', CAST(N'1989-02-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (176, N'Erich Potts', N'FZ6PEHLU            ', CAST(N'1980-10-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (177, N'Stanley Andersen', N'UMRVJTAJ            ', CAST(N'1986-06-26' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (178, N'Rhonda Newman', N'CO2TN4EM            ', CAST(N'1990-10-31' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (179, N'Clay Meadows', N'2YJK5R9Y            ', CAST(N'1988-01-09' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (180, N'Jennie Gentry', N'S9NOE1G6            ', CAST(N'1980-07-19' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (181, N'Roxanne Patterson', N'ONX4A56W            ', CAST(N'1987-03-09' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (182, N'Jamey Baldwin', N'MLC1AS3J            ', CAST(N'1979-09-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (183, N'Samantha Goodman', N'B9G0LKXH            ', CAST(N'1988-05-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (184, N'Hector Cobb', N'MO90DG4Q            ', CAST(N'1985-09-19' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (185, N'Colleen May', N'HXOED8GM            ', CAST(N'1984-03-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (186, N'Jimmie Simmons', N'KRYULV65            ', CAST(N'1981-02-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (187, N'Peter Owens', N'JN1C7SUK            ', CAST(N'1987-09-19' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (188, N'Colleen Tapia', N'1M8VWJTL            ', CAST(N'1981-08-02' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (189, N'Dewayne Allison', N'6WV7JZ7C            ', CAST(N'1984-09-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (190, N'Kendrick Bowen', N'BR3ET7JL            ', CAST(N'1981-10-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (191, N'Bret Mayer', N'X4PVJT0F            ', CAST(N'1978-12-20' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (192, N'Erik Petty', N'4OUF1Z90            ', CAST(N'1975-10-07' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (193, N'Latisha Padilla', N'2B324U2I            ', CAST(N'1984-10-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (194, N'Beverly Franklin', N'4MT0CBGV            ', CAST(N'1985-04-12' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (195, N'Katrina Russo', N'VAC274Z2            ', CAST(N'1981-11-10' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (196, N'Melody Bates', N'VWP44TYH            ', CAST(N'1980-08-18' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (197, N'Leslie Kaiser', N'ZVZUT10W            ', CAST(N'1982-06-08' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (198, N'Diane Levy', N'54CIZ5ID            ', CAST(N'1979-01-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (199, N'Blake Conway', N'WZ4Z2266            ', CAST(N'1990-10-25' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (200, N'Melody Rollins', N'30I01U1G            ', CAST(N'1988-06-01' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (201, N'Lorie Richard', N'H1HB2ABU            ', CAST(N'1985-11-03' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (202, N'Pedro Mc Gee', N'BDXKMQ42            ', CAST(N'1979-03-26' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (203, N'Javier Douglas', N'5ZTXONEW            ', CAST(N'1981-05-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (204, N'Forrest Moon', N'A52HHI40            ', CAST(N'1988-12-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (205, N'Serena Cruz', N'8KXTN83U            ', CAST(N'1980-06-09' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (206, N'Bill Lyons', N'PJERWYDW            ', CAST(N'1977-10-31' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (207, N'Hannah Buck', N'7JCUX5F1            ', CAST(N'1977-05-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (208, N'Penny Lam', N'VUVEFLEV            ', CAST(N'1987-12-31' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (209, N'Ian Durham', N'JBBLTTTP            ', CAST(N'1990-09-02' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (210, N'Suzanne Barry', N'HI934L1X            ', CAST(N'1982-06-26' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (211, N'Trina Gilbert', N'ZDNSEMJ8            ', CAST(N'1977-07-01' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (212, N'Tommy Galloway', N'XA3SD0GU            ', CAST(N'1976-12-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (213, N'Cecil Ali', N'5MPJ07RY            ', CAST(N'1990-06-25' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (214, N'Chanda Mc Daniel', N'ESQADI3E            ', CAST(N'1979-02-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (215, N'Katrina Roach', N'VQXP1LSW            ', CAST(N'1985-03-05' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (216, N'Latoya Barton', N'9O49NA0W            ', CAST(N'1986-07-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (217, N'Brandie Hester', N'SGDF0F35            ', CAST(N'1977-02-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (218, N'Daryl Stewart', N'AMWLPZIK            ', CAST(N'1983-12-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (219, N'Kyle Todd', N'MFL3R4SI            ', CAST(N'1982-12-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (220, N'Albert Cline', N'E44FAH7B            ', CAST(N'1977-01-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (221, N'Jennifer Khan', N'4GQHLV5H            ', CAST(N'1987-12-21' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (222, N'Allan Williamson', N'IOY5R27E            ', CAST(N'1980-12-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (223, N'Amanda Ingram', N'POO9MI6P            ', CAST(N'1986-01-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (224, N'Marco Gutierrez', N'BUCFED1D            ', CAST(N'1989-10-30' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (225, N'Marsha Russell', N'C4UPX9UA            ', CAST(N'1977-06-04' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (226, N'Terry Rowland', N'A8D28V1I            ', CAST(N'1986-02-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (227, N'Kathleen Ortiz', N'9VT8BWVU            ', CAST(N'1989-05-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (228, N'Darcy Padilla', N'X3AL4DYU            ', CAST(N'1978-01-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (229, N'Marco Carrillo', N'MZQFEBOV            ', CAST(N'1982-04-25' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (230, N'Kathy Kerr', N'N9LGEWQR            ', CAST(N'1983-06-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (231, N'Carl Johnston', N'A4SXT3MX            ', CAST(N'1989-04-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (232, N'Harold Walter', N'JP4Z4EME            ', CAST(N'1982-06-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (233, N'Kristy Gilmore', N'XUGHJGF8            ', CAST(N'1975-01-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (234, N'Natasha Haas', N'1GOEVCVN            ', CAST(N'1990-08-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (235, N'Ramona Edwards', N'GO5NSH45            ', CAST(N'1985-09-16' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (236, N'Kristine Friedman', N'CN47UZDT            ', CAST(N'1982-12-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (237, N'Angelo Mc Mahon', N'1SLCILHL            ', CAST(N'1989-05-03' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (238, N'Judy Schwartz', N'I4US3GO5            ', CAST(N'1990-05-26' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (239, N'Kate Montes', N'C91ZDDA3            ', CAST(N'1980-04-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (240, N'Beverly Adams', N'GTMP02EU            ', CAST(N'1981-05-31' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (241, N'Lakisha Nichols', N'445K571L            ', CAST(N'1978-09-29' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (242, N'Kari Munoz', N'BJKOIO81            ', CAST(N'1990-09-19' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (243, N'Ruby Fuller', N'W2F71F00            ', CAST(N'1981-11-30' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (244, N'Tamika Santana', N'TS4SE9MJ            ', CAST(N'1977-04-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (245, N'Oliver Hubbard', N'KR4UXRDZ            ', CAST(N'1979-04-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (246, N'Cedric Branch', N'0SBYGYII            ', CAST(N'1976-12-31' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (247, N'Veronica Phelps', N'FX3QJ5F8            ', CAST(N'1976-04-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (248, N'Terry Vincent', N'WJ5B1YNN            ', CAST(N'1980-09-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (249, N'Samuel George', N'F24NU1W0            ', CAST(N'1975-02-07' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (250, N'Anna Nixon', N'GVB59VH7            ', CAST(N'1986-04-29' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (251, N'Loretta Owen', N'WU8YEPYG            ', CAST(N'1978-07-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (252, N'Anitra Mc Mahon', N'DPRCATO3            ', CAST(N'1989-07-07' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (253, N'Derrick Mora', N'NR32UJXZ            ', CAST(N'1987-01-10' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (254, N'Margaret Waters', N'HQA9TUCR            ', CAST(N'1988-10-14' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (255, N'Adrienne Boyer', N'1GNFODLI            ', CAST(N'1975-06-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (256, N'Shelia Short', N'G3KIH5FT            ', CAST(N'1979-11-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (257, N'Joyce Stuart', N'JU0P1ECH            ', CAST(N'1984-03-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (258, N'Billie Dodson', N'63VWZJ0M            ', CAST(N'1982-07-19' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (259, N'Nakia Tran', N'S83PGB8G            ', CAST(N'1986-07-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (260, N'Sammy Salas', N'SY94U0FT            ', CAST(N'1985-04-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (261, N'Sherri Landry', N'SCE927MF            ', CAST(N'1979-06-04' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (262, N'Frank Cervantes', N'FK31IUIN            ', CAST(N'1990-05-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (263, N'Wanda Steele', N'CTDOHLIK            ', CAST(N'1980-09-07' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (264, N'Tara Bentley', N'H19VH6M7            ', CAST(N'1982-03-08' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (265, N'Sheila Fowler', N'8J5W31WS            ', CAST(N'1984-02-29' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (266, N'Alejandro Webb', N'SQFEL6E3            ', CAST(N'1986-01-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (267, N'Ismael Carson', N'I3VTQIN5            ', CAST(N'1976-12-14' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (268, N'Betsy Bird', N'5K2XFBKA            ', CAST(N'1990-11-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (269, N'Donna Booth', N'FFQCSOPQ            ', CAST(N'1984-05-20' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (270, N'Kimberly Neal', N'32G2GE73            ', CAST(N'1977-03-21' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (271, N'Loren Conway', N'EESN8XOR            ', CAST(N'1988-03-13' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (272, N'Julia Haynes', N'TVB4UB2Y            ', CAST(N'1977-09-19' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (273, N'Kari Reyes', N'96B640OJ            ', CAST(N'1978-08-23' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (274, N'Heath Atkins', N'X23OPB75            ', CAST(N'1976-07-30' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (275, N'Brandi Schaefer', N'BS7TN0GW            ', CAST(N'1989-04-14' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (276, N'Casey Nguyen', N'IZ740HQX            ', CAST(N'1988-04-02' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (277, N'Julie Merritt', N'S7ASZOTR            ', CAST(N'1990-01-28' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (278, N'Tami Price', N'4450WOFQ            ', CAST(N'1983-10-18' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (279, N'Damien Huffman', N'FGIAP855            ', CAST(N'1985-07-17' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (280, N'Ivan Casey', N'WS1LXSDF            ', CAST(N'1975-06-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (281, N'Roy Prince', N'LJSIZWCC            ', CAST(N'1984-11-15' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (282, N'Jasmine Rollins', N'PH2IP9BB            ', CAST(N'1983-09-16' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (283, N'Natasha Bean', N'EHH2MT4X            ', CAST(N'1977-11-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (284, N'Shelia Lindsey', N'MI6DMHQU            ', CAST(N'1986-12-27' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (285, N'Melisa Padilla', N'EWGMYDGF            ', CAST(N'1979-12-23' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (286, N'Ernesto Hayes', N'HD3SAMAZ            ', CAST(N'1990-10-23' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (287, N'Caroline Carlson', N'GIWYE2XP            ', CAST(N'1986-06-11' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (288, N'Israel Bradshaw', N'LCVLRU2X            ', CAST(N'1977-03-26' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (289, N'Gary Parrish', N'0RI4L76M            ', CAST(N'1990-02-28' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (290, N'Lakeisha Fletcher', N'VU7J2MJA            ', CAST(N'1980-11-10' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (291, N'Jaime Bartlett', N'AFIEO9IU            ', CAST(N'1989-10-11' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (292, N'Rudy Gallagher', N'SWM8PD8A            ', CAST(N'1981-10-16' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (293, N'Scot Perez', N'FBWPSRI1            ', CAST(N'1978-11-17' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (294, N'Lana Finley', N'M1981HIR            ', CAST(N'1986-01-01' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (295, N'Sheri Roberts', N'VM39MQ3D            ', CAST(N'1976-12-27' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (296, N'Levi Walton', N'XN5TBSF4            ', CAST(N'1979-05-25' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (297, N'Sophia Riddle', N'FLMQVMFV            ', CAST(N'1985-01-12' AS Date), N'NO        ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (298, N'Clay Campbell', N'TJU5QYWC            ', CAST(N'1990-09-25' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (299, N'Catherine Mckenzie', N'46P5LE1L            ', CAST(N'1984-02-05' AS Date), N'YES       ')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [Password], [NgaySinh], [TinhTrang]) VALUES (300, N'Kareem Vincent', N'PTQHTXH3            ', CAST(N'1984-04-03' AS Date), N'YES       ')
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN] OFF
GO
