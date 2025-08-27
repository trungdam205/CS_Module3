<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo sự kiện mới</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            <h4 class="mb-0">Thêm sự kiện mới</h4>
        </div>
        <div class="card-body">

            <!-- Hiển thị lỗi server (nếu có) -->
            <div class="alert alert-danger ${empty error ? 'd-none' : ''}">
                ${error}
            </div>

            <form action="${pageContext.request.contextPath}/events" method="post" class="needs-validation"
                  accept-charset="UTF-8" novalidate>
                <input type="hidden" name="action" value="create"/>

                <div class="mb-3">
                    <label class="form-label">Tiêu đề</label>
                    <input type="text" name="title" class="form-control" value="${param.title}" required>
                    <div class="invalid-feedback">Vui lòng nhập tiêu đề</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" class="form-control" rows="3" required>${param.description}</textarea>
                    <div class="invalid-feedback">Vui lòng nhập mô tả</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Địa điểm</label>
                    <input type="text" name="location" class="form-control" value="${param.location}" required>
                    <div class="invalid-feedback">Vui lòng nhập địa điểm</div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ngày tổ chức</label>
<%--                        <input type="text" id="date" name="date" class="form-control"--%>
<%--                               value="${param.date}" required>--%>
                        <input type="text" id="date" name="date" class="form-control"
                               value="${param.date}" required>
                        <div class="invalid-feedback">Vui lòng chọn ngày</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ bắt đầu</label>
<%--                        <input type="text" id="start_time" name="start_time" class="form-control"--%>
<%--                               value="<fmt:formatDate value='${param.start_time}' pattern='HH:mm'/>" required>--%>
                        <input type="text" id="start_time" name="start_time" class="form-control"
                               value="${param.start_time}" required>
                        <div class="invalid-feedback">Chọn giờ bắt đầu</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ kết thúc</label>
<%--                        <input type="text" id="end_time" name="end_time" class="form-control"--%>
<%--                               value="<fmt:formatDate value='${param.end_time}' pattern='HH:mm'/>" required>--%>
                        <input type="text" id="end_time" name="end_time" class="form-control"
                               value="${param.end_time}" required>
                        <div class="invalid-feedback">Chọn giờ kết thúc</div>
                    </div>
                </div>


                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá vé (VNĐ)</label>
                        <input type="number" id="price" name="price" min="0" class="form-control"
                               value="${event.price}" required>
                        <small id="formattedPrice" class="text-muted">
                            Giá hiển thị: 0 VNĐ
                        </small>
                        <div class="invalid-feedback">Giá vé phải >= 0</div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Tổng số vé</label>
                        <input type="number" name="total_tickets" min="1" class="form-control"
                               value="${param.total_tickets}" required>
                        <div class="invalid-feedback">Số vé phải > 0</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ảnh sự kiện (URL)</label>
                        <input type="url" name="imageUrl" class="form-control" value="${param.imageUrl}" required>
                        <div class="invalid-feedback">Vui lòng nhập link ảnh hợp lệ</div>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success px-4">Tạo sự kiện</button>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary px-4">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>

<c:if test="${not empty errorMessage}">
    <script>
        Swal.fire({
            title: "${errorMessage}",
            icon: "error",
            confirmButtonText: "OK"
        });
    </script>
</c:if>

<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            title: "${successMessage}",
            icon: "success",
            confirmButtonText: "Quay lại"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/dashboard";
            }
        });
    </script>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    (() => {
        // === Hiển thị giá tiền ===
        const priceInput = document.getElementById("price");
        const formattedPrice = document.getElementById("formattedPrice");

        const formatCurrency = value =>
            !value ? "0 VNĐ" : new Intl.NumberFormat("vi-VN").format(value) + " VNĐ";

        const updatePrice = () => {
            formattedPrice.textContent = "Giá hiển thị: " + formatCurrency(priceInput.value);
        };

        updatePrice(); // khi load trang
        priceInput.addEventListener("input", updatePrice);

        // === Flatpickr ===
        flatpickr("#start_time", {enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true});
        flatpickr("#end_time", {enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true});
        flatpickr("#date", {
            dateFormat: "Y-m-d",        // format thật sự để submit (server nhận yyyy-MM-dd)
            altInput: true,             // bật input phụ để hiển thị cho người dùng
            altFormat: "d/m/Y",         // format hiển thị cho user (dd/MM/yyyy)
            allowInput: true
        });

        // === Bootstrap validation ===
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
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
