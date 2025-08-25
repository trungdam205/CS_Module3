<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: admin--%>
<%--  Date: 25/08/2025--%>
<%--  Time: 17:32--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>--%>

<%--<!DOCTYPE html>--%>
<%--<html lang="vi">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <title>Chỉnh sửa sự kiện</title>--%>
<%--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body class="bg-light">--%>

<%--<div class="container mt-5">--%>
<%--  <div class="card shadow-lg rounded-3">--%>
<%--    <div class="card-header bg-primary text-white text-center">--%>
<%--      <h4 class="mb-0">Chỉnh sửa sự kiện</h4>--%>
<%--    </div>--%>
<%--    <div class="card-body">--%>

<%--      <form action="${pageContext.request.contextPath}/events" method="post" class="needs-validation" novalidate>--%>
<%--        <input type="hidden" name="action" value="update"/>--%>
<%--        <input type="hidden" name="id" value="${event.id}"/>--%>

<%--        <!-- Tiêu đề -->--%>
<%--        <div class="mb-3">--%>
<%--          <label class="form-label">Tiêu đề</label>--%>
<%--          <input type="text" name="title" class="form-control"--%>
<%--                 value="${fn:escapeXml(event.title)}" required>--%>
<%--          <div class="invalid-feedback">Vui lòng nhập tiêu đề</div>--%>
<%--        </div>--%>

<%--        <!-- Mô tả -->--%>
<%--        <div class="mb-3">--%>
<%--          <label class="form-label">Mô tả</label>--%>
<%--          <textarea name="description" class="form-control" rows="3" required>${fn:escapeXml(event.description)}</textarea>--%>
<%--          <div class="invalid-feedback">Vui lòng nhập mô tả</div>--%>
<%--        </div>--%>

<%--        <!-- Địa điểm -->--%>
<%--        <div class="mb-3">--%>
<%--          <label class="form-label">Địa điểm</label>--%>
<%--          <input type="text" name="location" class="form-control" value="${fn:escapeXml(event.location)}" required>--%>
<%--          <div class="invalid-feedback">Vui lòng nhập địa điểm</div>--%>
<%--        </div>--%>

<%--        <!-- Ngày/Giờ -->--%>
<%--        <div class="row">--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Ngày tổ chức</label>--%>
<%--            <input type="date" name="date" class="form-control"--%>
<%--                   value="<fmt:formatDate value='${event.date}' pattern='yyyy-MM-dd'/>" required>--%>
<%--            <div class="invalid-feedback">Vui lòng chọn ngày</div>--%>
<%--          </div>--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Giờ bắt đầu</label>--%>
<%--            <input type="time" name="start_time" class="form-control"--%>
<%--                   value="<fmt:formatDate value='${event.start_time}' pattern='HH:mm'/>" required>--%>
<%--            <div class="invalid-feedback">Chọn giờ bắt đầu</div>--%>
<%--          </div>--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Giờ kết thúc</label>--%>
<%--            <input type="time" name="end_time" class="form-control"--%>
<%--                   value="<fmt:formatDate value='${event.end_time}' pattern='HH:mm'/>" required>--%>
<%--            <div class="invalid-feedback">Chọn giờ kết thúc</div>--%>
<%--          </div>--%>
<%--        </div>--%>

<%--        <!-- Giá vé / Tổng số vé / Ảnh -->--%>
<%--        <div class="row">--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Giá vé (VNĐ)</label>--%>
<%--            <input type="number" name="price" min="0" class="form-control" value="${event.price}" required>--%>
<%--            <small class="text-muted">--%>
<%--              Giá hiển thị: <fmt:formatNumber value="${event.price}" pattern="#,###"/> VNĐ--%>
<%--            </small>--%>
<%--            <div class="invalid-feedback">Giá vé phải >= 0</div>--%>
<%--          </div>--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Tổng số vé</label>--%>
<%--            <input type="number" name="total_tickets" min="1" class="form-control" value="${event.total_tickets}" required>--%>
<%--            <div class="invalid-feedback">Số vé phải > 0</div>--%>
<%--          </div>--%>
<%--          <div class="col-md-4 mb-3">--%>
<%--            <label class="form-label">Ảnh sự kiện (URL)</label>--%>
<%--            <input type="url" name="imageUrl" class="form-control" value="${fn:escapeXml(event.imageUrl)}" required>--%>
<%--            <div class="invalid-feedback">Vui lòng nhập link ảnh hợp lệ</div>--%>
<%--          </div>--%>
<%--        </div>--%>

<%--        <div class="text-center">--%>
<%--          <button type="submit" class="btn btn-success px-4">Chỉnh sửa</button>--%>
<%--          <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary px-4">Hủy</a>--%>
<%--        </div>--%>
<%--      </form>--%>

<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--<script>--%>
<%--  (() => {--%>
<%--    'use strict'--%>
<%--    const forms = document.querySelectorAll('.needs-validation')--%>
<%--    Array.from(forms).forEach(form => {--%>
<%--      form.addEventListener('submit', event => {--%>
<%--        if (!form.checkValidity()) {--%>
<%--          event.preventDefault()--%>
<%--          event.stopPropagation()--%>
<%--        }--%>
<%--        form.classList.add('was-validated')--%>
<%--      }, false)--%>
<%--    })--%>
<%--  })()--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>


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
  <!-- Flatpickr CSS -->
  <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="card shadow-lg rounded-3">
    <div class="card-header bg-primary text-white text-center">
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
          <textarea name="description" class="form-control" rows="3" required>${fn:escapeXml(event.description)}</textarea>
          <div class="invalid-feedback">Vui lòng nhập mô tả</div>
        </div>

        <!-- Địa điểm -->
        <div class="mb-3">
          <label class="form-label">Địa điểm</label>
          <input type="text" name="location" class="form-control" value="${fn:escapeXml(event.location)}" required>
          <div class="invalid-feedback">Vui lòng nhập địa điểm</div>
        </div>

        <!-- Ngày/Giờ -->
        <div class="row">
          <div class="col-md-4 mb-3">
            <label class="form-label">Ngày tổ chức</label>
            <input type="date" name="date" class="form-control"
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
            <label class="form-label">Giá vé (VNĐ)</label>
            <input type="number" name="price" min="0" class="form-control" value="${event.price}" required>
            <small class="text-muted">
              Giá hiển thị: <fmt:formatNumber value="${event.price}" pattern="#,###"/> VNĐ
            </small>
            <div class="invalid-feedback">Giá vé phải >= 0</div>
          </div>
          <div class="col-md-4 mb-3">
            <label class="form-label">Tổng số vé</label>
            <input type="number" name="total_tickets" min="1" class="form-control" value="${event.total_tickets}" required>
            <div class="invalid-feedback">Số vé phải > 0</div>
          </div>
          <div class="col-md-4 mb-3">
            <label class="form-label">Ảnh sự kiện (URL)</label>
            <input type="url" name="imageUrl" class="form-control" value="${fn:escapeXml(event.imageUrl)}" required>
            <div class="invalid-feedback">Vui lòng nhập link ảnh hợp lệ</div>
          </div>
        </div>

        <div class="text-center">
          <button type="submit" class="btn btn-success px-4">Chỉnh sửa</button>
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
  flatpickr("#start_time", { enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true });
  flatpickr("#end_time", { enableTime: true, noCalendar: true, dateFormat: "H:i", time_24hr: true });

  // Bootstrap validation
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


