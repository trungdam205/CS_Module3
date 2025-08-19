<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký - Event Ticket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center mb-4">Đăng ký tài khoản</h2>

  <%
    String message = (String) request.getAttribute("message");
    String type = (String) request.getAttribute("type");
    if (message != null) {
  %>
  <div class="alert alert-<%= (type != null ? type : "info") %>"><%= message %></div>
  <% } %>

  <form action="auth" method="post" accept-charset="UTF-8">
    <input type="hidden" name="action" value="register">

    <!-- input ẩn để tránh trình duyệt điền tự động -->
    <input type="text" style="display:none">
    <input type="password" style="display:none">

    <div class="mb-3">
      <label for="name" class="form-label">Họ và tên</label>
      <input type="text" class="form-control" id="name" name="name" required>
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="text" class="form-control" id="new_email" name="new_email" required autocomplete="off">
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="new_password" name="new_password" required autocomplete="new-password">
    </div>

    <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
  </form>

  <p class="mt-3 text-center">
    Đã có tài khoản? <a href="auth?action=login">Đăng nhập</a>
  </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
