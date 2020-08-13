CREATE DATABASE BOOK_STORE
GO

USE BOOK_STORE
GO

CREATE TABLE Customer (
 CustomerID int PRIMARY KEY IDENTITY,
 CustomerName varchar(50),
 Address varchar(100),
 Phone varchar(12)
 )
 GO

CREATE TABLE Book (
   BookCode int PRIMARY KEY,
   Category varchar(50),
   Author varchar(50),
   Publisher varchar(50),
   Title varchar(100),
   Price int,
   InStore int
)
GO

CREATE TABLE BookSold (
  BookSoldID int PRIMARY KEY,
  CustomerID int,
  BookCode int,
  Date datetime,
  Price int,
  Amount int,
  CONSTRAINT fk_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  CONSTRAINT fk_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
 )

 --1. Chèn ít nhất 5 bản ghi vào bảng Books, 5 bản ghi vào bảng Customer và 10 bản ghi vào bảng  BookSold. 
 INSERT INTO Book VALUES (111, 'Literature', 'Lister', 'Bui Vien', 'Viet cho nhau nghe', 12, 100),
                         (112, 'Economic' ,' Macaer', 'Luong Gia', 'Doc de lam giau', 50, 120),
						 (113, 'Astronomy', 'Hocake', 'Pham Bang', 'Doc de tuong tuong', 23, 101),
						 (114, 'Food','Busicter','Ma Long', 'Doc de an ngon', 20, 90),
						 (115, 'Math', 'LuCak','Hac Hoa', 'Doc de thong minh',40, 50)

INSERT INTO Customer VALUES ( 'Luku', 'A Mat Tinia Glu', '012412412'),
                             ('BigBoy', 'Luu Bang Cai Tiu', ' 12312412'),
							 ('BlueC', 'A Ram Mat', '12312414'),
							 ('HoliShirk','Ngoai Bang Phok', '3452343243'),
							 ( 'Hicrid', 'Thirn Born', '234234234')
INSERT INTO BookSold VALUES (21, 1, 111, '1920-12-5', 15, 10),
                            (22, 2, 112, '1950-5-12', 48, 12),
							(23, 3, 113, '1940-4-2', 26, 10),
							(24, 4, 114, '1962-1-1', 18, 20),
							(25, 5, 115, '1920-1-4', 48, 29)

--2. Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã
--bán được của mỗi cuốn sách. 

CREATE VIEW BookList AS
SELECT Book.BookCode, Title, Book.Price, Amount
FROM Book 
JOIN BookSold
ON BookSold.BookCode = Book.BookCode

--3. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm
--theo số lượng các cuốn sách mà khách hàng đó đã mua. CREATE VIEW CustomerList ASSELECT Customer.CustomerID, CustomerName, Address, BookSold.AmountFROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID--4.. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã
--mua sách vào tháng trước, kèm theo tên các cuốn sách mà khách hàng đã mua. CREATE VIEW CustomerListago1month ASSELECT Customer.CustomerID, CustomerName, Address,Book.CategoryFROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID
JOIN Book
ON Book.BookCode = BookSold.BookCode
WHERE BookSold.Date = DATEADD(month, -1, '1920-2-4')

SELECT * FROM CustomerListago1month 
--Tạo một khung nhìn chứa danh sách các khách hàng kèm theo tổng tiền mà mỗi khách hàng đã chi
--cho việc mua sách. 
CREATE VIEW CustomerSumMoney AS
SELECT Customer.CustomerID, CustomerName, Price * Amount as SUM_Money
FROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID
