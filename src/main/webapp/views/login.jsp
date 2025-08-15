<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập - Event Ticket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center mb-4">Đăng nhập</h2>

  <!-- Hiển thị thông báo từ AuthServlet -->
  <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
  %>
  <div class="alert alert-danger"><%= message %></div>
  <%
    }
  %>

  <form action="auth" method="post">
    <input type="hidden" name="action" value="login">
    <div class="mb-3">
      <label for="username" class="form-label">Username</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>

    <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
  </form>

  <p class="mt-3 text-center">
    Chưa có tài khoản? <a href="auth?action=register">Đăng ký</a>
  </p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
