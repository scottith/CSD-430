<%-- 
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Purpose: Index page holding links to all CRUD-related module deliverables.
           
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Movies CRUD Index</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: .25rem; }
        .note { color: #555; margin-bottom: 1rem; }
        ul { line-height: 1.8; }
        code { background: #f5f5f5; padding: 2px 4px; border-radius: 3px; }
    </style>
</head>
<body>
<h1>CSD430 – Movies Project</h1>
<p class="note">
    Database: <code>CSD430</code> |
    Table: <code>scott_movies_data</code> |
    User: <code>student1 / pass</code>
</p>

<h2>Module 5 / 6 – READ (Movies)</h2>
<ul>
    <%-- Needs Updating--%>
    <li><a href="listMovies.jsp">List all movies (READ)</a> – future JDBC/JavaBeans page</li>
</ul>

<h2>Future Modules – CRUD</h2>
<ul>
    <li>Create Movie – <code>createMovie.jsp</code> (to be added)</li>
    <li>Update Movie – <code>updateMovie.jsp</code> (to be added)</li>
    <li>Delete Movie – <code>deleteMovie.jsp</code> (to be added)</li>
</ul>
</body>
</html>
