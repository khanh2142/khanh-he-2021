create database qlsv_hpc_lethanglong
use qlsv_hpc_lethanglong

create table tblsinhvien(
masv char(5) primary key,
hoten nvarchar(100),
ngaysinh datetime,
gioitinh nvarchar(5),
malop char(5),
matinh char(5),
dtb float,
constraint fk_sv_lop foreign key (malop) references tbllop(malop),
constraint fk_sv_tinh foreign key (matinh) references tbltinh(matinh))

create table tbltinh
(matinh char(5) primary key,
tentinh nvarchar(50))

create table tbllop
(malop char(5) primary key,
tenlop char(50))

set dateformat dmy

insert into tblsinhvien(masv,hoten,ngaysinh,gioitinh,malop,matinh,dtb) values
('SV02',N'Chu Xuân Linh','25/03/1991',N'Nam','ML01','MT01',9.5),
('SV03',N'Ngô Doãn Tình','20/02/1995',N'Nam','ML01','MT02',8),
('SV04',N'Phạm xuân Tú','18/03/1995',N'Nam','ML02','MT03',9),
('SV05',N'Dương Xuân Tùng','5/5/1995',N'Nam','ML02','MT01',8.5),
('SV06',N'Nguyễn Thị Thảo','27/7/1995',N'Nữ','ML03','MT01',6.5),
('SV07',N'Trần Văn Cương','19/10/1995',N'Nam','ML03','MT04',7.5),
('SV08',N'Dương Thành Đô','27/01/1995',N'Nam','ML05','MT05',7.5),
('SV09',N'Tô Thành Đồng','14/12/1995',N'Nam','ML05','MT08',5.5),
('SV10',N'Nguyễn Thị Thương','28/02/1995',N'Nữ','ML05','MT09',7.5),
('SV11',N'Nguyễn Thị A','21/12/1995',N'Nữ','ML05','MT08',4.5),
('SV12',N'Nguyễn Thị B','28/08/1995',N'Nữ','ML07','MT06',4)

insert into tbltinh(matinh,tentinh) values
('MT01',N'Quảng Ninh'),
('MT02',N'Quảng Bình'),
('MT03',N'Quảng trị'),
('MT04',N'Quảng Nam'),
('MT05',N'Quảng Ngãi'),
('MT06',N'Hà Nội'),
('MT07',N'Quảng Ninh'),
('MT08',N'Thái Nguyên'),
('MT09',N'Bắc Giang')

insert into tbllop(malop,tenlop) values
('ML01','K20.IT3.01'),
('ML02','K20.IT3.02'),
('ML03','K20.IT03'),
('ML04','K20.PR3.01'),
('ML05','K20.PR3.02'),
('ML06','K20.KR3.01'),
('ML07','K20.PR3.02')

select * from tblsinhvien
select * from tbltinh
select * from tbllop


---cau 4---
create view v_dtb5 as
select * from tblsinhvien where dtb < 5

select * from v_dtb5

--cau 5--
create view v_bacgiang as
select sv.masv,sv.hoten,sv.ngaysinh,sv.gioitinh,sv.malop,sv.matinh,sv.dtb from tblsinhvien sv,tbltinh
where sv.matinh = tbltinh.matinh and tbltinh.tentinh like N'Bắc Giang'

select * from v_bacgiang
-- cau 6--
create view v_siso2 as
select tbllop.malop,count(sv.malop) as 'Sĩ số' from tblsinhvien sv join tbllop
on tbllop.malop = sv.malop group by tbllop.malop,sv.malop

select * from v_siso2
---cau 7--
create view v_dtb as
select tbllop.malop,max(sv.dtb) as 'Sĩ số' from tblsinhvien sv join tbllop
on tbllop.malop = sv.malop group by tbllop.malop

select * from v_dtb

---cau 8---
create view v_info as
select sv.masv,sv.hoten,sv.ngaysinh,sv.gioitinh,sv.malop,sv.matinh,sv.dtb
from tblsinhvien sv join v_dtb 
on sv.malop = v_dtb.malop and sv.dtb=v_dtb.[Sĩ số]

select * from v_info

--cau 9---
create table sinhvien_baoluu
(masv char(5) primary key,
hoten nvarchar(100),
ngaysinh datetime,
gioitinh nvarchar(5),
malop char(5),
dtb float)

--cau 10---
create trigger tri_baoluu on sinhvien_baoluu for insert as
begin
delete from tblsinhvien  where masv in (select masv from inserted ind
where tblsinhvien.masv=ind.masv)
end

insert into sinhvien_baoluu values
('SV12',N'Nguyễn Thị B','28/08/1995',N'Nữ','ML07',4)