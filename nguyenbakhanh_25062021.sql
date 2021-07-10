if OBJECT_ID('QLSV') is not null
drop database QLSV 

create database QLSV
use QLSV

if OBJECT_ID('sinhvien') is not null
drop table sinhvien

create table sinhvien
(masv int primary key,
hoten nvarchar(50),
sdt char(50),
diachi nvarchar(100),
ghichu nvarchar(100))

if OBJECT_ID('monhoc') is not null
drop table monhoc

create table monhoc
(mamh char(5) primary key,
tenmh nvarchar(50))

if OBJECT_ID('diem') is not null
drop table diem

create table diem
(masv int,
mamh char(5),
diemlan1 float,
diemlan2 float,
ghichu nvarchar(100),
constraint pk_diem primary key (masv,mamh),
constraint fk_diem_sv foreign key (masv) references sinhvien(masv),
constraint fk_diem_mh foreign key (mamh) references monhoc(mamh))

exec proc_add_sv 1,N'Nguyễn Văn A','0366777888',N'Hà Nội',''
exec proc_add_sv 2,N'Nguyễn Văn B','0366779888',N'Hà Nam',''
exec proc_add_sv 3,N'Nguyễn Văn C','0366647888',N'Hải Phòng',''
exec proc_add_sv 4,N'Nguyễn Văn D','0332154488',N'Vũng Tàu',''
exec proc_add_sv 5,N'Nguyễn Văn E','0336556588',N'Quảng Nam',''

exec proc_add_mh 'IT',N'Công nghệ thông tin'
exec proc_add_mh 'EL',N'Tiếng Anh'
exec proc_add_mh 'OT',N'Công nghệ ô tô'

exec proc_add_diem 1,'IT',7,8,''
exec proc_add_diem 2,'EL',8,9,''
exec proc_add_diem 5,'IT',9,6,''
exec proc_add_diem 3,'EL',6,5,''
exec proc_add_diem 4,'OT',10,0,''

exec proc_del_sv 3
exec proc_del_mh 'OT'
exec proc_del_diem 1,'IT'

exec proc_upd_sv 1,N'Nguyễn Quang Minh'
exec proc_upd_mh 'EL','English'
exec proc_upd_diem 2,'EL',10

select * from sinhvien
select * from monhoc
select * from diem