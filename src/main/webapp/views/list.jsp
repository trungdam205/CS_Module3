<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 15/08/2025
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"--%>
<%--      integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Danh sách sự kiện</title>--%>
<%--    <link rel="stylesheet" href="assets/bootstrap.min.css">--%>
<%--</head>--%>
<%--<body class="container mt-4">--%>
<%--<h1 class="mb-4">Danh sách sự kiện</h1>--%>

<%--<ul class="list-unstyled">--%>
<%--    <c:forEach var="e" items="${eventList}">--%>
<%--        <li>--%>
<%--            <a href="events?action=detail&id=${e.id}"--%>
<%--               class="fw-bold fs-4 text-primary text-decoration-none">--%>
<%--                    ${e.title}--%>
<%--            </a>--%>
<%--        </li>--%>
<%--    </c:forEach>--%>
<%--</ul>--%>
<%--</body>--%>
<%--</html>--%>



<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Danh sách sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        /* Cố định icon ở góc trái dưới */
        .cart-icon {
            position: fixed;
            bottom: 20px;
            left: 20px;
            background-color: #0d6efd;
            color: white;
            font-size: 28px;
            padding: 12px;
            border-radius: 50%;
            cursor: pointer;
            z-index: 1050;
        }
        .offcanvas-cart {
            width: 350px;
        }
    </style>
</head>
<body class="container mt-4">

<h1 class="mb-4">Danh sách sự kiện</h1>
<ul class="list-unstyled">
    <c:forEach var="e" items="${eventList}">
        <li>
            <a href="events?action=detail&id=${e.id}"
               class="fw-bold fs-4 text-primary text-decoration-none">
                    ${e.title}
            </a>
        </li>
    </c:forEach>
</ul>

<!-- Icon giỏ hàng -->
<div class="cart-icon" data-bs-toggle="offcanvas" data-bs-target="#cartPanel">
    <i class="bi bi-cart-fill"></i>
</div>

<!-- Offcanvas hiển thị giỏ hàng -->
<div class="offcanvas offcanvas-start offcanvas-cart" tabindex="-1" id="cartPanel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Giỏ hàng của bạn</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <c:if test="${empty ticketList}">
            <p>Chưa có vé nào trong giỏ.</p>
        </c:if>
        <c:forEach var="t" items="${ticketList}">
            <div class="card mb-2">
                <div class="card-body p-2">
                    <h6 class="mb-1">${t.eventTitle}</h6>
                    <p class="mb-0">Số vé: <strong>${t.quantity}</strong></p>
                    <p class="mb-0 text-muted">
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



