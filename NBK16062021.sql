create database QL_BAN_TBYT_Nguyenbakhanh
use QL_BAN_TBYT_Nguyenbakhanh

create table hoadon
(mahd int primary key,
makh int,
matb int,
dvt nvarchar(20),
soluong int,
constraint FK_hodon_khachhang foreign key (makh) references khachhang(makh))

create table khachhang
(makh int primary key,
hoten nvarchar(100),
diachi nvarchar(200),
sotd char(15),
loai nvarchar(15))

create table thietbi
(matb int primary key,
tentb nvarchar(100),
loai nvarchar(15),
ma_nhapp char(5),
dvt nvarchar(10),
soluong int,
giaban float,
constraint FK_thietbi_nhaphanphoi foreign key (ma_nhapp) references nhaphanphoi(ma_nhapp))

create table nhaphanphoi
(ma_nhapp char(5) primary key,
tennpp nvarchar(200),
diachi nvarchar(200),
sodt char(15))

insert into khachhang(makh,hoten,diachi,sotd,loai) values
(1,N'Nguyễn Văn Tuyến',N'Số 58 Phương Mai, Đống Đa, Hà Nội','0987665749',N'Bán buôn'),
(2,N'Nguyễn Thị Huyền',N'Số 800 Quang Trung, Hà Đông, Hà Nội','0977456687',N'Phòng khám'),
(3,N'Lê Nhật Anh',N'23 Lý Nam Đế, Hoàn Kiếm, Hà Nội','0388715268',N'Bán lẻ'),
(4,N'Sùng Văn Giàng',N'Lạng Sơn','0984559712',N'Bán buôn'),
(5,N'Hoàng Lê Nguyên',N'Thía Nguyên','0986115234',N'Bán buôn')

insert into nhaphanphoi(ma_nhapp,tennpp,diachi,sodt) values
('001',N'Công ty Cổ phàna XNK thiết bị Y tế Việt Anh',N'280 Quang Trung, Hà Đông, Hà Nội','0988765870'),
('002',N'Công ty XNK thiêt bị Y tế Việt Hưng',N'Kim Ngưu, Hai Bà Trưng, Hà Nội','0384778708'),
('003',N'Công ty Cổ phần XNK thiết bị Y tế Khánh Toán',N'Ninh Bình','0988765900'),
('004',N'Công ty TNHH XNK thiết bị Y tế Đại Hùng',N'Thanh Liệt, Thanh Xuân, Hà Nội','0988555333')


insert into thietbi(matb,tentb,loai,ma_nhapp,dvt,soluong,giaban) values
(100,N'Xe lăn điện Sunfast',N'Nhập khẩu','001',N'Cái',20,2200000),
(101,N'Nẹp chân gỗ',N'Nhập nội','003',N'Đôi',20,300000),
(102,N'Nhiệt kế điện tử - Sạc pin',N'Nhập khẩu','001',N'Cái',20,450000),
(103,N'Khẩu trang Y tế 3M',N'Nhập khẩu','002',N'Hộp',20,300000),
(104,N'Gậy trống 3 chân INOX',N'Nhập nội','001',N'Cái',20,180000)

insert into hoadon(mahd,makh,matb,dvt,soluong) values
(1,2,101,N'Đôi',10),
(2,3,102,N'Cái',15)

select * from khachhang
select * from nhaphanphoi
select * from thietbi
select * from hoadon

--cau 4--
create view v_giacao as
select * from thietbi where giaban = (select max(giaban) from thietbi)


select * from v_giacao

--cau 5--
create view v_banbuon as
select * from khachhang where loai like N'Bán buôn'

select * from v_banbuon

--cau 6--
select distinct npp.ma_nhapp,npp.tennpp,npp.diachi,npp.sodt
from thietbi tb,nhaphanphoi npp where tb.ma_nhapp = npp.ma_nhapp

--cau 7--
create proc add_thietbi (@matb int,@tentb nvarchar(100),@loai nvarchar(15),@ma_nhapp char(5),
@dvt nvarchar(10),@soluong int,@giaban float) as
insert into thietbi(matb,tentb,loai,ma_nhapp,dvt,soluong,giaban) 
values (@matb,@tentb,@loai,@ma_nhapp,@dvt,@soluong,@giaban)

--cau 8--
create trigger tri_update on nhaphanphoi
for update as
	update nhaphanphoi set diachi = N'Số 15 Thanh Phong, Kim Sơn, Ninh Bình'
	where ma_nhapp like '003'

--cau 9---


--cau 10---
create trigger tri_upd on hoadon
after insert as
	begin
		update thietbi
		set soluong = thietbi.soluong - 
		(select soluong from inserted where matb = thietbi.matb)
		from thietbi 
		join inserted on (thietbi.matb = inserted.matb)
	end
