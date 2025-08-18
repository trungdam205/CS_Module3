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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<div class="event-detail-container d-flex flex-wrap">
    <!-- Thông tin bên trái -->
    <div class="event-info col-md-6 p-4 position-relative">
        <h4 class="text-white fw-bold">${event.title}</h4>
        <p class="text-success mb-1">
            <i class="bi bi-calendar-event"></i>
            <fmt:formatDate value="${event.start_time}" pattern="HH:mm"/> -
            <fmt:formatDate value="${event.end_time}" pattern="HH:mm"/>,
            <fmt:formatDate value="${event.date}" pattern="dd/MM/yyyy"/>
        </p>
        <p class="text-success mb-1">
            <i class="bi bi-geo-alt-fill"></i> ${event.location}
        </p>
        <p class="text-success mb-1">
            <i class="bi bi-cash-coin"></i> Giá từ
            <fmt:formatNumber value="${event.price}" type="number" groupingUsed="true"/> VND
        </p>
        <p class="text-success">Còn lại: ${remainingTickets} vé</p>

        <div class="mt-4">
            <a href="tickets?action=create&eventId=${event.id}" class="btn btn-primary me-2">Mua vé</a>
            <a href="events" class="btn btn-secondary">⬅ Quay lại</a>
        </div>

        <!-- Divider tròn giữa 2 phần -->
        <div class="divider-circle d-none d-md-block"></div>
    </div>

    <!-- Ảnh bên phải -->
    <div class="event-image col-md-6 p-0">
        <img src="${event.imageUrl}" alt="Event Image" class="img-fluid h-100 w-100 object-fit-cover rounded-end shadow">
    </div>
</div>

<style>
    .event-detail-container {
        min-height: 450px;
        background-color: #2b2b3b;
        border-radius: 15px;
        overflow: hidden;
    }

    .event-info {
        background-color: #3a3a4d;
        color: white;
        border-top-left-radius: 15px;
        border-bottom-left-radius: 15px;
        position: relative;
    }

    .event-image img {
        object-fit: cover;
    }

</style>

</body>
</html>

