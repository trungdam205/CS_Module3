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
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style_dashboard.css">
</head>
<body class="bg-dark text-light">


<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4 rounded px-3"
     style="background-color:#2DC275; position:relative; z-index:1100;">
    <div class="container-fluid">

        <!-- Logo -->
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/dashboard"
           style="font-family:'Montserrat',sans-serif;font-size:2rem;font-weight:700;color:#fff;">
            <i class="bi bi-star"></i> ConcertStar
        </a>

        <!-- FORM TÌM (căn giữa ngang+dọc) -->
        <%--        <form class="position-absolute top-50 start-50 translate-middle d-flex"--%>
        <%--              action="${pageContext.request.contextPath}/dashboard" method="get"--%>
        <%--              style="max-width:520px;width:100%; z-index:1110;">--%>
        <%--            <input type="hidden" name="action" value="search"/>--%>
        <%--            <input type="hidden" name="tab" id="currentTab" value="${param.tab != null ? param.tab : 'events'}">--%>

        <%--            <div class="input-group shadow-sm rounded-pill w-100 position-relative">--%>
        <%--                <span class="input-group-text bg-white border-0 ps-3">--%>
        <%--                   <i class="bi bi-search text-secondary fs-5"></i>--%>
        <%--                </span>--%>

        <%--                <input type="text" class="form-control border-0"--%>
        <%--                       name="keyword" placeholder="Tìm sự kiện..."--%>
        <%--                       value="${param.keyword}" style="box-shadow:none;font-size:15px;"/>--%>

        <%--                <!-- Nút tìm -->--%>
        <%--                <button class="btn btn-primary border-0 px-4 fw-semibold rounded-end-pill" type="submit">--%>
        <%--                    Tìm--%>
        <%--                </button>--%>
        <%--            </div>--%>

        <%--            <!-- Nút & menu BỘ LỌC (tách khỏi input-group) -->--%>
        <%--            <div class="dropdown position-absolute" style="right:92px; top:50%; transform:translateY(-50%);">--%>
        <%--                <button class="btn btn-light border-0 dropdown-toggle px-3"--%>
        <%--                        type="button" id="filterDropdown"--%>
        <%--                        data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">--%>
        <%--                    <i class="bi bi-funnel"></i>--%>
        <%--                </button>--%>

        <%--                <div class="dropdown-menu p-3 shadow-lg border-0 rounded-4"--%>
        <%--                     aria-labelledby="filterDropdown"--%>
        <%--                     style="width:380px; max-width:calc(100vw - 2rem); z-index:1200;">--%>
        <%--                    <!-- Lọc theo giá -->--%>
        <%--                    <div class="mb-3">--%>
        <%--                        <label class="form-label fw-semibold small text-muted">Khoảng giá</label>--%>
        <%--                        <select class="form-select rounded-pill" name="price">--%>
        <%--                            <option value="">-- Tất cả --</option>--%>
        <%--                            <option value="1" ${param.price == '1' ? 'selected' : ''}>Dưới 500k</option>--%>
        <%--                            <option value="2" ${param.price == '2' ? 'selected' : ''}>500k - 1 triệu</option>--%>
        <%--                            <option value="3" ${param.price == '3' ? 'selected' : ''}>Trên 1 triệu</option>--%>
        <%--                        </select>--%>
        <%--                    </div>--%>

        <%--                    <!-- Lọc theo địa điểm -->--%>
        <%--                    <div>--%>
        <%--                        <label class="form-label fw-semibold small text-muted">Địa điểm</label>--%>
        <%--                        <input list="cities" name="location" class="form-control rounded-pill"--%>
        <%--                               placeholder="Chọn hoặc nhập thành phố">--%>
        <%--                        <datalist id="cities">--%>
        <%--                            <option value="Hà Nội">--%>
        <%--                            <option value="Huế">--%>
        <%--                            <option value="Cao Bằng">--%>
        <%--                            <option value="Điện Biên">--%>
        <%--                            <option value="Sơn La">--%>
        <%--                            <option value="Lạng Sơn">--%>
        <%--                            <option value="Quảng Ninh">--%>
        <%--                            <option value="Thanh Hoá">--%>
        <%--                            <option value="Nghệ An">--%>
        <%--                            <option value="Hà Tĩnh">--%>
        <%--                            <option value="Lai Châu">--%>
        <%--                            <option value="An Giang">--%>
        <%--                            <option value="Bắc Ninh">--%>
        <%--                            <option value="Cà Mau">--%>
        <%--                            <option value="Đắk Lắk">--%>
        <%--                            <option value="Đồng Nai">--%>
        <%--                            <option value="Đồng Tháp">--%>
        <%--                            <option value="Gia Lai">--%>
        <%--                            <option value="Hưng Yên">--%>
        <%--                            <option value="Khánh Hòa">--%>
        <%--                            <option value="Lào Cai">--%>
        <%--                            <option value="Lâm Đồng">--%>
        <%--                            <option value="Ninh Bình">--%>
        <%--                            <option value="Phú Thọ">--%>
        <%--                            <option value="Quảng Ngãi">--%>
        <%--                            <option value="Quảng Trị">--%>
        <%--                            <option value="Tây Ninh">--%>
        <%--                            <option value="Thái Nguyên">--%>
        <%--                            <option value="Tuyên Quang">--%>
        <%--                            <option value="Vĩnh Long">--%>
        <%--                            <option value="Cần Thơ">--%>
        <%--                            <option value="Đà Nẵng">--%>
        <%--                            <option value="Hải Phòng">--%>
        <%--                            <option value="Hồ Chí Minh">--%>
        <%--                        </datalist>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </form>--%>


        <form class="position-absolute top-50 start-50 translate-middle d-flex"
              action="${pageContext.request.contextPath}/dashboard" method="get"
              style="max-width:520px;width:100%; z-index:1110;">

            <input type="hidden" name="action" value="search"/>
            <input type="hidden" name="tab" value="${param.tab != null ? param.tab : 'events'}"/>

            <div class="input-group shadow-sm rounded-pill w-100 position-relative">
        <span class="input-group-text bg-white border-0 ps-3">
          <i class="bi bi-search text-secondary fs-5"></i>
        </span>

                <c:choose>
                    <c:when test="${param.tab == null || param.tab == 'events'}">
                        <input type="text" class="form-control border-0"
                               name="keyword" placeholder="Tìm sự kiện..."
                               value="${param.keyword}" style="box-shadow:none;font-size:15px;"/>

                        <button class="btn btn-primary border-0 px-4 fw-semibold rounded-end-pill" type="submit">
                            Tìm
                        </button>
                    </c:when>

                    <c:otherwise>
                        <input type="text" class="form-control border-0"
                               name="keyword" placeholder="Tìm theo tên/email/sự kiện..."
                               value="${param.keyword}" style="box-shadow:none;font-size:15px;"/>

                        <button class="btn btn-warning border-0 px-4 fw-semibold rounded-end-pill" type="submit">
                            Tìm vé
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>


            <c:if test="${param.tab == null || param.tab == 'events'}">
                <div class="dropdown position-absolute" style="right:92px; top:50%; transform:translateY(-50%);">
                    <button class="btn btn-light border-0 dropdown-toggle px-3"
                            type="button" id="filterDropdown"
                            data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                        <i class="bi bi-funnel"></i>
                    </button>

                    <div class="dropdown-menu p-3 shadow-lg border-0 rounded-4"
                         aria-labelledby="filterDropdown"
                         style="width:380px; max-width:calc(100vw - 2rem); z-index:1200;">
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Khoảng giá</label>
                            <select class="form-select rounded-pill" name="price">
                                <option value="">-- Tất cả --</option>
                                <option value="1" ${param.price == '1' ? 'selected' : ''}>Dưới 500k</option>
                                <option value="2" ${param.price == '2' ? 'selected' : ''}>500k - 1 triệu</option>
                                <option value="3" ${param.price == '3' ? 'selected' : ''}>Trên 1 triệu</option>
                            </select>
                        </div>

                        <div>
                            <label class="form-label fw-semibold small text-muted">Địa điểm</label>
                            <input list="cities" name="location" class="form-control rounded-pill"
                                   placeholder="Chọn hoặc nhập thành phố" value="${param.location}">
                            <datalist id="cities">
                                <option value="Hà Nội">
                                <option value="Huế">
                                <option value="Cao Bằng">
                                <option value="Điện Biên">
                                <option value="Sơn La">
                                <option value="Lạng Sơn">
                                <option value="Quảng Ninh">
                                <option value="Thanh Hoá">
                                <option value="Nghệ An">
                                <option value="Hà Tĩnh">
                                <option value="Lai Châu">
                                <option value="An Giang">
                                <option value="Bắc Ninh">
                                <option value="Cà Mau">
                                <option value="Đắk Lắk">
                                <option value="Đồng Nai">
                                <option value="Đồng Tháp">
                                <option value="Gia Lai">
                                <option value="Hưng Yên">
                                <option value="Khánh Hòa">
                                <option value="Lào Cai">
                                <option value="Lâm Đồng">
                                <option value="Ninh Bình">
                                <option value="Phú Thọ">
                                <option value="Quảng Ngãi">
                                <option value="Quảng Trị">
                                <option value="Tây Ninh">
                                <option value="Thái Nguyên">
                                <option value="Tuyên Quang">
                                <option value="Vĩnh Long">
                                <option value="Cần Thơ">
                                <option value="Đà Nẵng">
                                <option value="Hải Phòng">
                                <option value="Hồ Chí Minh">
                            </datalist>
                        </div>
                    </div>
                </div>
            </c:if>
        </form>

        <%-- Menu phải --%>
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item me-3">
                <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/events">
                    <i class="bi bi-arrow-left-circle"></i> Quay lại sự kiện
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle fw-semibold text-light" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-badge"></i> Admin: ${sessionScope.user.name}
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

