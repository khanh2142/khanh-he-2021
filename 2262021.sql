create database QL_SV_nguyenbakhanh
use QL_SV_nguyenbakhanh

create table sinhvien 
(masv int primary key,
hovaten nvarchar(100),
tuoi int,
noisinh nvarchar(100),
malop int,
constraint fk_sinhvien_lop foreign key (malop) references lop(malop))

create table ds_xoaten
(masv int primary key,
hovaten nvarchar(100),
tuoi int,
noisinh nvarchar(100),
malop int,
constraint fk_dsxoaten_lop foreign key (malop) references lop(malop))

create table khoa
(makhoa int primary key,
tenkhoa nvarchar(100),
namtl int)

create table lop
(malop int primary key,
tenlop char(100),
khoahoc int,
hedt nvarchar(100),
makhoa int,
constraint fk_lop_khoa foreign key (makhoa) references khoa(makhoa))

insert into sinhvien(masv,hovaten,tuoi,noisinh,malop) values
(1,N'Lê Thăng Long',19,N'Tuyên Quang',201),
(2,N'Nguyễn Văn Quyết',21,N'Hà Nội',201),
(3,N'Hoàng Minh Phương',19,N'Thái Bình',204),
(4,N'Phương Hoàng Long',18,N'Phú Thọ',203),
(5,N'Trần Quang Tuấn',24,N'Nghệ An',202),
(6,N'Trương Văn Dũng',23,N'Thanh Hoá',207)

insert into lop(malop,tenlop,khoahoc,hedt,makhoa) values
(201,'K18.IT3.01',18,N'Cao đẳng chính quy',2101),
(202,'K18.IT3.02',18,N'Cao đẳng chính quy',2101),
(203,'K19.OT3.01',19,N'Cao đẳng chính quy',2102),
(204,'K18.KR3.01',18,N'Cao đẳng chính quy',2103),
(205,'K19.JP3.01',19,N'Cao đẳng chính quy',2104),
(206,'K19.KR3.02',18,N'Cao đẳng chính quy',2103),
(207,'K19.JP3.02',19,N'Cao đẳng chính quy',2104),
(208,'K18.BA3.01',18,N'Cao đẳng chính quy',2105)

insert into khoa(makhoa,tenkhoa,namtl) values
(2101,N'Công nghệ thông tin',2015),
(2102,N'Công nghệ Ô tô',2018),
(2103,N'Ngôn ngữ Hàn Quốc',2010),
(2104,N'Ngôn ngữ Nhật Bản',2010),
(2105,N'Quản trị kinh doanh',2015)

select * from sinhvien
select * from lop
select * from khoa

---cau 4---


---cau 5---
create proc addSinhvien(@masv int,
@hovaten nvarchar(100),
@tuoi int,
@noisinh nvarchar(100),
@malop int)
as insert into sinhvien(masv,hovaten,tuoi,noisinh,malop) 
values (@masv,@hovaten,@tuoi,@noisinh,@malop)

--cau 6--
create view v_Lop as
select * from lop where not exists (select * from sinhvien where lop.malop = sinhvien.malop)

select * from v_Lop

--cau 7--
create view v_siso as
select lop.tenlop,count(sv.malop) as 'Sĩ số' from sinhvien sv join lop
on lop.malop = sv.malop group by lop.tenlop,sv.malop

select * from v_siso

--cau 8--
create view v_khoa2010 as
select * from khoa where namtl=2010

select * from v_khoa2010

--cau 9--
select khoa.tenkhoa,count(lop.makhoa) as 'Số lớp' from khoa join lop
on khoa.makhoa = lop.makhoa group by khoa.tenkhoa,lop.makhoa 
having COUNT(lop.makhoa)<2

---cau 10---
create trigger trg_xoaten on ds_xoaten for insert as
begin
delete from sinhvien where masv+malop in(select masv+malop from inserted 
ind where sinhvien.masv = ind.masv)
end





