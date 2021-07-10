--  if OBJECT_ID('') is not null
--	drop 
--------------------

if OBJECT_ID('qldt1') is not null
drop database qldt1

create database qldt1
use qldt1

if OBJECT_ID('lop_1') is not null
drop table lop_1

create table lop_1
(malop char(50) primary key,
tenlop char(50),
hedaotao nvarchar(50),
makhoa char(50),
constraint fk_l_k foreign key (makhoa) references khoa_1(makhoa))

if OBJECT_ID('khoa_1') is not null
drop table khoa_1

create table khoa_1
(makhoa char(50) primary key,
tenkhoa nvarchar(50),
dienthoai char(50),
phong int)

if OBJECT_ID('monhoc_1') is not null
drop table monhoc_1

create table monhoc_1
(mamh char(5) primary key,
tenmh nvarchar(50),
sotiet int)

if OBJECT_ID('sinhvien_1') is not null
drop table sinhvien_1

create table sinhvien_1
(masv char(50) primary key,
hodem nvarchar(50),
ten nvarchar(50),
gioitinh int check(gioitinh = 0 or gioitinh = 1),
noisinh nvarchar(50),
malop char(50),
ngaysinh date,
constraint fk_sv_l foreign key (malop) references lop_1(malop))


insert into lop_1(malop,tenlop,hedaotao,makhoa) values
('K19CH1','K19.CH3.01',N'Chính quy','CCH01'),
('K19CH2','K19.CH3.02',N'Chính quy','CCH01'),
('K19CH5','K19.CH3.05',N'Chính quy','CCH01'),
('K19IT1','K19.IT3.01',N'Chính quy','CIT01'),
('K19IT2','K19.IT3.02',N'Chính quy','CIT01'),
('K19IT3','K19.IT3.03',N'Chính quy','CIT01'),
('K19IT4','K19.PR3.01',N'Chính quy','CIT01'),
('K19IT5','K19.PR3.02',N'Chính quy','CIT01'),
('K19JP1','K19.JP3.01',N'Chính quy','CJP01'),
('K19JP2','K19.JP3.03',N'Chính quy','CJP01'),
('K19KR1','K19.KR3.01',N'Chính quy','CKR01'),
('K19KR2','K19.KR3.02',N'Chính quy','CKR01'),
('K19KR3','K19.KR3.03',N'Chính quy','CKR01')

insert into khoa_1(makhoa,tenkhoa,dienthoai,phong) values
('CCH01',N'Văn hoá Trung Quốc','42634310',407),
('CEL01',N'Công nghệ Điện - Điện tử','426343437',704),
('CIT01',N'Công nghệ thông tin','426343436',307),
('CJP01',N'Văn hoá Nhật Bản','426343439',406),
('CKR01',N'Văn hoá Hàn Quốc','426343448',506)

insert into sinhvien_1(masv,hodem,ten,gioitinh,noisinh,malop,ngaysinh) values
('CIT01',N'Nguyễn Tuấn',N'Anh',1,N'Hà Nội','K19IT1','2001-02-20'),
('CIT02',N'Nguyễn Thị',N'Hằng',0,N'Hà Nội','K19IT1','2001-03-28'),
('CIT03',N'Nguyễn Đức',N'Bình',1,N'Thanh Hoá','K19IT2','2001-05-17'),
('CIT09',N'Nguyễn Thị',N'Loan',0,N'Thái Bình','K19IT1','2001-02-20'),
('CIT19',N'Hoàng Minh',N'Tuấn',1,N'Thái Bình','K19IT2','2001-10-28'),
('CJP01',N'Lê Hồng',N'Phương',0,N'Thái Nguyên','K19JP1','2001-11-24'),
('CPR01',N'Nguyễn Thị',N'Phương',0,N'Thái Nguyên','K19KR1','2000-08-25'),
('CPR21',N'Hoàng Minh',N'Sơn',1,N'Nam Định','K19KR1','2000-05-08'),
('CPR23',N'Nguyễn Thị',N'Phương Anh',0,N'Phú Thọ','K19KR1','2000-11-24')

insert into monhoc_1(mamh,tenmh,sotiet) values
('C01',N'Cơ sở dữ liệu',72),
('C02',N'Cơ sở lập trình',72),
('C03',N'Toán rời rạc',60),
('C04',N'Hệ quản trị CSDL',5),
('C05',N'Lập trình ứng dụng',72)

--cau 1--
if OBJECT_ID('v_cau1') is not null
drop view v_cau1

create view v_cau1 as
select * from sinhvien_1 where noisinh like N'Thái Nguyên'

select * from v_cau1

--cau 2--
if OBJECT_ID('v_cau2') is not null
drop view v_cau2

create view v_cau2 as
select * from khoa_1 where phong=307

select * from v_cau2

--cau 3--
select khoa_1.makhoa,COUNT(lop_1.makhoa) as N'Số lớp' from lop_1
join khoa_1 on khoa_1.makhoa = lop_1.makhoa
group by lop_1.makhoa,khoa_1.makhoa

--cau 4--
if OBJECT_ID('proc_mm') is not null
drop proc proc_mm

create proc proc_mm as
begin
	select top 1 mh.sotiet as N'Số tiết cao nhất' from monhoc_1 mh
	select mh.sotiet as N'Số tiết nhỏ nhất' from monhoc_1 mh where mh.sotiet =
	(select min(sotiet) from monhoc_1)
end

exec proc_mm

--cau 5---
select sv.hodem,sv.ten,
case sv.gioitinh
when 0 then N'Nữ'
when 1 then N'Nam'
end as 'gioitinh'
from sinhvien_1 sv

--cau 6--
if OBJECT_ID('v_cau6') is not null
drop view v_cau6

create view v_cau6 as
select mh.mamh,mh.tenmh,(mh.sotiet/15) as N'Số tín chỉ' 
from monhoc_1 mh

select * from v_cau6

---cau 7--
if OBJECT_ID('v_cau7') is not null
drop view v_cau7

create view v_cau7 as
select * from sinhvien_1 where masv like 'CIT19'

select * from v_cau7