-- Phần I : THIẾT KẾ VÀ KHỞI TẠO CSDL (20 điểm)
-- Câu 1. Tạo CSDL và các bảng 
create database SalesDB;
use SalesDB;
-- Tạo 3 bảng dưới đây với đầy đủ các cột, kiểu dữ liệu và ràng buộc
create table Customers(
customer_id int auto_increment primary key,
customer_name varchar(100) not null,
email varchar(100) unique not null,
phone VARCHAR(15),
address VARCHAR(255)
);
create table Products(
Product_id int auto_increment primary key,
Product_name varchar(100) not null,
price decimal(10,2) CHECK (price > 0), 
category varchar(50)
);
create table Orders(
order_id INT auto_increment primary key,
customer_id int,
foreign key(customer_id) references Customers(customer_id),
Product_id int,
foreign key(Product_id) references Products(Product_id),
quantity INT CHECK (quantity > 0),
order_date DATE
);
-- Câu 2: Thêm dữ liệu (10 điểm)
-- Viết các lệnh để thêm dữ liệu mẫu vào 3 bảng như sau
insert into Customers(customer_name,email,phone,address)
values
('Nguyen Van An', 'an.nguyen@email.com', '0901111111', 'Ha Noi'),
('Tran Thi Binh', 'binh.tran@email.com', '0902222222', 'TP HCM'),
('Le Van Cuong', 'cuong.le@email.com', '0903333333', 'Da Nang'),
('Pham Thi Dung', 'dung.pham@email.com', '0904444444', 'Ha Noi'),
('Hoang Van Em', 'em.hoang@email.com', '0905555555', 'Can Tho'),
('Do Thi Hoa', 'hoa.do@email.com', '0906666666', 'Hai Phong'),
('Vu Van Giang', 'giang.vu@email.com', '0907777777', 'TP HCM'),
('Bui Thi Hang', 'hang.bui@email.com', '0908888888', 'Ha Noi'),
('Ngo Van Hung', 'hung.ngo@email.com', '0909999999', 'Thanh Hoa'),
('Trinh Thi Khoi', 'khoi.trinh@email.com', '0910000000', 'Nghe An');
insert into Products(Product_name,price,category)
values
('Laptop Dell XPS', 25000000, 'Dien Tu'),
('iPhone 15 Pro', 30000000, 'Dien Tu'),
('Ao Thun Nam', 200000, 'Thoi Trang'),
('Giay The Thao', 1500000, 'Thoi Trang'),
('Tu Lanh Samsung', 12000000, 'Dien Lanh'),
('May Giat LG', 9000000, 'Dien Lanh'),
('Ban Phim Co', 1500000, 'Phu Kien'),
('Chuot Khong Day', 500000, 'Phu Kien'),
('Noi Com Dien', 800000, 'Gia Dung'),
('Tai Nghe Bluetooth', 2500000, 'Phu Kien');
insert into Orders(customer_id,product_id,quantity,order_date)
values
(1, 1, 1, '2024-01-10'),
(2, 2, 1, '2024-01-11'),
(3, 3, 5, '2024-01-12'),
(4, 4, 2, '2024-01-13'),
(5, 5, 1, '2024-01-14'),
(6, 6, 1, '2024-01-15'),
(7, 7, 3, '2024-01-16'),
(8, 8, 10, '2024-01-17'),
(9, 9, 2, '2024-01-18'),
(10, 10, 4, '2024-01-19');
-- PHẦN 2: THAO TÁC DỮ LIỆU (DML) 
-- Câu 3: Cập nhật dữ liệu 
-- Cập nhật giá (price) của sản phẩm "iPhone 15 Pro" thành 32000000.
set SQL_SAFE_UPDATE =0 ;
update Products
set price = 32000000
where Product_name = 'iPhone 15 Pro';
-- Cập nhật số lượng (quantity) trong đơn hàng của khách hàng có customer_id = 1 thành 2.
update Orders
set quantity = 2
where customer_id = 1;
-- Câu 4: Cập nhật dữ liệu
delete from Orders where quantity = 10;
delete from Products where Product_name = 'Chuot Khong Day';
-- PHẦN 3: TRUY VẤN DỮ LIỆU
-- Câu 5: Truy vấn cơ bản
-- Lấy ra danh sách khách hàng sống tại địa chỉ (address) là "TP HCM"
select c.customer_name,c.email,c.phone,c.address
from Customers c
where c.address like'TP HCM';
-- Lấy ra danh sách các sản phẩm thuộc danh mục (category) là "Dien Tu"
select p.Product_name,p.price,p.category
from Products p 
where p.category like 'Dien Tu';
-- Lấy ra các sản phẩm có giá (price) lớn hơn 10,000,000
select p.Product_name,p.price,p.category
from Products p 
where p.price >10000000;
-- Tìm kiếm các khách hàng có tên chứa chữ "Dung"
select c.customer_name,c.email,c.phone,c.address
from Customers c
where c.customer_name like '%Dung%';
-- Lấy ra 5 đơn hàng được đặt gần đây nhất
SELECT * FROM Orders
ORDER BY order_date DESC
LIMIT 5;
-- Lấy tên khách hàng, tên sản phẩm, số lượng, ngày đặt
SELECT c.customer_name, p.product_name, o.quantity, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;

-- Tên sản phẩm và giá mà Nguyen Van An đã đặt
SELECT p.product_name, p.price
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.customer_name = 'Nguyen Van An';

-- Tên khách hàng và tổng tiền đơn hàng
SELECT c.customer_name,
       (o.quantity * p.price) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;

-- Sản phẩm chưa có ai mua
SELECT *
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Orders);
-- Thống kê số lượng khách hàng theo từng tỉnh/thành
SELECT address, COUNT(*) AS SoLuongKhach
FROM Customers
GROUP BY address;

-- Thống kê số lượng sản phẩm theo từng danh mục
SELECT category, COUNT(*) AS SoLuongSanPham
FROM Products
GROUP BY category;
