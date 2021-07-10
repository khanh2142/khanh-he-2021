create database qlpk_1
use qlpk_1

if OBJECT_ID('nhanvien') is not null
drop table nhanvien

if OBJECT_ID('khambenh') is not null
drop table khambenh

if OBJECT_ID('benhnhan') is not null
drop table benhnhan

if OBJECT_ID('thanhtoan') is not null
drop table thanhtoan

create table nhanvien
(manv char(5) primary key,
hoten nvarchar(50),
chucvu nvarchar(50),
chuyenkhoa nvarchar(50))

create table benhnhan
(mabn int primary key,
hotenbn nvarchar(50),
tuoi int,
diachi nvarchar(50),
chuandoan nvarchar(50),
ngaykham date)

create table khambenh
(manv char(5),
mabn int,
ngaykham date,
dieutri nvarchar(50),
ketluan nvarchar(50),
constraint fk_kb_nv foreign key (manv) references nhanvien(manv),
constraint fk_kb_bn foreign key (mabn) references benhnhan(mabn))

create table thanhtoan
(mahd int primary key,
mabn int,
ngayhd date,
noidung nvarchar(50),
sotien float,
nguoilap nvarchar(50),
constraint fk_tt_bn foreign key (mabn) references benhnhan(mabn))

set dateformat dmy

insert into nhanvien(manv,hoten,chucvu,chuyenkhoa) values
('BS01',N'Nguyễn Mạnh Tuấn',N'Trưởng Khoa',N'Khoa Nội'),
('BS02',N'Nguyễn Hoàng',N'Trưởng Khoa',N'Khoa Ngoại'),
('BS03',N'Hoàng Tiến Hùng',N'Trưởng Khoa',N'Chuẩn đoán hình ảnh'),
('DD01',N'Lê Thị Huyền',N'Trưởng Khoa',N'Khoa Điều Dưỡng'),
('KT01',N'Cần Thị Có',N'Nhân Viên',N'Kế Toán')

insert into benhnhan(mabn,hotenbn,tuoi,diachi,chuandoan,ngaykham) values
(1,N'Sằn Móc Sịn',26,N'Hoàng Liên Sơn - Bắc Cạn',N'Đau dạ dày','20-01-2021'),
(2,N'Vừa A Tú',29,N'Hoàng Su Phi - Hà Giang',N'Gẫy đùi chân trái','21-01-2021'),
(3,N'Nguyễn Tiến Quang',48,N'Lập Thạch - Vĩnh Phúc',N'Viêm đường tiết liệu','17-01-2021'),
(4,N'Hoàng Minh Tuấn',60,N'Hà Đông - Hà Nội',N'Suy thận mãn','19-01-2021'),
(5,N'Nguyễn Thị Thuỳ',37,N'Thanh Xuân - Hà Nội',N'Đau dạ dày cấp','20-01-2021')

insert into khambenh(manv,mabn,ngaykham,dieutri,ketluan) values
('BS02',2,'21-1-2021',N'Kê thuốc về uống theo chỉ dẫn của BS',N'Gẫy đùi chân trái. Bó bột cố định'),
('BS01',3,'17-1-2021',N'Kê thuốc về uống theo chỉ dẫn của BS',N'Viêm đường tiết liệu cấp'),
('BS01',4,'19-1-2021',N'Kê thuốc về uống. Chạy tnt tuần 3 lần thứ 2,4,6',N'Suy thận mãn giai đoạn 4B'),
('BS02',2,'21-1-2021',N'Kê thuốc về uống theo chỉ dẫn của BS',N'Gẫy đùi chân trái. Bó bột cố định'),
('BS03',5,'23-1-2021',N'Kê thuốc về uống theo chỉ dẫn của BS',N'Gẫy đùi chân trái. Bó bột cố định')

insert into thanhtoan(mahd,mabn,ngayhd,noidung,sotien,nguoilap) values
(2101,1,'20-1-2021',N'KCB theo chỉ định BS',980000,N'Cần Thị Có'),
(2102,2,'21-1-2021',N'KCB theo chỉ định BS',1200000,N'Cần Thị Có'),
(2103,3,'17-1-2021',N'KCB theo chỉ định BS',780000,N'Cần Thị Có'),
(2104,4,'19-1-2021',N'KCB theo chỉ định BS',1800000,N'Cần Thị Có'),
(2105,1,'20-1-2021',N'KCB theo chỉ định BS',980000,N'Cần Thị Có')

--cau 4--
create view v_kb1 as
select * from nhanvien where not exists 
(select * from khambenh where nhanvien.manv = khambenh.manv)

select * from v_kb1

--cau 5--
select  bn.mabn,bn.hotenbn,bn.tuoi,bn.diachi 
from benhnhan bn,thanhtoan where bn.mabn = thanhtoan.mabn 
and
thanhtoan.sotien = (select min(thanhtoan.sotien) from thanhtoan)


--cau 6--
create proc add_kb 
@manv char(5),
@mabn int,
@ngaykham date,
@dieutri nvarchar(50),
@ketluan nvarchar(50)
as
	insert khambenh(manv,mabn,ngaykham,dieutri,ketluan) values
	(@manv,@mabn,@ngaykham,@dieutri,@ketluan)

--cau 7---
create view v_kb2 as
select kb.mabn,bn.hotenbn,count(kb.mabn) as N'Lần khám' from benhnhan bn
join khambenh kb on bn.mabn=kb.mabn group by bn.hotenbn,kb.mabn

select * from v_kb2

--cau 8--
select * from khambenh where not exists 
(select * from thanhtoan where khambenh.mabn = thanhtoan.mabn)

--cau 9--
create trigger tri_kb1 on khambenh for update as
update khambenh set manv = 'BS01' where mabn = 3

--cau 10--
select tt.sotien from benhnhan bn,thanhtoan tt where 
(tt.mabn = bn.mabn and hotenbn like N'Hoàng Minh Tuấn')