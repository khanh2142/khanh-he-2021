create database qlsv_k20
use qlsv_k20

create table lop_k20
(malop char(50) primary key,
tenlop nvarchar(50),
gvcn nvarchar(50))

drop table lop_k20

create table sinhvien_k20
(masv char(50) primary key,
hosv nvarchar(50),
tensv nvarchar(50),
phai nvarchar(50) check (phai between N'Nam' and N'Nữ'),
ngaysinh date,
diachi nvarchar(100),
dienthoai char(50),
malop char(50),
constraint fk_sv_lop foreign key (malop) references lop_k20(malop))

create table ketqua_k20
(masv char(50),
mamh char(50),
diemlan1 float,
diemlan2 float,
constraint pk_kq primary key (masv,mamh),
constraint fk_kq_sv foreign key (masv) references sinhvien_k20(masv),
constraint fk_kq_mh foreign key (mamh) references monhoc_k20(mamh))

create table monhoc_k20
(mamh char(50) primary key,
tenmh nvarchar(50),
sotc int)

set dateformat dmy

select * from sinhvien_k20
select * from monhoc_k20
select * from ketqua_k20

select * from sinhvien_k20 where tensv like 'Gia%'