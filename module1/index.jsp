<%-- 
  Scott Macioce
  October 25, 2025
  Assignment: CSD430 Module 1 - Project Setup & Repository
  Purpose: First JSP page demonstrating Java (scriptlet + expression) and HTML tags
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Hello JSP</title>
</head>
<body>
<%
    // Simple server-side Java for the assignment requirement
    String user = request.getParameter("name");
    if (user == null || user.isBlank()) {
        user = "CSD430 Student";
    }
    java.util.Date now = new java.util.Date();
%>
    <h1>Hello, <%= user %>!</h1>
    <p>This page was rendered on the server at: <%= now %></p>
    <p>Your client IP: <%= request.getRemoteAddr() %></p>

    <hr />
    <form method="get">
        <label>Enter your name: <input name="name" /></label>
        <button type="submit">Greet Me</button>
    </form>
</body>
</html>
