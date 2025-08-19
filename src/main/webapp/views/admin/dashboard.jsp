<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/08/2025
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="container-fluid p-4">

<!-- Header -->
<!-- Navbar -->
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4 px-3">
  <div class="container-fluid">
    <!-- Brand -->
    <a class="navbar-brand fw-bold d-flex align-items-center me-auto">
      <i class="bi bi-speedometer2 me-2"></i> Admin Dashboard
    </a>

    <ul class="navbar-nav align-items-center">
      <!-- Link quay lại Events -->
      <li class="nav-item me-3">
        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/events">
          <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
        </a>
      </li>

      <!-- Hiển thị tên admin -->
      <li class="nav-item me-3">
        <span class="navbar-text fw-semibold text-light">
          <i class="bi bi-person-badge"></i>
          Admin: ${sessionScope.user.name}
        </span>
      </li>

      <!-- Đăng xuất -->
      <li class="nav-item">
        <a class="nav-link text-danger fw-semibold" href="${pageContext.request.contextPath}/logout">
          <i class="bi bi-box-arrow-right"></i> Đăng xuất
        </a>
      </li>
    </ul>
  </div>
</nav>


<!-- Tabs -->
<ul class="nav nav-tabs mb-3" id="dashboardTabs">
  <li class="nav-item">
    <a class="nav-link active" data-bs-toggle="tab" href="#events">
      <i class="bi bi-calendar-event"></i> Quản lý sự kiện
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-bs-toggle="tab" href="#tickets">
      <i class="bi bi-ticket-perforated"></i> Danh sách vé
    </a>
  </li>
</ul>

<!-- Tab content -->
<div class="tab-content">
  <!-- Quản lý sự kiện -->
  <div class="tab-pane fade show active" id="events">
    <div class="d-flex justify-content-between mb-2">
      <h5>Danh sách sự kiện</h5>
      <a href="events?action=create" class="btn btn-success btn-sm">
        <i class="bi bi-plus-circle"></i> Thêm sự kiện mới
      </a>
    </div>
    <table class="table table-striped table-hover">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Ngày</th>
        <th>Địa điểm</th>
        <th>Giá</th>
        <th>Hành động</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="e" items="${eventList}">
        <tr>
          <td>${e.id}</td>
          <td>${e.title}</td>
          <td><fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy"/></td>
          <td>${e.location}</td>
          <td>${e.price}</td>
          <td>
            <a href="events?action=edit&id=${e.id}" class="btn btn-sm btn-warning">
              <i class="bi bi-pencil-square"></i>
            </a>
            <a href="events?action=delete&id=${e.id}" class="btn btn-sm btn-danger"
               onclick="return confirm('Bạn có chắc muốn xóa sự kiện này?');">
              <i class="bi bi-trash"></i>
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Danh sách vé -->
  <div class="tab-pane fade" id="tickets">
    <h5 class="mb-3">Danh sách vé đã đặt</h5>
    <table class="table table-bordered table-hover">
      <thead class="table-light">
      <tr>
        <th>ID Vé</th>
        <th>Sự kiện</th>
        <th>Tên người mua</th>
        <th>Email</th>
        <th>Số lượng</th>
        <th>Thời gian mua</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="t" items="${ticketList}">
        <tr>
          <td>${t.id}</td>
          <td>${t.eventTitle}</td>
          <td>${t.userName}</td>
          <td>${t.userEmail}</td>
          <td>${t.quantity}</td>
          <td><fmt:formatDate value="${t.purchaseTime}" pattern="dd/MM/yyyy HH:mm"/></td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

