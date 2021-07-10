if OBJECT_ID('sql_server') is not null
drop database sql_server

create database sql_server
use sql_server 

if OBJECT_ID('FoodType') is not null
drop table FoodType

create table FoodType
(id int primary key,
Fname char(50),
 price float,
 amount int)

if OBJECT_ID('FoodAnimal') is not null
drop table FoodAnimal 

create table FoodAnimal
(food_id int,
animal_id int,
constraint fk_fa_ft foreign key (food_id) references FoodType(id),
constraint fk_fa_ani foreign key (animal_id) references Animal(id))

if OBJECT_ID('Room') is not null
drop table Room

create table Room
(id int primary key,
Rname char(50),
Rmax int)

if OBJECT_ID('Animal') is not null
drop table Animal

create table Animal 
(id int primary key,
Aname char(50),
age int,
buy_at date,
room_id int,
constraint fk_ani_roo foreign key (room_id) references Room(id))

insert into Room(id,Rname,Rmax) values
(1,'R01',5),
(2,'R02',2),
(3,'R03',3),
(4,'R04',50),
(5,'R05',10)

insert into FoodType(id,Fname,price,amount) values
(1,'Thuc an A',100000,20),
(2,'Thuc an B',200000,10),
(3,'Thuc an C',300000,30),
(4,'Thuc an D',150000,10),
(5,'Thuc an E',120000,10)

insert into Animal(id,Aname,age,buy_at,room_id) values
(1,'Dong vat A',2,'2020-02-16',1),
(2,'Dong vat B',1,'2020-02-26',1),
(3,'Dong vat C',3,'2020-02-12',1),
(4,'Dong vat D',5,'2020-02-15',1),
(5,'Dong vat E',2,'2020-06-16',1),
(6,'Dong vat F',1,'2020-02-16',2),
(7,'Dong vat G',1,'2020-02-16',2),
(8,'Dong vat H',6,'2020-02-16',3)

insert into Animal(id,Aname,age,buy_at,room_id) values
(9,'Dong vat I',6,'2020-02-16',3),
(10,'Dong vat K',6,'2020-02-16',3),
(11,'Dong vat L',6,'2020-02-16',3)

insert into FoodAnimal(food_id,animal_id) values
(1,1),
(1,2),
(2,1),
(2,3),
(2,4),
(3,1),
(5,5)
--cau 3--
select  a.room_id,r.Rmax ,count(a.room_id) as N'So luong hien tai' from Animal a
join Room r on a.room_id = r.id 
group by a.room_id,r.Rmax
having COUNT(a.room_id)>r.Rmax

--cau 4--
select  a.room_id,r.Rmax ,count(a.room_id) as N'So luong hien tai' from Animal a
join Room r on a.room_id = r.id 
group by a.room_id,r.Rmax
having COUNT(a.room_id)<r.Rmax

--cau 5--
if OBJECT_ID('proc_view') is not null
drop proc proc_view 

create proc proc_view @animalId int
as select Animal.id,Animal.Aname,Animal.age,FoodType.id as 'FoodID',
FoodType.Fname,FoodType.price,FoodType.amount
from FoodType,FoodAnimal,Animal
where (Animal.id = FoodAnimal.animal_id) 
and (FoodAnimal.food_id = FoodType.id)
and (@animalId = Animal.id)

exec proc_view 3

---cau 6---
if OBJECT_ID('tri_del') is not null
drop trigger tri_del

create trigger tri_del  on FoodType instead of delete
as 
	begin
		delete from FoodAnimal where food_id in (
		select id from deleted)
		delete from FoodType where id in (select id from deleted)
	end

delete from FoodType where id = 1	