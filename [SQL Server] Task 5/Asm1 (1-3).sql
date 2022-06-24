IF EXISTS (SELECT * FROM sys.databases WHERE Name='Asm1')
	DROP DATABASE Asm1
GO
CREATE DATABASE Asm1
GO
USE Asm1
GO
--1. Tạo DBs Asm1
create table Customer(
		CusID int primary key,
		Name nvarchar(40) not null,
		Address nvarchar(100) not null,
		Phone varchar(16),
		Status varchar(30) not null)
go
--Status = Khách ưu đãi/Khách thường xuyên, khách thường, etc. của công ty
insert into Customer values (001, N'Nguyễn Văn An', N'Hà Nội', 987654321, 'Khách thường'),
							(002, N'Nguyễn Hữu Thịnh', N'Hà Đông', 968668874, 'Khách hàng ưu đãi'),
							(003, N'Mai Xuân Tiến', N'Hà Nội', 988362662, 'Khách vip')

create table Orders(
		OrderID int primary key,
		CusID int constraint fk_CusID foreign key (CusID) references Customer(CusID),
		OrderDate date not null,
		OrderStatus varchar(30) not null)
go
insert into Orders values (123, 001, 06-10-2022, 'Đang ship'),
						(124, 002, 06-19-2022, 'Mới'),
						(125, 003, 06-20-2022, 'Đang cân nhắc')

create table Product(
		ProductID varchar(100) primary key,
		Name varchar(50) not null,
		Desc varchar(100) not null,
		Unit varchar(20) not null,
		ProductPrice money not null,
		Qty int not null,
		ProdStatus varchar(40) not null
)
go
insert into Product values ('200', 'Máy tính T450', 'Máy mới', 'Chiếc', 1100, 10, 'Mới'),
							('201', 'Điện thoại Nokia 5670', 'Đang hot', 'Chiếc', 180, 20, 'Hot'),
							('202', 'Máy in Samsung 450', 'Đang thừa', 'Chiếc', 120, 30, 'Nhiều bụi'),
							('203', 'iPhone 12', 'Vẫn hot', 'Chiếc', 300, 20, 'Có thể hết'),
							('204', 'Dell XPS 13', 'Đang hot', 'Chiếc', 1200, 10, 'Có thể hết')

create table OrderDetails(
		OrderID int constraint fk_OrderID foreign key (OrderID) references Orders(OrderID),
		ProductID int constraint fk_ProdID foreign key (ProductID) references Product(ProductID),
		OrderPrice money not null,
		OrderQty varchar(50) not null
)
go
insert into OrderDetails values (123, '200, 201, 202', 1500, '1, 2, 1'),
								(124, '203, 204', 1400, '1, 1'),
								(125, '201, 204', 1300, '1, 1')
--2. Tạo bảng trong DBs dựa trên thông tin đơn hàng
/* Có 2 Price và Qty:
- Bảng product: Giá hiện tại và số lượng product hiện có trong công ty
- Bảng orderdetails: Giá thời điểm Customer đặt mua (tương tự với số lượng)
=> Không cần tham chiếu Price và Qty bằng cách đặt khóa phụ cho Price/Qty của OrderDetails. */
--3. Insert dữ liệu (2 bản ghi mới)

select Name from Customer
--4.a. Liệt kê danh sách khách hàng

select Name from Product
--4.b. Liệt kê danh sách sản phẩm

select OrderID from Orders, OrderDetails
where Orders.OrderID=OrderDetails.OrderID
--4.c. Liệt kê danh sách đơn hàng

select Name from Customer
order by Name asc
--5.1. Liệt kê danh sách khách hàng theo thứ tự ABC

select ProductPrice from Product
order by ProductPrice desc
--5.2. Danh sách sản phẩm với giá giảm dần

select ProductID from ((Product
inner join OrderDetails on Product.ProductID = OrderDetails.ProductID)
inner join Customer on Customer.OrderID = OrderDetails.OrderID)
where Customer.Name=N'Nguyễn Văn An'
--5.3. Danh sách sản phẩm (theo ID, nếu theo tên thì select Name from ((Product...) đã mua của khách hàng Nguyễn Văn An

select count(distinct Customer.OrderID)
from Customer, OrderDetails
where Customer.OrderID=OrderDetails.OrderID
--6.1. Đếm số khách hàng đã mua ở cửa hàng

select count(distinct 