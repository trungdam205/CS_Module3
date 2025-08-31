<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25/08/2025
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
    <!-- Flatpickr CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4 rounded px-3" style="background-color: #2DC275;">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard"
           style="font-family: 'Montserrat', sans-serif; font-size: 2rem; font-weight: 700; color: white;">
            <i class="bi bi-star"></i> ConcertStar
        </a>
        <ul class="navbar-nav ms-auto align-items-center">

            <%-- quay lại event--%>
            <li class="nav-item me-3">
                <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/events">
                    <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
                </a>
            </li>

            <!-- Hiển thị tên người dùng -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle fw-semibold text-light" href="#"
                   role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="navbar-text fw-semibold text-light">
                      <i class="bi bi-person-badge"></i>
                      Admin: ${sessionScope.user.name}
                    </span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">

                    <%-- quay lại event--%>
                    <li class="nav-item me-3">
                        <a class="nav-link text-success fw-semibold"
                           href="${pageContext.request.contextPath}/events">
                            <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
                        </a>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <!-- Đăng xuất -->
                    <li>
                        <a class="dropdown-item text-danger fw-semibold"
                           href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <div class="card bg-light text-dark shadow-lg rounded">
        <div class="card-header bg-success text-white text-center">
            <h4 class="mb-0">Chỉnh sửa sự kiện</h4>
        </div>
        <div class="card-body">

            <form action="${pageContext.request.contextPath}/events" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="${event.id}"/>

                <!-- Tiêu đề -->
                <div class="mb-3">
                    <label class="form-label">Tiêu đề</label>
                    <input type="text" name="title" class="form-control"
                           value="${fn:escapeXml(event.title)}" required>
                    <div class="invalid-feedback">Vui lòng nhập tiêu đề</div>
                </div>

                <!-- Mô tả -->
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" class="form-control" rows="3"
                              required>${fn:escapeXml(event.description)}</textarea>
                    <div class="invalid-feedback">Vui lòng nhập mô tả</div>
                </div>

                <!-- Địa điểm -->
                <div class="mb-3">
                    <label class="form-label">Địa điểm</label>
                    <input type="text" name="location" class="form-control" value="${fn:escapeXml(event.location)}"
                           required>
                    <div class="invalid-feedback">Vui lòng nhập địa điểm</div>
                </div>

                <!-- Ngày/Giờ -->
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ngày tổ chức</label>
                        <input type="text" id="date" name="date" class="form-control"
                               value="<fmt:formatDate value='${event.date}' pattern='yyyy-MM-dd'/>" required>
                        <div class="invalid-feedback">Vui lòng chọn ngày</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ bắt đầu</label>
                        <input type="text" id="start_time" name="start_time" class="form-control"
                               value="<fmt:formatDate value='${event.start_time}' pattern='HH:mm'/>" required>
                        <div class="invalid-feedback">Chọn giờ bắt đầu</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ kết thúc</label>
                        <input type="text" id="end_time" name="end_time" class="form-control"
                               value="<fmt:formatDate value='${event.end_time}' pattern='HH:mm'/>" required>
                        <div class="invalid-feedback">Chọn giờ kết thúc</div>
                    </div>
                </div>

                <!-- Giá vé / Tổng số vé / Ảnh -->
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá</label>
                        <input type="number" id="priceInput" name="price" min="0"
                               class="form-control" value="${event.price}" required>

                        <small class="text-muted">
                            Giá:
                            <span id="formattedPrice">
                               <fmt:formatNumber value="${event.price}" pattern="#,###"/>
                            </span> VNĐ
                        </small>

                        <div class="invalid-feedback">Giá vé phải >= 0</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Tổng số vé</label>
                        <input type="number" name="total_tickets" min="1" class="form-control"
                               value="${event.total_tickets}" required>
                        <div class="invalid-feedback">Số vé phải > 0</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ảnh sự kiện (URL)</label>
                        <input type="url" name="imageUrl" class="form-control" value="${fn:escapeXml(event.imageUrl)}"
                               required>
                        <div class="invalid-feedback">Vui lòng nhập link ảnh hợp lệ</div>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success px-4" id="btnUpdate">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary px-4">Hủy</a>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>

    document.getElementById("btnUpdate").addEventListener("click", function(e) {
        e.preventDefault(); // chặn submit ngay lập tức

        Swal.fire({
            title: "Cập nhật thành công!",
            icon: "success",
            draggable: true
        }).then((result) => {
            if (result.isConfirmed || result.isDismissed) {
                // Sau khi bấm OK thì submit form thật
                e.target.closest("form").submit();
            }
        });
    });

    flatpickr("#start_time", {enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true});
    flatpickr("#end_time", {enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true});
    flatpickr("#date", {
        dateFormat: "Y-m-d",        // format thật sự để submit (server nhận yyyy-MM-dd)
        altInput: true,             // bật input phụ để hiển thị cho người dùng
        altFormat: "d/m/Y",         // format hiển thị cho user (dd/MM/yyyy)
        allowInput: true
    });
    // Bootstrap validation
    (() => {
        const priceInput = document.getElementById("priceInput");
        const formattedPrice = document.getElementById("formattedPrice");

        priceInput.addEventListener("input", () => {
            const value = priceInput.value;
            if (value) {
                formattedPrice.textContent = new Intl.NumberFormat('vi-VN').format(value);
            } else {
                formattedPrice.textContent = "0";
            }
        });

        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

<footer class="text-light pt-5 pb-4 mt-5" style="background-color: #1D1D1D;">
    <div class="container">
        <div class="row">
            <!-- Logo + giới thiệu -->
            <div class="col-md-4 mb-3">
                <h4 class="fw-bold">
                    <i class="bi bi-star"></i> ConcertStar
                </h4>
                <span class="text-white-50">
                    Nền tảng đặt vé sự kiện âm nhạc hàng đầu Việt Nam.
                </span><br>
                <span class="text-white-50">&copy; 2025 ConcertStar. All rights reserved.</span>
            </div>

            <!-- Liên kết nhanh -->
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Liên kết nhanh</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-white-50">Giới thiệu</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Sự kiện</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Liên hệ</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Chính sách bảo mật</a></li>
                </ul>
            </div>

            <!-- Mạng xã hội -->
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Kết nối với chúng tôi</h5>
                <div class="d-flex gap-3">
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-twitter-x"></i></a>
                </div>
            </div>
        </div>
    </div>
</footer>

</body>
</html>


