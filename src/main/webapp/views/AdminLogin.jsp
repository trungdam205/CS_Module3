<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Admin Login</title>
</head>
<body>
<h2>Admin Login</h2>
<form action="adminAuth" method="post">
  <label>Username:</label>
  <input type="text" name="username" required><br>
  <label>Password:</label>
  <input type="password" name="password" required><br>
  <input type="submit" value="Login">
</form>

<% String error = (String) request.getAttribute("error");
  if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } %>
</body>
</html>
