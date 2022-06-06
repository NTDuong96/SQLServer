create table Table1(
	Ten nvarchar(50) not null,
	Tuoi int null,
	DOB date
)
go
--1. Thêm bảng
insert into Table1(Ten,Tuoi,DOB) values('A',21,'19960814')
insert into Table1(Ten,Tuoi,DOB) values('B',22,'19960815')
--2.1. Thêm thông tin
update Table1 set Ten='AB', Tuoi=23, DOB='19960816'
			where Ten='A';
	select * from Table1
delete from Table1 where Ten='B'
delete from Table1 where Ten='A'
delete from Table1 where Ten='AB'
--2.2. Sửa (update) + xóa (delete from) thông tin
	select * from Table1
alter table Table1 add id int;
alter table Table1 add constraint khoa primary key(id);
alter table Table1 add constraint khoa2 primary key (id);

alter table Table1 add id2 int not null;
alter table Table1 add constraint khoa3 primary key (id2);
--3. Thêm id + constraint (có bug - không đặt primary key cho cột có null)
create table Table2(
malop int not null primary key,
tenlop int null
)
--4. Tạo bảng 2 cho mã + tên lớp
alter table Table2
add constraint khoaphu foreign key(malop) references Table1(id2)
--5. Gắn khóa phụ với mã lớp, link cho 2 bảng (malop với id2 của Table1)
select * from Table1
insert into Table1(Ten,Tuoi,DOB) values ('C',23,'19960815')
select * from Table2
insert into Table2(malop,tenlop) values(2,22)
--6. Thêm thông tin