<%--    <ul id="dashboardTabs" class="nav nav-tabs">--%>
<%--        <li class="nav-item">--%>
<%--            <a class="nav-link ${param.tab == null || param.tab == 'events' ? 'active' : ''} "--%>
<%--               href="${pageContext.request.contextPath}/dashboard?tab=events">--%>
<%--                Quản lý sự kiện--%>
<%--            </a>--%>
<%--        </li>--%>
<%--        <li class="nav-item">--%>
<%--            <a class="nav-link ${param.tab == 'tickets' ? 'active' : ''}"--%>
<%--               href="${pageContext.request.contextPath}/dashboard?tab=tickets">--%>
<%--                Danh sách vé--%>
<%--            </a>--%>
<%--        </li>--%>
<%--    </ul>--%>

    <ul id="dashboardTabs" class="nav nav-pills mb-3 gap-2">
        <li class="nav-item">
            <a class="nav-link ${param.tab == null || param.tab == 'events' ? 'active bg-success text-white fw-semibold shadow-sm' : 'text-success'}"
               href="${pageContext.request.contextPath}/dashboard?tab=events">
                <i class="bi bi-calendar-event me-1"></i> Quản lý sự kiện
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${param.tab == 'tickets' ? 'active bg-primary text-white fw-semibold shadow-sm' : 'text-primary'}"
               href="${pageContext.request.contextPath}/dashboard?tab=tickets">
                <i class="bi bi-ticket-perforated me-1"></i> Danh sách vé
            </a>
        </li>
    </ul>


    <div class="tab-content mt-4">

        <!-- Danh sách sự kiện -->
        <c:if test="${param.tab == null || param.tab == 'events'}">
            <div class="tab-pane fade show active" id="events">
                <div class="d-flex justify-content-end mb-3">
                    <a href="events?action=create" class="btn btn-info">
                        <i class="bi bi-plus-circle"></i> Tạo sự kiện mới
                    </a>
                </div>

                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-header text-white fw-bold text-center fs-4 bg-success">
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
                                    <th>Giá</th>
                                    <th class="text-center" style="white-space: nowrap;">Hành động</th>
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
                                        <td>
                                            <a href="events?action=detail&id=${e.id}"
                                               class="text-decoration-none text-info">
                                                    ${e.title}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatDate value="${e.date}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>${e.location}</td>
                                        <td class="text-end fw-bold text-success" style="white-space: nowrap;">
                                            <fmt:formatNumber value="${e.price}" type="number" groupingUsed="true"/>đ
                                        </td>
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-2">
                                                <a href="events?action=update&id=${e.id}"
                                                   class="btn btn-sm btn-warning">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="javascript:void(0);" class="btn btn-sm btn-danger"
                                                   onclick="confirmDelete(${e.id})">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Danh sách vé -->
        <c:if test="${param.tab == 'tickets'}">
            <div class="tab-pane fade show active" id="tickets">
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-header text-white fw-bold text-center fs-4 bg-primary">
                        Danh sách vé đã đặt
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                            <table class="table table-bordered table-hover align-middle mb-0">
                                <thead class="table-light">
                                <tr>
                                    <th class="text-center" style="white-space: nowrap;">ID Vé</th>
                                    <th>Sự kiện</th>
                                    <th>Tên người mua</th>
                                    <th>Email</th>
                                    <th class="text-center" style="white-space: nowrap;">Số lượng</th>
                                    <th>Thời gian mua</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:if test="${empty ticketList}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">Chưa có vé nào.</td>
                                    </tr>
                                </c:if>

                                <c:forEach var="t" items="${ticketList}">
                                    <tr>
                                        <td class="text-center">${t.id}</td>
                                        <td>${t.eventTitle}</td>
                                        <td>${t.userName}</td>
                                        <td>${t.userEmail}</td>
                                        <td class="text-center">${t.quantity}</td>
                                        <td style="white-space: nowrap;">
                                            <fmt:formatDate value="${t.purchase_date}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</div>

