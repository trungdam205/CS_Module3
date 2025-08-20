<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 15/08/2025
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Danh sách sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
</head>
<body class="bg-dark text-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4 rounded px-3" style="background-color: #2DC275;">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/events"
           style="font-family: 'Montserrat', sans-serif; font-size: 2rem; font-weight: 700; color: white;">
            <i class="bi bi-star"></i> ConcertStar
        </a>
        <ul class="navbar-nav ms-auto align-items-center">

            <!-- Nếu là ADMIN thì hiện Dashboard -->
            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <li class="nav-item me-3">
                    <a class="nav-link text-light fw-semibold"
                       href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
            </c:if>

            <!-- Nút Vé của tôi -->
            <li class="nav-item me-3">
                <a class="btn d-flex align-items-center fw-semibold text-light"
                   data-bs-toggle="offcanvas"
                   data-bs-target="#ticketPanel"
                   style=" cursor: pointer;">
                    <i class="bi bi-ticket-perforated me-1"></i> Vé của tôi
                </a>
            </li>

            <!-- Hiển thị tên người dùng -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle fw-semibold text-light" href="#"
                   role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle"></i>
                    ${sessionScope.user.name}
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <!-- Vé của tôi -->
                    <li>
                        <a class="dropdown-item" href="#"
                           data-bs-toggle="offcanvas" data-bs-target="#ticketPanel">
                            <i class="bi bi-ticket-perforated text-success"></i> Vé của tôi
                        </a>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <!-- Đăng xuất -->
                    <li>
                        <a class="dropdown-item text-danger fw-semibold"
                           href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>


<!-- Danh sách sự kiện -->
<div class="container my-4">
    <div class="row g-4">
        <c:forEach var="e" items="${eventList}">
            <div class="col-md-4">
                <div class="card bg-dark text-light h-100 d-flex flex-column shadow-sm">

                    <!-- Ảnh sự kiện -->
                    <c:choose>
                        <c:when test="${not empty e.imageUrl}">
                            <img src="${e.imageUrl}" alt="${e.title}" class="card-img-top">
                        </c:when>
                        <c:otherwise>
                            <img src="assets/img/placeholder-event.jpg" alt="No image" class="card-img-top">
                        </c:otherwise>
                    </c:choose>

                    <!-- Nội dung card -->
                    <div class="card-body flex-grow-1 d-flex flex-column justify-content-between">
                        <div>
                            <h6 class="card-title">
                                <a href="events?action=detail&id=${e.id}" class="text-decoration-none text-info">
                                        ${e.title}
                                </a>
                            </h6>

                            <p class="card-text small">
                                <i class="bi bi-calendar-event"></i>
                                <span>
                                        <fmt:formatDate value="${e.start_time}" pattern="HH:mm"/> -
                                        <fmt:formatDate value="${e.end_time}" pattern="HH:mm"/>
                                        <fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy"/>
                                </span>
                            </p>
                        </div>

                        <!-- Nút chi tiết -->
                        <div class="mt-3">
                            <a href="events?action=detail&id=${e.id}" class="btn btn-outline-info w-100">
                                <i class="bi bi-info-circle"></i> Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<!-- Offcanvas hiển thị vé của người dùng -->
<div class="offcanvas offcanvas-start bg-dark text-light" tabindex="-1" id="ticketPanel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Vé của tôi</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <!-- Nếu user chưa có vé -->
        <c:if test="${empty ticketList}">
            <p class="text-muted">Bạn chưa có vé nào.</p>
        </c:if>

        <!-- Hiển thị vé -->
        <c:forEach var="t" items="${ticketList}">
            <div class="card bg-dark text-light mb-2 shadow-sm">
                <div class="card-body p-3">
                    <a class="fw-bold text-decoration-none text-info"
                       href="events?action=detail&id=${t.eventId}">${t.eventTitle}
                    </a>
                    <p>
                        Ngày mua:
                        <span>
                            <fmt:formatDate value="${t.purchase_date}" pattern="dd/MM/yyyy"/>
                        </span>
                    </p>
                    <p>Số vé: <strong>${t.quantity}</strong></p>
                    <p>Tổng:
                        <strong>
                            <fmt:formatNumber value="${t.totalPrice}" type="number" groupingUsed="true"/> VND
                        </strong>
                    </p>

                    <p>Trạng thái:
                        <strong class="
                            <c:choose>
                                <c:when test='${t.status == "Sự kiện đã kết thúc"}'>text-danger</c:when>
                                <c:when test='${t.status == "Sự kiện đang diễn ra"}'>text-success</c:when>
                                <c:otherwise>text-light</c:otherwise>
                            </c:choose>">
                                ${t.status}
                        </strong>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
