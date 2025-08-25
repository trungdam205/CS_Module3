<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/08/2025
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/style_dashboard.css">
</head>
<body class="bg-dark text-light">
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4 rounded px-3" style="background-color: #2DC275;">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/events"
           style="font-family: 'Montserrat', sans-serif; font-size: 2rem; font-weight: 700; color: white;">
            <i class="bi bi-star"></i> ConcertStar
        </a>
        <ul class="navbar-nav ms-auto align-items-center">

            <%-- quay lại event--%>
            <li class="nav-item me-3">
                <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/events">
                    <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
                </a>
            </li>

            <!-- Hiển thị tên người dùng -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle fw-semibold text-light" href="#"
                   role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="navbar-text fw-semibold text-light">
                      <i class="bi bi-person-badge"></i>
                      Admin: ${sessionScope.user.name}
                    </span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">

                    <%-- quay lại event--%>
                    <li class="nav-item me-3">
                        <a class="nav-link text-success fw-semibold"
                           href="${pageContext.request.contextPath}/events">
                            <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
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


<!-- Tabs -->
<div class="container mt-4">
    <ul class="nav nav-pills mb-3" id="dashboardTabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#events">
                <i class="bi bi-calendar-event"></i> Quản lý sự kiện
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#tickets">
                <i class="bi bi-ticket-perforated"></i> Danh sách vé
            </a>
        </li>
    </ul>


    <!-- Tab content -->
    <div class="tab-content">
        <!-- Quản lý sự kiện -->
        <div class="tab-pane fade show active" id="events">
            <div class="d-flex justify-content-end mb-3">
                <a href="events?action=create" class="btn btn-info">
                    <i class="bi bi-plus-circle"></i> Thêm sự kiện mới
                </a>
            </div>

            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header text-white fw-bold text-center fs-4" style="background-color:#3A3A4E;">
                    Danh sách sự kiện
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                        <table class="table table-bordered table-hover align-middle mb-0">
                            <thead class="text-center">
                            <tr>
                                <th>ID</th>
                                <th>Tiêu đề</th>
                                <th>Ngày</th>
                                <th>Địa điểm</th>
                                <th>Giá (VND)</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty eventList}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">Chưa có sự kiện nào.</td>
                                </tr>
                            </c:if>

                            <c:forEach var="e" items="${eventList}">
                                <tr>
                                    <td class="text-center fw-semibold">${e.id}</td>
                                    <td>${e.title}</td>
                                    <td class="text-center">
                                        <fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>${e.location}</td>
                                    <td class="text-end fw-bold text-success">
                                        <fmt:formatNumber value="${e.price}" type="number" groupingUsed="true"/>
                                    </td>
                                    <td class="text-center">
                                        <a href="events?action=update&id=${e.id}" class="btn btn-sm btn-warning me-1">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="events?action=delete&id=${e.id}" class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa sự kiện này?');">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <!-- Danh sách vé -->
        <div class="tab-pane fade" id="tickets">
            <div class="card-header text-white fw-bold text-center fs-4" style="background-color:#3A3A4E;">
                Danh sách vé đã đặt
            </div>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>ID Vé</th>
                    <th>Sự kiện</th>
                    <th>Tên người mua</th>
                    <th>Email</th>
                    <th>Số lượng</th>
                    <th>Thời gian mua</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="t" items="${ticketList}">
                    <tr>
                        <td>${t.id}</td>
                        <td>${t.eventTitle}</td>
                        <td>${t.userName}</td>
                        <td>${t.userEmail}</td>
                        <td>${t.quantity}</td>
                        <td><fmt:formatDate value="${t.purchase_date}" pattern="dd/MM/yyyy HH:mm"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
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

