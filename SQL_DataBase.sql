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

SELECT 
    *
FROM
    user;
    
UPDATE user 
SET 
    role = 'ADMIN'
WHERE
    id = 3;
 
UPDATE user 
SET 
    role = 'USER'
WHERE
    role = 'CUSTOMER' AND id > 0;

 update user set password='user123456' where id = 8;
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
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE events
ADD COLUMN start_time TIME NOT NULL DEFAULT '00:00:00' AFTER date,
ADD COLUMN end_time TIME NOT NULL DEFAULT '00:00:00' AFTER start_time;

INSERT INTO events (title, description, location, date, start_time, end_time, price, total_tickets,image_url)
VALUES 
('[CONCERT ENCORE] ANH TRAI VƯỢT NGÀN CHÔNG GAI DAY7, DAY8', 'chặng cuối của chuỗi hành trình đáng nhớ Anh trai vượt ngàn chông gai 2024', 'Đỗ Xuân Hợp, Tp Thủ Đức, Phường An Phú, Quận 2, Thành Phố Hồ Chí Minh',
 '2025-09-6', '18:30:00', '23:00:00', 500000, 1000,'https://salt.tkbcdn.com/ts/ds/4d/5d/93/c38fa1bc1f9ca5f95b882b12d45883bc.jpg'),
 ('V CONCERT "RẠNG RỠ VIỆT NAM" - CHẠM VÀO ĐỈNH CAO CỦA ÂM NHẠC VÀ CẢM XÚC', 'Sự kiện âm nhạc đỉnh cao quy tụ những nghệ sĩ hàng đầu Việt Nam', 'Sân vận động Mỹ Đình',
 '2025-08-11', '17:00:00', '23:00:00', 8000000, 1000000,'https://laodongthudo.vn/stores/news_dataimages/2025/082025/12/21/san-khau-tu-hao-la-nguoi-viet-nam20250812212606.jpg?rt=20250812212700'),
 ('CONCERT "TỰ HÀO LÀ NGƯỜI VIỆT NAM" - KỶ NIỆM QUỐC KHÁNH 2/9', 'Đêm nhạc quy tụ dàn sao đình đám, hứa hẹn mang đến nhiều cảm xúc bùng nổ', 'Sân vận động Mỹ Đình',
 '2025-08-17', '20:10:00', '22:40:00', 800000, 30000);
 
 update events set image_url='https://salt.tkbcdn.com/ts/ds/39/73/a8/28010109be7d4dea1121714d90cd803e.png' where id =4;
 
 SELECT * FROM EVENTS;
 
 CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    user_name varchar(100) NOT NULL,
    user_email varchar(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    qr_code VARCHAR(200) UNIQUE NOT NULL, -- mã QR để check-in
    image_url VARCHAR(500) not null,
    status ENUM('BOOKED', 'CHECKED_IN') DEFAULT 'BOOKED',
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Thời gian đặt vé
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);



DELIMITER $$
CREATE PROCEDURE insert_ticket(
    IN p_event_id INT,
    IN p_user_name VARCHAR(100),
    IN p_user_email VARCHAR(100),
    IN p_quantity INT,
    IN p_qr_code VARCHAR(255)
)
BEGIN
    INSERT INTO tickets (event_id, user_name, user_email, quantity, qr_code)
    VALUES (p_event_id, p_user_name, p_user_email, p_quantity, p_qr_code);
END$$
DELIMITER ;

select * from tickets;

DELIMITER //
CREATE PROCEDURE GetAllEvents()
BEGIN
    SELECT * FROM events ORDER BY date ASC;
END //
DELIMITER ;

call GetAllEvents();

DELIMITER //
CREATE PROCEDURE GetEventById(IN eventId INT)
BEGIN
    SELECT * FROM events WHERE id = eventId;
END //
DELIMITER ;

select*from tickets

DELIMITER //

CREATE PROCEDURE updateTicketsSold(
    IN p_event_id INT,
    IN p_quantity INT
)
BEGIN
    -- Chỉ update nếu số vé còn lại đủ
    UPDATE events
    SET tickets_sold = tickets_sold + p_quantity
    WHERE id = p_event_id
      AND (total_tickets - tickets_sold) >= p_quantity;

    -- Nếu không update được (rows_affected = 0) thì báo lỗi
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough tickets available';
    END IF;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE getRemainingTickets(IN p_event_id INT)
BEGIN
    SELECT (total_tickets - tickets_sold) AS remaining
    FROM events
    WHERE id = p_event_id;
END //
DELIMITER ;

call getRemainingTickets(1);
select * from tickets;
select * from events;
SELECT *FROM user;

-- lưu/đọc tiếng Việt chính xác trong Java mà không bị lỗi font.
ALTER DATABASE event_ticketing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE user CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



