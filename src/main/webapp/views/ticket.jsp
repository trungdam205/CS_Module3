<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 15/08/2025
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">

<html>
<head>
    <title>Đặt vé</title>
    <link rel="stylesheet" href="assets/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="container mt-4">
<h2>Đặt vé</h2>
<form action="tickets?action=save" method="post">
    <input type="hidden" name="eventId" value="${eventId}">

    <div class="mb-3">
        <label>Họ tên</label>
        <input type="text" class="form-control" value="${sessionScope.user.name}" readonly>
    </div>

    <div class="mb-3">
        <label>Email</label>
        <input type="email" class="form-control" value="${sessionScope.user.email}" readonly>
    </div>

    <div class="mb-3">
        <label>Số lượng vé</label>
        <input type="number" name="quantity" class="form-control" min="1" required>
    </div>

    <button type="submit" class="btn btn-success">Xác nhận đặt vé</button>
    <a href="events?action=detail&id=${eventId}" class="btn btn-secondary">Quay lại</a>
</form>



<c:if test="${not empty errorMessage}">
    <script>
        Swal.fire({
            title: "${errorMessage}",
            icon: "error",
            confirmButtonText: "OK"
        });
    </script>
</c:if>

<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            title: "${successMessage}",
            icon: "success",
            confirmButtonText: "Trở lại"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "events?action=detail&id=${eventId}";
            }
        });
    </script>
</c:if>


</body>
</html>
