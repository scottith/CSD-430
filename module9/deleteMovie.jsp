<%--
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Assignment: Project – Part 4 (DELETE)
  Purpose: Display all movie records in a table and provide a dropdown
           of primary keys (IDs) so the user can select a record to delete.
           After deletion, the page reloads with the remaining records
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="java.util.List, csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Delete Movie (DELETE)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: .25rem; }
        h2 { margin-top: 1.5rem; }
        .note { color: #555; margin-bottom: 1rem; max-width: 700px; }
        form { margin-bottom: 1.5rem; }
        label { font-weight: bold; }
        select { padding: .3rem .5rem; min-width: 260px; margin-left: .3rem; }
        button { padding: .4rem .8rem; margin-left: .5rem; }
        .message { margin-top: .75rem; }
        .success { color: #006400; }
        .error { color: #b00020; }
        table { border-collapse: collapse; margin-top: 1rem; min-width: 750px; }
        th, td { border: 1px solid #ccc; padding: .45rem .6rem; text-align: left; }
        th { background: #f5f5f5; }
    </style>
</head>
<body>

<h1>CSD430 – Delete Movie Records</h1>
<p class="note">
    This page uses the shared <code>MovieBean</code> to read and delete records
    from the <code>CSD430.scott_movies_data</code> table. All movies are listed
    in an HTML table, and the dropdown below lets you choose a movie ID (primary key)
    to delete. After each deletion, the remaining records are displayed again.
</p>

<%
    request.setCharacterEncoding("UTF-8");

    String message = null;
    String messageClass = "success";

    // Handle delete request (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String idParam = request.getParameter("movieId");

        if (idParam == null || idParam.isBlank()) {
            message = "Please select a movie ID before deleting.";
            messageClass = "error";
        } else {
            try {
                int id = Integer.parseInt(idParam.trim());
                MovieBean.deleteMovie(id);
                message = "Movie with ID " + id + " was deleted successfully.";
            } catch (NumberFormatException ex) {
                message = "Invalid movie ID submitted.";
                messageClass = "error";
            }
        }
    }

    // Always load the latest set of movies for table + dropdown
    List<MovieBean> movies = MovieBean.getAllMovies();
    boolean hasMovies = !movies.isEmpty();
%>

<h2>Select a Movie to Delete</h2>

<form method="post" action="deleteMovie.jsp">
    <label for="movieId">Movie ID to delete:</label>
    <select name="movieId" id="movieId" <%= hasMovies ? "" : "disabled" %>>
        <option value="">-- choose a movie ID --</option>
        <% if (hasMovies) { %>
            <% for (MovieBean m : movies) { %>
                <option value="<%= m.getId() %>">
                    <%= m.getId() %> – <%= m.getTitle() %> (<%= m.getReleaseYear() %>)
                </option>
            <% } %>
        <% } %>
    </select>
    <button type="submit" <%= hasMovies ? "" : "disabled" %>>Delete Selected Movie</button>

    <% if (message != null) { %>
        <p class="message <%= messageClass %>"><%= message %></p>
    <% } %>
</form>

<h2>Current Movies in Database</h2>
<table>
    <thead>
    <tr>
        <th>ID (PK)</th>
        <th>Title</th>
        <th>Genre</th>
        <th>Release Year</th>
        <th>Rating</th>
        <th>Duration (min)</th>
        <th>Director</th>
    </tr>
    </thead>
    <tbody>
    <% if (hasMovies) { %>
        <% for (MovieBean m : movies) { %>
            <tr>
                <td><%= m.getId() %></td>
                <td><%= m.getTitle() %></td>
                <td><%= m.getGenre() %></td>
                <td><%= m.getReleaseYear() %></td>
                <td><%= m.getRating() == null ? "" : m.getRating() %></td>
                <td><%= m.getDurationMin() == null ? "" : m.getDurationMin() %></td>
                <td><%= m.getDirector() %></td>
            </tr>
        <% } %>
    <% } %>
    </tbody>
</table>

<p class="note">
    If all records are deleted, the table above will show only the header row
    with no data rows. You can then reinsert records using your CREATE page.
</p>

<p>
    <a href="index.jsp">Back to CRUD Index</a>
</p>

</body>
</html>
