<%--
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Assignment: Project – Part 3
  Purpose: Display a dropdown of movie IDs/titles so the user can
           select a record to update
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="java.util.List, csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Select Movie to Update</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: .3rem; }
        .note { color: #555; margin-bottom: 1rem; max-width: 700px; }
        select { padding: .3rem .4rem; min-width: 320px; }
        button { padding: .4rem .8rem; margin-left: .5rem; }
    </style>
</head>
<body>

<h1>CSD430 – Update Movie (Step 1)</h1>
<p class="note">
    This page loads all movie records from the database and displays them
    in a dropdown. Select a movie to update its details on the next page.
</p>

<%
    // Load all movies for the dropdown
    List<MovieBean> movies = MovieBean.getAllMovies();
%>

<form method="get" action="editMovie.jsp">
    <label for="movieId"><strong>Select a movie to update:</strong></label>
    <select name="movieId" id="movieId" required>
        <option value="">-- choose a movie --</option>
        <% for (MovieBean m : movies) { %>
            <option value="<%= m.getId() %>">
                <%= m.getId() %> – <%= m.getTitle() %> (<%= m.getReleaseYear() %>)
            </option>
        <% } %>
    </select>
    <button type="submit">Edit Selected Movie</button>
</form>

<p class="note">
    After you choose a movie, the next JSP will show all fields in editable
    input boxes (except for the primary key, which is read-only).
</p>

<p><a href="index.jsp">Back to CRUD Index</a></p>

</body>
</html>