<!-- Offcanvas hiển thị vé của người dùng -->
<div class="offcanvas offcanvas-start bg-dark text-light" tabindex="-1" id="ticketPanel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Vé của tôi</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <c:if test="${empty ticketList}">
            <p class="text-muted">Bạn chưa có vé nào.</p>
        </c:if>

        <c:forEach var="t" items="${ticketList}">
            <div class="card bg-dark text-light mb-2 shadow-sm">
                <div class="card-body p-3">
                    <a class="fw-bold text-decoration-none text-info"
                       href="events?action=detail&id=${t.eventId}">${t.eventTitle}
                    </a>
                    <p>Ngày mua: <span><fmt:formatDate value="${t.purchase_date}" pattern="dd/MM/yyyy"/></span></p>
                    <p>Số vé: <strong>${t.quantity}</strong></p>
                    <p>Tổng: <strong><fmt:formatNumber value="${t.totalPrice}" type="number" groupingUsed="true"/>
                        VND</strong></p>
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

<footer class="text-light pt-5 pb-4 mt-5" style="background-color: #1D1D1D;">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h4 class="fw-bold"><i class="bi bi-star"></i> ConcertStar</h4>
                <span class="text-white-50">Nền tảng đặt vé sự kiện âm nhạc hàng đầu Việt Nam.</span><br>
                <span class="text-white-50">&copy; 2025 ConcertStar. All rights reserved.</span>
            </div>
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Liên kết nhanh</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-white-50">Giới thiệu</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Sự kiện</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Liên hệ</a></li>
                    <li><a href="#" class="text-decoration-none text-white-50">Chính sách bảo mật</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Kết nối với chúng tôi</h5>
                <div class="d-flex gap-3">
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="text-white-50 fs-4"><i class="bi bi-twitter-x"></i></a>
                </div>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>

