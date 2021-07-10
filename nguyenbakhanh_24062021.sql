create database ql_thuctap_k18_2
use ql_thuctap_k18_2

if OBJECT_ID('sinhvien') is not null
drop table sinhvien

if OBJECT_ID('khoa') is not null
drop table khoa

if OBJECT_ID('giangvien') is not null
drop table giangvien

if OBJECT_ID('huongdan') is not null
drop table huongdan

if OBJECT_ID('detai') is not null
drop table detai

create table sinhvien
(masv int primary key,
hotensv nvarchar(50),
makhoa char(5),
namsinh int,
quequan nvarchar(50),
constraint fk_sv_khoa foreign key (makhoa) references khoa(makhoa))

create table khoa
(makhoa char(5) primary key,
tenkhoa nvarchar(50),
dienthoai char(50))

create table huongdan
(masv int primary key,
madt char(5),
magv int,
ketqua float,
constraint fk_hd_gv foreign key (magv) references giangvien(magv),
constraint fk_hd_detai foreign key (madt) references detai(madt))

create table detai
(madt char(5) primary key,
tendt nvarchar(50),
kinhphi float,
noithuctap nvarchar(50))

create table giangvien
(magv int primary key,
hotengv nvarchar(50),
luong float,
makhoa char(5),
constraint fk_gv_khoa foreign key (makhoa) references khoa(makhoa))

insert into khoa(makhoa,tenkhoa,dienthoai) values
('EL',N'Điện tử','3855411'),
('IT',N'Công nghệ thông tin','3855413'),
('OT',N'Du lịch khách sạn','3855412')

insert into sinhvien(masv,hotensv,makhoa,namsinh,quequan) values
(1,N'Lê Văn Sao','EL',2000,N'Nghệ An'),
(2,N'Nguyễn Thị Hằng','IT',2001,N'Thanh hoá'),
(3,N'Nguyễn Bá Quyền','EL',2000,N'Hà Nội'),
(4,N'Nguyễn Chí Thành','IT',2000,N'Bắc Ninh'),
(5,N'Nguyễn Văn An','EL',2001,N'Bắc Giang'),
(6,N'Lê Thế Căn','OT',2001,N'Hà Nam'),
(7,N'Trần Quốc Tuấn','OT',2001,null),
(8,N'Đào Thị Nga','IT',2001,N'Hà Nội')

insert into giangvien(magv,hotengv,luong,makhoa) values
(11,N'Lê Phong',150,'IT'),
(12,N'Nguyễn Đức Giang',150,'IT'),
(13,N'Trần Long',180,'EL'),
(14,N'Nguyễn Doanh',160,'EL'),
(15,N'Trần Hảo',190,'OT')

insert into huongdan(masv,madt,magv,ketqua) values
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,null),
(7,'Dt04',11,10),
(8,'Dt03',15,6)

insert into detai(madt,tendt,kinhphi,noithuctap) values
('Dt01','GIS',100,N'Nghệ An'),
('Dt02','ARC GIS',500,N'Nam Định'),
('Dt03','Spatial DB',100,N'Hà Nội'),
('Dt04','MAP',300,N'Bắc Ninh')

select * from sinhvien
select * from giangvien
select * from khoa
select * from detai
select * from huongdan

--cau 4---
select distinct dt.madt,dt.tendt,gv.magv 
from giangvien gv,detai dt,huongdan hd
where gv.magv = hd.magv and gv.hotengv like N'Trần Long'
and dt.madt = hd.madt

--cau 5--
create view v_notSV as
select dt.madt,dt.tendt from detai dt
where not exists 
(select * from huongdan where dt.madt=huongdan.madt)

select * from v_notSV

--cau 6--
select huongdan.madt,dt.tendt from detai dt
join huongdan on dt.madt=huongdan.madt
group by dt.tendt,huongdan.madt having count(huongdan.madt)>2

--cau 7--
create view v_max as
select  dt.madt,dt.tendt,dt.kinhphi from detai dt
where dt.kinhphi >= (select max(kinhphi) from detai)

select * from v_max

--cau 8--
create proc add_dt 
@madt char(5),
@tendt nvarchar(50),
@kinhphi float,
@noithuctap nvarchar(50) as
insert detai(madt,tendt,kinhphi,noithuctap) 
values (@madt,@tendt,@kinhphi,@noithuctap)

--cau 9--
create trigger tri_stop on huongdan for update,insert as
	select * from huongdan where masv=1 and ketqua=8
	begin
		rollback transaction
	end

--cau 10--
create trigger tri_stop1 on sinhvien for update as
	update sinhvien set quequan=N'Thái Bình' where masv=7
	select quequan from sinhvien
		begin
			rollback transaction
		end

