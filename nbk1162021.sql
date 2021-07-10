if OBJECT_ID('qlbs1') is not null
drop database qlbs1

create database qlbs1
use qlbs1

if OBJECT_ID('hoadon_1') is not null
drop table hoadon_1

create table hoadon_1
(sohd int primary key,
tenkh nvarchar(50),
masach int,
sl int,
gia float,
constraint fk_hd_s foreign key (masach) references sach_1(masach))

if OBJECT_ID('sach_1') is not null
drop table sach_1

create table sach_1
(masach int primary key,
tensach nvarchar(50),
theloai nvarchar(50),
manxb int,
namxb int,
matg int,
sl int,
constraint fk_s_nxb foreign key (manxb) references nxb_1(manxb),
constraint fk_s_tg foreign key (matg) references tacgia_1(matg))

if OBJECT_ID('nxb_1') is not null
drop table nxb_1

create table nxb_1
(manxb int primary key,
tennxb nvarchar(50),
diachi nvarchar(100))

if OBJECT_ID('tacgia_1') is not null
drop table tacgia_1

create table tacgia_1
(matg int primary key,
hoten nvarchar(50),
namsinh int,
quequan nvarchar(50))


insert into tacgia_1(matg,hoten,namsinh,quequan) values
(1,N'Nguyễn Quảng Trường',1952,N'Hà Nội'),
(2,N'Nguyễn Tuệ',1948,N'Hà Nam'),
(3,N'Nguyễn Bá Tường',1958,N'Hà Nội'),
(4,N'Đỗ Xuân Lôi',1962,N'Thái Bình'),
(5,N'Lê Thị Thuỳ Dương',1968,N'Hà Nội')

insert into nxb_1(manxb,tennxb,diachi) values
(11,N'Nhà xuất bản Đại học Quốc Gia',N'Hà Nội'),
(12,N'Nhà xuất bản Hồng Đức',N'65 Tràng Thi, Hàng Bông, Hoàn Kiếm, Hà Nội'),
(13,N'Nhà xuất bản Khoa học và kỹ thuật',N'70 Trần Hưng Đạo, Hoàn kiếm, Hà Nội'),
(14,N'Nhà xuất bản Khoa học tự nhiên và Công nghệ',N'18B Hong Quốc Việt, Nghĩa Đô, Cầu Giấy, Hà Nội')

insert into sach_1(masach,tensach,theloai,manxb,namxb,matg,sl) values
(201,N'Bài tập nhập môn Lập trình',N'Bài tập',13,2021,5,30),
(202,N'Dữ liệu lớn cuộc cách mạng',N'Giáo trình',13,2021,5,30),
(203,N'Cấu trúc dữ liệu và giải thuật',N'Giáo trình',13,1998,4,45),
(204,N'Truyền thông về biến đổi khí hậu',N'Giáo trình',11,2020,1,60),
(205,N'Nhập môn cơ sở dữ liệu',N'Giáo trình',12,1996,2,35),
(206,N'Thực hành ứng dụng cơ sở dữ liệu',N'Bài tập thực hành',11,2028,3,25)

insert into hoadon_1(sohd,tenkh,masach,sl,gia) values
(1,N'Đặng Trần Long',203,2,80000)

--cau 4---
if OBJECT_ID('v_sach1') is not null
drop view v_sach1

create view v_sach1 as
select * from sach_1 where masach=205

select * from v_sach1

--cau 5--
if OBJECT_ID('v_nxb1') is not null
drop view v_nxb1

create view v_nxb1 as
select * from nxb_1 where not exists 
(select * from sach_1 where sach_1.manxb = nxb_1.manxb)

select * from v_nxb1

--cau 6--
if OBJECT_ID('proc_add_sach') is not null
drop proc proc_add_sach

create proc proc_add_sach 
@ms int,
@ts nvarchar(50),
@tl nvarchar(50),
@manxb int,
@namxb int,
@matg int,
@sl int
as
begin
	insert sach_1(masach,tensach,theloai,manxb,namxb,matg,sl) values
	(@ms,@ts,@tl,@manxb,@namxb,@matg,@sl)
end

exec proc_add_sach 207,N'Tuyển tập truyện hay',N'Truyện',13,2021,5,1

--cau 7--
create table thuhoi_1
(masach int primary key,
tensach nvarchar(100),
theloai nvarchar(100),
manxb int,
namxb int,
matg int)

drop table thuhoi_1

insert into thuhoi_1(masach,tensach,theloai,manxb,namxb,matg) values
(207,N'Tuyển tập truyện hay',N'Truyện',13,2021,5)

delete from thuhoi_1

select * from dbo.[thuhoi_1]
--cau 8---
select tg.hoten,sum(s.sl) as N'Số lượng đang bán' from tacgia_1 tg 
join sach_1 s on s.matg = tg.matg
group by tg.hoten

--cau 9--
if OBJECT_ID('trig_del_sach') is not null
drop trigger trig_del_sach

create trigger dbo.[trig_del_sach] on dbo.[thuhoi_1] after insert
as 
	begin
	delete from sach_1 where masach in
	(select masach from inserted)
	end

--- cau 10---
if OBJECT_ID('trig_fix') is not null
drop trigger trig_fix 

create trigger trig_fix on hoadon_1 for insert 
as
	begin
	update sach_1 set sach_1.sl = sach_1.sl -
	(select sl from inserted where inserted.masach = sach_1.masach)
	from sach_1
	join inserted on sach_1.masach = inserted.masach
	end

insert into hoadon_1(sohd,tenkh,masach,sl,gia) values
(2,N'Nguyễn Văn Nam',204,30,50000)

select * from sach_1

