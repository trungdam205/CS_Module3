<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
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

  <%
    String message = (String) request.getAttribute("message");
    String type = (String) request.getAttribute("type");
    if (message != null) {
  %>
  <div class="alert alert-<%= (type != null ? type : "danger") %>"><%= message %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/auth?action=login" method="post" autocomplete="off">
    <div class="mb-3">
      <label>Email</label>
      <input type="email" name="email" class="form-control" required autocomplete="off">
    </div>
    <div class="mb-3">
      <label>Password</label>
      <input type="password" name="password" class="form-control" required autocomplete="new-password">
    </div>
    <button type="submit" class="btn btn-primary">Đăng nhập</button>
  </form>


  <p class="mt-3 text-center">
    Chưa có tài khoản? <a href="auth?action=register">Đăng ký</a>
  </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
