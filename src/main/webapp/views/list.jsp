<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 15/08/2025
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<html>
<head>
    <title>Danh sách sự kiện</title>
    <link rel="stylesheet" href="assets/bootstrap.min.css">
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
</body>
</html>


