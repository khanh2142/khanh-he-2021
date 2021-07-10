create database qlbh1
use qlbh1

create table mh1 
(mh int primary key,
th nvarchar(50),
sl int)

create table nkbh1 
(nguoimua nvarchar(50),
mh int,
sl int)

insert into mh1(mh,th,sl) values
(1,N'Mã hàng 1',100),
(2,N'Mã hàng 2',90),
(3,N'Mã hàng 3',800),
(4,N'Mã hàng 4',500),
(5,N'Mã hàng 5',600)

drop table mh1

--cau 3--
drop trigger tri_add1

create trigger tri_add1 on nkbh1 for insert 
as
begin
	update mh1 
	set mh1.sl = mh1.sl - 
	(select sl from inserted where inserted.mh = mh1.mh)
	from mh1
	join inserted on mh1.mh = inserted.mh
end

insert into nkbh1(nguoimua,mh,sl) values
(N'Nguyễn Văn Anh',5,200)

---cau 4---
drop trigger tri_add2

create trigger tri_add2 on nkbh1 for update
as
begin
	update mh1 
	set mh1.sl = mh1.sl - 
	(select sl from inserted where inserted.mh = mh1.mh)+
	(select sl from deleted where deleted.mh = mh1.mh)
	from mh1
	join deleted on mh1.mh = deleted.mh
end

update nkbh1 set sl = 200 where mh = 5
select * from mh1 