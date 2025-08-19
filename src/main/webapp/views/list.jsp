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

<h1>Danh sách sự kiện</h1>

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
        <c:if test="${empty ticketList}">
            <p class="text-muted">Bạn chưa có vé nào.</p>
        </c:if>
        <c:forEach var="t" items="${ticketList}">
            <div class="card mb-2 ticket-card shadow-sm">
                <div class="card-body p-3">
                    <h6>${t.eventTitle}</h6>
                    <p>Số vé: <strong>${t.quantity}</strong></p>
                    <p class="text-muted">
                        <fmt:formatDate value="${t.purchaseTime}" pattern="dd/MM/yyyy HH:mm"/>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>






