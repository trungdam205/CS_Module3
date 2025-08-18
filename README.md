# CS_Module3
# 🎫 Ứng dụng Quản lý Sự kiện & Đăng ký Vé

## 📌 Giới thiệu
Ứng dụng web giúp người dùng **xem thông tin sự kiện, đặt vé trực tuyến và nhận mã QR để check-in**. Dành cho quản trị viên, hệ thống cung cấp chức năng **quản lý sự kiện và danh sách vé**.

**Công nghệ sử dụng:**
- Backend: Java Servlet/JSP (JDK 1.8, Tomcat 9)
- Database: MySQL 8
- Frontend: HTML5, CSS3, Bootstrap 5
- Thư viện: JDBC, JavaMail API, ZXing (QR Code)

---

## ✨ Tính năng

### 👤 Người dùng
- Xem danh sách sự kiện.
- Xem chi tiết sự kiện.
- Đặt vé (nhập tên, email, số lượng).
- Nhận email xác nhận kèm QR Code.

### 🛠 Quản trị viên
- Đăng nhập (tài khoản cứng).
- CRUD sự kiện.
- Xem danh sách vé.
- Xác nhận check-in qua QR Code.

---

## 🗄 Cấu trúc Database

### Bảng `users`
| Field    | Type         | Ghi chú             |
|----------|--------------|---------------------|
| id       | INT PK AI    | Mã người dùng       |
| name     | VARCHAR(100) | Tên                 |
| email    | VARCHAR(100) | Email               |
| password | VARCHAR(255) | Mật khẩu            |
| role     | ENUM('ADMIN','USER') | Phân quyền |

### Bảng `events`
| Field       | Type         | Ghi chú             |
|-------------|--------------|---------------------|
| id          | INT PK AI    | Mã sự kiện          |
| title       | VARCHAR(200) | Tiêu đề sự kiện     |
| description | TEXT         | Mô tả               |
| location    | VARCHAR(200) | Địa điểm            |
| date        | DATETIME     | Ngày giờ diễn ra    |
| price       | DECIMAL(10,2)| Giá vé              |

### Bảng `tickets`
| Field       | Type         | Ghi chú             |
|-------------|--------------|---------------------|
| id          | INT PK AI    | Mã vé               |
| event_id    | INT FK       | Liên kết sự kiện    |
| user_name   | VARCHAR(100) | Tên người mua       |
| user_email  | VARCHAR(100) | Email người mua     |
| quantity    | INT          | Số lượng vé         |
| qr_code     | VARCHAR(200) | Đường dẫn ảnh QR    |
| status      | ENUM('BOOKED','CHECKED_IN') | Trạng thái vé |

---

## 📂 Cấu trúc thư mục dự án
```
src/
 └── main/
     ├── java/
     │   ├── model/      (Entity + dao)
     │   ├── controller/ (Servlet)
     │   └── util/       (DBConnection, helpers)
     ├── webapp/
     │   ├── WEB-INF/
     │   │    └── web.xml
     │   ├── assets/     (CSS, JS, images)
     │   └── views/      (JSP)
```

---

## 🚀 Cài đặt & Chạy dự án

### 1️⃣ Yêu cầu môi trường
- JDK 1.8
- Apache Tomcat 9
- MySQL 8
- Maven (nếu dùng)

### 2️⃣ Cài đặt database
- Chạy file `schema.sql` để tạo database và bảng.

### 3️⃣ Cấu hình kết nối DB
Chỉnh sửa file `DBConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/event_ticketing";
private static final String USER = "root";
private static final String PASS = "your_password";
```

### 4️⃣ Chạy dự án
- Import project vào Eclipse / IntelliJ.
- Deploy lên Tomcat 9.
- Truy cập: `http://localhost:8080/event-ticketing`

---

## 📸 Demo (sẽ cập nhật)
- Trang chủ hiển thị danh sách sự kiện.
- Form đặt vé.
- Email xác nhận kèm QR Code.
- Admin quản lý sự kiện & vé.

---

## 👥 Nhóm phát triển
- **Thành viên 1** – Backend & Database
- **Thành viên 2** – Frontend & UI
- **Thành viên 3** – Tích hợp & API

---

## 📅 Tiến độ
- Ngày 1: Thiết kế DB, tạo project, kết nối MySQL.
- Ngày 2–3: CRUD sự kiện, vé.
- Ngày 4: Admin Panel.
- Ngày 5: QR Code + Email.
- Ngày 6–7: Hoàn thiện & Demo.

