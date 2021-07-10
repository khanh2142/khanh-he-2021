create database QL_THUCTAP_K18
use QL_THUCTAP_K18;

create table TBLKhoa(
Makhoa char(5) primary key,
Tenkhoa nvarchar(50),
Dienthoai char(20))

create table TBLSinhvien(
Masv int primary key,
Hotensv nvarchar(100),
Makhoa char(5),
Namsinh int,
Quequan nvarchar(50),
constraint FK_sv_khoa foreign key (Makhoa) references TBLKhoa(Makhoa))


create table TBLGiangvien(
Magv int primary key,
Hotengv nvarchar(50),
Luong float,
Makhoa char(5),
constraint FK_gv_khoa foreign key (Makhoa) references TBLKhoa(Makhoa))

create table TBLDetai(
Madt char(10) primary key,
Tendt char(100),
Kinhphi float,
Noithuctap nvarchar(100))

create table TBLHuongDan(
Masv int primary key,
Madt char(10),
Magv int,
Ketqua float,
constraint FK_huongdan_gv foreign key (Magv) references TBLGiangvien(Magv),
constraint FK_huongdan_detai foreign key (Madt) references TBLDetai(Madt))

insert into TBLKhoa(Makhoa,Tenkhoa,Dienthoai) values
('EL',N'Điện tử','3855411'),
('IT',N'Công nghệ thông tin','3855413'),
('OT',N'Du lịch khách sạn','3855412')

insert into TBLSinhvien(Masv,Hotensv,Makhoa,Namsinh,Quequan) values
(1,N'Lê Văn Sao','EL',2000,N'Nghệ An'),
(2,N'Nguyễn Thị Hằng','IT',2001,N'Thanh Hoá'),
(3,N'Nguyễn Bá Quyền','EL',2000,N'Hà Nội'),
(4,N'Nguyễn Chí Thành','IT',2000,N'Bắc Ninh'),
(5,N'Nguyễn Văn An','EL',2001,N'Bắc Giang'),
(6,N'Lê Thế Cần','OT',2001,N'Hà Nam'),
(7,N'Trần Quốc Tuấn','OT',2001,null),
(8,N'Đào Thị Nga','IT',2001,N'Hà Nội')

insert into TBLGiangvien(Magv,Hotengv,Luong,Makhoa) values 
(11,N'Lê Phong',150,'IT'),
(12,N'Nguyễn Đức Giang',150,'IT'),
(13,N'Trần Long',180,'EL'),
(14,N'Nguyễn Doanh',160,'EL'),
(15,N'Trần Hảo',190,'OT')

insert into TBLHuongDan(Masv,Madt,Magv,Ketqua) values
(1,'Dt01',13,8),
(2,'Dt03',13,0),
(3,'Dt03',13,10),
(5,'Dt04',13,7),
(6,'Dt01',13,null),
(7,'Dt04',13,10),
(8,'Dt03',13,6)

insert into TBLDetai(Madt,Tendt,Kinhphi,Noithuctap) values
('Dt01','GIS',100,N'Nghệ An'),
('Dt02','ARC GIS',500,N'Nam Định'),
('Dt03','Spatial DB',100,N'Hà Nội'),
('Dt04','MAP',300,N'Bắc Ninh')

--Cau 4--
select sv.Masv,sv.Hotensv,sv.Makhoa,sv.Namsinh,sv.Quequan from TBLSinhvien sv,TBLHuongDan 
where (Ketqua = (select max(ketqua) from TBLHuongDan)) and (sv.Masv=TBLHuongDan.Masv)

--cau 5--
create procedure Stored_Procedure(@a int,@b nvarchar(100),@c nvarchar(5),@d int,@e nvarchar(50)) as
insert into TBLSinhvien(Masv,Hotensv,Makhoa,Namsinh,Quequan) values (@a,@b,@c,@d,@e)

--cau 6--
create view v_kinhphi as
select * from TBLDetai where Kinhphi>=300

select * from v_kinhphi

--cau 7--
update TBLDetai set Noithuctap=N'Hà Nội' where Noithuctap like N'Nghệ An'
select * from TBLDetai

--Cau 8--

--cau 9--
create view v_cntt as 
select * from TBLSinhvien where Makhoa like 'IT'

select * from v_cntt
--Cau 10--
select sv.Masv,sv.Hotensv,sv.Makhoa,sv.Namsinh,sv.Quequan from TBLSinhvien sv,TBLHuongDan 
where (sv.Masv=TBLHuongDan.Masv) and (TBLHuongDan.Ketqua is null)


