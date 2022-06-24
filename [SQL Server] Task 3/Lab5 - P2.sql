IF EXISTS (SELECT * FROM sys.databases WHERE Name='BookLibrary')
	DROP DATABASE BookLibrary
GO
CREATE DATABASE BookLibrary
GO
USE BookLibrary
GO
--Tạo database (DB) BookLibrary
create table Book(
		BookCode int constraint pk_BCode primary key,
		BookTitle nvarchar(100) not null,
		Author nvarchar(50) not null,
		Edition int,
		BookPrice money,
		Copies int
)
go
insert into Book values (001, N'Đi tìm lẽ sống', 'Viktor Frankl', 2, 68000, 30),
						(002, N'Bushido', 'Nitobe Inazo', 6, 50000, 20),
						(003, N'Những bài học về đầu tư', 'Robert Kiyosaki', 4, 60000, 20)
--Tạo bảng Book
create table Member(
		MemberCode int constraint pk_MCode primary key,
		Name nvarchar(50) not null,
		Address nvarchar(100) not null,
		PhoneNumber int
)
insert into Member values (100, N'Mai Xuân Tiến', N'Hà Nội', 988362662),
							(101, N'Nguyễn Đình Hiến', N'Hà Nội', 946299388),
							(102, N'Nguyễn Hữu Thịnh', N'Hà Đông', 968668874)
							
--Tạo bảng Member
create table IssueDetails(
		BookCode int constraint fk_BookCode foreign key (BookCode) references Book(BookCode),
		MemberCode int constraint fk_MemCode foreign key (MemberCode) references Member(MemberCode),
		IssueDate datetime,
		ReturnDate datetime check(IssueDate<ReturnDate)
)
insert into IssueDetails values (001, 100, 06-12-2022 13:00:00, 06-13-2022 08:00:00),
								(002, 101, 06-12-2022 14:00:00, 06-13-2022 16:00:00),
								(003, 102, 06-14-2022 09:00:00, 06-16-2022 10:00:00)
--Tạo bảng IssueDetails
--2. Xóa/thêm constraint
--Xóa foreign key của IssueDetails
alter table IssueDetails
	drop constraint fk_BookCode, fk_MemCode

--Xóa prima key của Member và Book
alter table Book
	drop constraint pk_BCode
alter table Member
	drop constraint pk_MCode

--Thêm constraint prima cho Member/Book
alter table Member
	add constraint pk_Membercode primary key
alter table Book
	add constraint pk_Bookcode primary key

--Thêm foreign key cho IssueDetails
alter table IssueDetails
	add constraint fk_Membercode foreign key (MemberCode) references Member(MemberCode)
alter table IssueDetails
	add constraint fk_Bookcode foreign key (BookCode) references Book(BookCode)

--Giới hạn giá bán
alter table Book
	add constraint Price check(Price>0 and Price<200000)

--Constraint duy nhất (unique) cho PhoneNumber bảng Member
alter table Member
	add constraint uni_PhoneNum unique

--Thêm not null cho Book/MemberCode bảng IssueDetails
alter table IssueDetails
	add constraint BookCode not null
alter table IssueDetails
	add constraint MemberCode not null

--Composite constraint (khóa chính 2 cột)
alter table IssueDetails
	add constraint BookCode primary key
alter table IssueDetails
	add constraint MemberCode primary key