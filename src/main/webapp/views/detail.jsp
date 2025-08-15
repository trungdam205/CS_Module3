<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 15/08/2025
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<html>
<head>
    <title>Chi tiết sự kiện</title>
    <link rel="stylesheet" href="assets/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body class="container mt-4">
<h1 class="mb-4">Chi tiết sự kiện</h1>

<div class="card p-3 fw-bold">
    <h2>${event.title}</h2>
    <p>
        <i class="bi bi-geo-alt-fill"></i>
        <span class="text-success">${event.location}</span>
    </p>
    <p>
        <i class="bi bi-calendar-minus-fill"></i>
        <fmt:formatDate value="${event.date}" pattern="dd/MM/yyyy"/>
    </p>
    <p>
        <i class="bi bi-cash-coin"></i>
        <fmt:formatNumber value="${event.price}" type="number" groupingUsed="true"/> VND
    </p>
    <p><b>Mô tả:</b> ${event.description}</p>

    <a href="events" class="btn btn-secondary mt-3">⬅ Quay lại danh sách</a>
</div>
</body>
</html>

