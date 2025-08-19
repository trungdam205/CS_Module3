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
    <link href="assets/css/style_List.css" rel="stylesheet">
</head>
<body class="container mt-4">

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4 rounded px-3">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/events">
            <i class="bi bi-calendar-event"></i> Event Manager
        </a>
        <ul class="navbar-nav ms-auto align-items-center">

            <!-- Nếu là ADMIN thì hiện Dashboard -->
            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <li class="nav-item me-3">
                    <a class="nav-link text-primary fw-semibold" href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
            </c:if>

            <!-- Hiển thị tên người dùng -->
            <li class="nav-item me-3">
                <span class="navbar-text fw-semibold text-primary">
                    <i class="bi bi-person-circle"></i>
                    Xin chào, ${sessionScope.user.name}
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



<ul class="list-unstyled event-list">
    <c:forEach var="e" items="${eventList}">
        <li class="mb-3">
            <a href="events?action=detail&id=${e.id}">
                    ${e.title}
            </a>
        </li>
    </c:forEach>
</ul>

<!-- Icon vé cố định góc trái dưới -->
<div class="ticket-icon" data-bs-toggle="offcanvas" data-bs-target="#ticketPanel">
    <i class="bi bi-ticket-fill"></i>
    <span>Vé của tôi</span>
</div>

<!-- Offcanvas hiển thị vé của người dùng -->
<div class="offcanvas offcanvas-start offcanvas-ticket" tabindex="-1" id="ticketPanel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Vé của tôi</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <!-- Nếu user chưa có vé -->
        <c:if test="${empty ticketList}">
            <p class="text-muted">Bạn chưa có vé nào.</p>
        </c:if>

        <!-- Hiển thị vé -->
        <c:forEach var="t" items="${ticketList}">
            <div class="card mb-2 ticket-card shadow-sm">
                <div class="card-body p-3">
                    <h6 class="fw-bold">${t.eventTitle}</h6>
                    <p>Số vé: <strong>${t.quantity}</strong></p>
                    <p>Tổng giá:
                        <strong>
                            <fmt:formatNumber value="${t.totalPrice}" type="number" groupingUsed="true"/> VND
                        </strong>
                    </p>
                    <p>Trạng thái:
                        <strong style="color:
                        <c:choose>
                        <c:when test="${t.status == 'Sự kiện đã kết thúc'}">red</c:when>
                        <c:when test="${t.status == 'Sự kiện đang diễn ra'}">green</c:when>
                        <c:otherwise>black</c:otherwise>
                        </c:choose>;">
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



