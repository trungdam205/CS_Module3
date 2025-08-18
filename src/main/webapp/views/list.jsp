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
        body {
            background-color: #f8f9fa;
        }
        h1 {
            color: #0d6efd;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
        }
        /* Danh sách sự kiện */
        .event-list li a {
            display: block;
            padding: 12px 16px;
            border-radius: 10px;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none; /* Bỏ gạch chân */
            color: #0d6efd; /* Màu xanh */
        }
        .event-list li a:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            text-decoration: none; /* Bảo đảm hover không gạch chân */
            color: #0b5ed7;
        }
        /* Icon vé cố định góc trái dưới */
        .ticket-icon {
            position: fixed;
            bottom: 20px;
            left: 20px;
            background-color: #0d6efd;
            color: white;
            font-size: 20px;
            padding: 14px 18px;
            border-radius: 50px;
            cursor: pointer;
            z-index: 1050;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            transition: background-color 0.3s, transform 0.2s;
        }
        .ticket-icon:hover {
            background-color: #0b5ed7;
            transform: scale(1.05);
        }
        /* Offcanvas vé */
        .offcanvas-ticket {
            width: 400px;
            background-color: #f1f3f5;
        }
        .offcanvas-header {
            border-bottom: 1px solid #dee2e6;
        }
        .ticket-card {
            background: white;
            border-radius: 12px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .ticket-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0,0,0,0.15);
        }
        .ticket-card h6 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.3rem;
        }
        .ticket-card p {
            margin-bottom: 0.25rem;
            font-size: 0.9rem;
        }
        .ticket-card p strong {
            color: #0d6efd;
        }
    </style>
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






