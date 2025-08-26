<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo sự kiện mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Flatpickr CSS -->
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
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

                <%--                <div class="row">--%>
                <%--                    <div class="col-md-4 mb-3">--%>
                <%--                        <label class="form-label">Ngày tổ chức</label>--%>
                <%--                        <input type="date" name="date" class="form-control" value="${param.date}" required>--%>
                <%--                        <div class="invalid-feedback">Vui lòng chọn ngày</div>--%>
                <%--                    </div>--%>
                <%--                    <div class="col-md-4 mb-3">--%>
                <%--                        <label class="form-label">Giờ bắt đầu</label>--%>
                <%--                        <input type="time" name="start_time" class="form-control" value="${param.start_time}" required>--%>
                <%--                        <div class="invalid-feedback">Chọn giờ bắt đầu</div>--%>
                <%--                    </div>--%>
                <%--                    <div class="col-md-4 mb-3">--%>
                <%--                        <label class="form-label">Giờ kết thúc</label>--%>
                <%--                        <input type="time" name="end_time" class="form-control" value="${param.end_time}" required>--%>
                <%--                        <div class="invalid-feedback">Chọn giờ kết thúc</div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ngày tổ chức</label>
                        <input type="text" id="date" name="date" class="form-control"
                               value="${param.date}" required>
                        <div class="invalid-feedback">Vui lòng chọn ngày</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ bắt đầu</label>
                        <input type="text" id="start_time" name="start_time" class="form-control"
                               value="<fmt:formatDate value='${param.start_time}' pattern='HH:mm'/>" required>
                        <div class="invalid-feedback">Chọn giờ bắt đầu</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giờ kết thúc</label>
                        <input type="text" id="end_time" name="end_time" class="form-control"
                               value="<fmt:formatDate value='${param.end_time}' pattern='HH:mm'/>" required>
                        <div class="invalid-feedback">Chọn giờ kết thúc</div>
                    </div>
                </div>


                <div class="row">
                    <%--                    <div class="col-md-4 mb-3">--%>
                    <%--                        <label class="form-label">Giá vé (VNĐ)</label>--%>
                    <%--                        <input type="number" name="price" min="0" class="form-control" value="${param.price}">--%>
                    <%--                        <div class="invalid-feedback">Giá vé phải >= 0</div>--%>
                    <%--                    </div>--%>

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
</body>
</html>
