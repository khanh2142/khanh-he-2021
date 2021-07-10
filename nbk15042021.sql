if OBJECT_ID('qltp') is not null
drop database qltp

create database qltp
use qltp

if OBJECT_id('') is not null
drop table gv_p

create table gv_p
(magv int primary key,
tengv nvarchar(50),
chuyennganh char(50),
makhoa char(50),
constraint fk_gv_k foreign key (makhoa) references k_p(makhoa))

if OBJECT_ID('k_p') is not null
drop table k_p

create table k_p
(makhoa char(50) primary key ,
tenkhoa nvarchar(50))

if OBJECT_ID('l_p') is not null
drop table l_p

create table l_p
(malop char(50) primary key,
tenlop nvarchar(50),
makhoa char(50),
constraint fk_l_k foreign key (makhoa) references k_p(makhoa))

if OBJECT_ID('sv_p') is not null
drop table sv_p

create table sv_p
(masv char(50) primary key,
tensv nvarchar(50),
gioitinh nvarchar(5) check (gioitinh = N'Nam' or gioitinh = N'Nữ'),
ngaysinh date,
malop char(50),
constraint fk_sv_l foreign key (malop) references l_p(malop))

if OBJECT_ID('dt_p') is not null
drop table dt_p

create table dt_p
(masv char(50),
mamh char(50),
lanthi int,
diemthi float,
constraint pk_dt primary key (masv,mamh),
constraint fk_dt_sv foreign key (masv) references sv_p(masv),
constraint fk_dt_mh foreign key (mamh) references mh_p(mamh))

if OBJECT_ID('mh_p') is not null
drop table mh_p

create table mh_p
(mamh char(50) primary key,
tenmh nvarchar(50),
sogio float)

------------------------------------------
--cau 1--
if OBJECT_ID('') is not null
drop proc proc_cau1

create proc proc_cau1 @makhoa char(50),@tenkhoa nvarchar(50)
as insert k_p(makhoa,tenkhoa) values (@makhoa,@tenkhoa)

exec proc_cau1 'IT',N'Công nghệ thông tin'
exec  proc_cau1 'KR',N'Văn hoá Hàn Quốc'
exec  proc_cau1 'JP',N'Văn hoá Nhập Bản'

select * from k_p

--cau 2---
if OBJECT_ID('proc_cau2') is not null
drop proc proc_cau2

create proc proc_cau2 @malop char(50),@tenlop nvarchar(50),@makhoa char(50)
as
insert l_p(malop,tenlop,makhoa) values (@malop,@tenlop,@makhoa)

exec proc_cau2 'IT01',N'Lập trình ứng dụng 1','IT'
exec proc_cau2 'KR01',N'Tiếng Hàn 1','KR'
exec proc_cau2 'JP01',N'Tiếng Nhật 1','JP'

select * from l_p

--cau 3-------
if OBJECT_ID('') is not null
drop proc proc_cau3 

create proc proc_cau3 @magv int,@tengv nvarchar(50),
@chuyennganh char(50),@makhoa char(50)
as
insert gv_p(magv,tengv,chuyennganh,makhoa) values
(@magv,@tengv,@chuyennganh,@makhoa)

exec proc_cau3 1,N'Nguyễn Văn Long','CNTT','IT'
exec proc_cau3 2,N'Nguyễn Cẩm Tú','KR','KR'
exec proc_cau3 3,N'Nguyễn Hương Giang','JP','JP'

select * from gv_p

--cau 4---
if OBJECT_ID('') is not null
drop proc proc_cau4

create proc proc_cau4 @makhoa char(50),@tenkhoa nvarchar(50) as
update k_p set tenkhoa = @tenkhoa where makhoa = @makhoa

--cau 5--
if OBJECT_ID('proc_cau5') is not null
drop proc proc_cau5

create proc proc_cau5 @masv char(50),@mamh char(50),@lanthi int,@diem float
as update dt_p set diemthi = @diem where
masv = @masv and mamh = @mamh and lanthi = @lanthi