<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
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

  <!-- Hiển thị thông báo từ AuthServlet -->
  <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
  %>
  <div class="alert alert-info"><%= message %></div>
  <%
    }
  %>

  <form action="auth" method="post">
    <input type="hidden" name="action" value="register">
    <div class="mb-3">
      <label for="username" class="form-label">Username</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>

    <div class="mb-3">
      <label for="fullname" class="form-label">Họ và tên</label>
      <input type="text" class="form-control" id="fullname" name="fullname" required>
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" id="email" name="email" required>
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
