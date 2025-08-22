<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo sự kiện mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg rounded-3">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">Thêm sự kiện mới</h4>
        </div>
        <div class="card-body">

            <!-- Hiển thị lỗi server (nếu có) -->
            <div class="alert alert-danger ${empty error ? 'd-none' : ''}">
                ${error}
            </div>

            <form action="${pageContext.request.contextPath}/events" method="post" class="needs-validation" novalidate>
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
                        <input type="date" name="date" class="form-control" value="${param.date}" required>
                        <div class="invalid-feedback">Vui lòng chọn ngày</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ bắt đầu</label>
                        <input type="time" name="start_time" class="form-control" value="${param.start_time}" required>
                        <div class="invalid-feedback">Chọn giờ bắt đầu</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ kết thúc</label>
                        <input type="time" name="end_time" class="form-control" value="${param.end_time}" required>
                        <div class="invalid-feedback">Chọn giờ kết thúc</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá vé (VNĐ)</label>
                        <input type="number" name="price" min="0" class="form-control" value="${param.price}" required>
                        <div class="invalid-feedback">Giá vé phải >= 0</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Tổng số vé</label>
                        <input type="number" name="total_tickets" min="1" class="form-control" value="${param.total_tickets}" required>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap client-side validation
    (() => {
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
</body>
</html>
