--1. Create database 'AZBank'
if exists (select * from sys.databases where Name='AZBank')
	drop database AZBank
go
create database AZBank
go
use AZBank
go

--2. Create table + 3. Insert records for each table
create table Customer(
		CustomerID int primary key not null,
		Name nvarchar(50),
		City nvarchar(50),
		Country nvarchar(50),
		Phone nvarchar(15),
		Email nvarchar(50)
		)
go
insert into Customer values (001, 'Nguyen Huu Thinh', 'Hanoi', 'Vietnam', '0968668874', 'thinhnhth2203007@fpt.edu.vn'),
							(002, 'Mai Xuan Tien', 'Perth', 'Australia', '0988362662', 'tienmxth2202007@fpt.edu.vn'),
							(003, 'Nguyen Thai Duong', 'Hanoi', 'Vietnam', '0962291058', 'duongntth2203008@fpt.edu.vn')

create table CustomerAccount(
		AccountNumber char(9) primary key not null,
		CustomerID int constraint fk_CustomerID foreign key (CustomerID) references Customer(CustomerID) not null,
		Balance money not null,
		MinAccount money
		)
go
insert into CustomerAccount values ('062298', 001, 16000000, 10000000),
									('060290', 002, 18000000, 15000000),
									('121996', 003, 15000000, 12000000)

create table CustomerTransaction(
		TransactionID int primary key not null,
		AccountNumber char(9) constraint fk_AccNumber foreign key (AccountNumber) references CustomerAccount(AccountNumber),
		TransactionDate smalldatetime,
		Amount money,
		DepositorWithdraw bit
)
go
insert into CustomerTransaction values (100, '062298', '06-30-2022 13:00:00', 2000000, 300000),
										(101, '060290', '06-29-2022 14:00:00', 3000000, 500000),
										(102, '121996', '06-30-2022 16:00:00', 2000000, 1200000)

--4. Query to get all customers from Customer table who live in 'Hanoi'
select Name
from Customer
where Customer.City = 'Hanoi'

--5. Query to get customers' account information
select C.Name, Phone, Email
from Customer C
inner join CustomerAccount CA on C.CustomerID = CA.CustomerID
select CA.AccountNumber, Balance
from CustomerAccount CA
inner join Customer C on C.CustomerID = CA.CustomerID

--6. CHECK Constraint for CustomerTransaction Table
alter table CustomerTransaction
	add constraint TransactionCheck check(DepositorWithdraw>0 and DepositorWithdraw<=1000000)
go

--7. Create vCustomerTransactions
create view vCustomerTransactions
as
select CT.TransactionDate, Amount, Depositorwithdraw from CustomerTransaction CT
join CustomerAccount CA
on CT.AccountNumber=CA.AccountNumber
join Customer C
on C.CustomerID = CA.CustomerID