<script>
    function confirmDelete(eventId) {
        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: "btn btn-success ms-2",
                cancelButton: "btn btn-danger me-2"
            },
            buttonsStyling: false
        });

        swalWithBootstrapButtons.fire({
            title: "Bạn có chắc chắn?",
            text: "Hành động này sẽ xóa sự kiện vĩnh viễn!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Xóa ngay!",
            cancelButtonText: "Hủy xóa!",
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                swalWithBootstrapButtons.fire({
                    title: "Đã xóa!",
                    text: "Sự kiện đã được xóa thành công.",
                    icon: "success"
                }).then(() => {
                    window.location.href = "events?action=delete&id=" + eventId;
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                swalWithBootstrapButtons.fire({
                    title: "Đã hủy",
                    text: "Sự kiện vẫn an toàn 🙂",
                    icon: "error"
                });
            }
        });
    }
</script>

<script>
    const tabs = document.querySelectorAll('#dashboardTabs a');
    tabs.forEach(tab => {
        tab.addEventListener('shown.bs.tab', function (e) {
            let tabId = e.target.getAttribute("href").substring(1); // "events" hoặc "tickets"
            document.getElementById("currentTab").value = tabId;
        });
    });

    // Khi load lại trang, mở đúng tab active
    document.addEventListener("DOMContentLoaded", () => {
        const activeTab = "${activeTab}";
        if (activeTab) {
            const triggerEl = document.querySelector(`#dashboardTabs a[href="#${activeTab}"]`);
            if (triggerEl) {
                new bootstrap.Tab(triggerEl).show();
            }
        }
    });
</script>


</body>
</html>
