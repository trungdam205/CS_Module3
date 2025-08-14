create database event_ticketing;
use event_ticketing;

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'USER') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 insert into user (name,email,password) values 
 ('Nguyễn Trọng Tài','nguyentrongtai@gmail.com','admin123456'),
 ('Đàm Quang Trung','damquangtrung@gmail.com','admin123456'),
 ('Nguyễn Việt Anh','nguyenvietanh@gmail.com','admin123456');
  insert into user (name,email,password) values 
('Nguyễn Anh Tú','nguyenanhtu@gmail.com','user123456');

select * from user;
 update user set role ='ADMIN' where id =3;
 
UPDATE user
SET role = 'USER'
WHERE role = 'CUSTOMER' AND id > 0;

ALTER TABLE user
MODIFY COLUMN role ENUM('ADMIN', 'USER') DEFAULT 'USER';
 
-- ### Bảng `events`
-- | Field         | Type         | Ghi chú             |
-- |-------------  |--------------|---------------------|
-- | id            | INT PK AI    | Mã sự kiện          |
-- | title         | VARCHAR(200) | Tiêu đề sự kiện     |
-- | description   | TEXT         | Mô tả               |
-- | location      | VARCHAR(200) | Địa điểm            |
-- | date          | DATETIME     | Ngày giờ diễn ra    |
-- | price         | DECIMAL(10,2)| Giá vé              |
-- | total_tickets | int          | tổng số vé có thể bán|
-- | tickets_sold  | int          | số vé đã bán        |
-- | created_at    | timestamp    | thời gian dữ liệu thêm vào|
 CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    location VARCHAR(200) NOT NULL,
    date DATETIME NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    total_tickets INT NOT NULL,
    tickets_sold INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 

 select * from events;
 
 insert into events (title, description,location,date,price,total_tickets) values 
 ('V Concert','concert quốc gia','Sân vận động Mỹ Đình','2025-08-11',8000000,1000000);
 
 
 CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    user_name varchar(100) NOT NULL,
    user_email varchar(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    qr_code VARCHAR(200) UNIQUE NOT NULL, -- mã QR để check-in
    status ENUM('BOOKED', 'CHECKED_IN') DEFAULT 'BOOKED',
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Thời gian đặt vé
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

select * from tickets;


