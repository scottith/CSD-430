<%-- 
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Assignment: Module 6 – JavaBean DB Read
  Purpose: Display a dropdown of movie IDs/titles, allow user to
           select one, and show all fields for that record in a table.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="java.util.List, csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Movie Lookup</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: 0.25rem; }
        .desc { color: #555; margin-bottom: 1.5rem; max-width: 650px; }
        label { font-weight: bold; }
        select, button { padding: 0.35rem 0.5rem; margin-top: 0.5rem; }
        table { border-collapse: collapse; margin-top: 1.5rem; min-width: 600px; }
        th, td { border: 1px solid #ccc; padding: 0.5rem 0.75rem; text-align: left; }
        th { background: #f5f5f5; }
        .note { color: #777; margin-top: 1rem; }
        .error { color: #b00020; margin-top: 1rem; }
    </style>
</head>
<body>

<h1>Movie Lookup</h1>
<p class="desc">
    This page reads from the <code>CSD430</code> database using a JavaBean
    (<code>MovieBean</code>). First, it shows a dropdown list of all movie
    records by ID and title. When you select a movie and submit the form,
    the full record is retrieved from the database and displayed in a table.
</p>

<%
    // Load all movies to populate the dropdown menu.
    List<MovieBean> movies = MovieBean.getAllMovies();

    // Read the selected ID from the request (if any)
    String selectedIdParam = request.getParameter("movieId");
    int selectedId = -1;
    MovieBean selectedMovie = null;

    if (selectedIdParam != null && !selectedIdParam.isBlank()) {
        try {
            selectedId = Integer.parseInt(selectedIdParam);
            selectedMovie = MovieBean.findById(selectedId);
        } catch (NumberFormatException ex) {
            // Invalid ID – keep selectedMovie null and show an error message below.
        }
    }
%>

<form method="get" action="movieLookup.jsp">
    <label for="movieId">Select a movie by ID and Title:</label><br />
    <select name="movieId" id="movieId">
        <option value="">-- Choose a movie --</option>
        <% for (MovieBean m : movies) { %>
            <option value="<%= m.getId() %>"
                <%= (m.getId() == selectedId ? "selected" : "") %>>
                <%= m.getId() %> – <%= m.getTitle() %>
            </option>
        <% } %>
    </select>
    <br />
    <button type="submit">Show Details</button>
</form>

<%-- Display error if the ID was invalid --%>
<% if (selectedIdParam != null && selectedMovie == null && !selectedIdParam.isBlank()) { %>
    <p class="error">The selected movie could not be found. Please choose a valid entry from the list.</p>
<% } %>

<%-- Display the selected record in a table if we found one --%>
<% if (selectedMovie != null && selectedMovie.getId() != 0) { %>
    <h2>Selected Movie Details</h2>
    <table>
        <thead>
        <tr>
            <th>Field</th>
            <th>Value</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>ID (Primary Key)</td>
            <td><%= selectedMovie.getId() %></td>
        </tr>
        <tr>
            <td>Title</td>
            <td><%= selectedMovie.getTitle() %></td>
        </tr>
        <tr>
            <td>Genre</td>
            <td><%= selectedMovie.getGenre() %></td>
        </tr>
        <tr>
            <td>Release Year</td>
            <td><%= selectedMovie.getReleaseYear() %></td>
        </tr>
        <tr>
            <td>Rating</td>
            <td><%= selectedMovie.getRating() == null ? "" : selectedMovie.getRating() %></td>
        </tr>
        <tr>
            <td>Duration (minutes)</td>
            <td><%= selectedMovie.getDurationMin() == null ? "" : selectedMovie.getDurationMin() %></td>
        </tr>
        <tr>
            <td>Director</td>
            <td><%= selectedMovie.getDirector() %></td>
        </tr>
        </tbody>
    </table>
    <p class="note">
        Data source: <code>CSD430.scott_movies_data</code>. Display includes at least
        five fields: id, title, genre, release year, rating, duration, and director.
    </p>
<% } else { %>
    <p class="note">
        Choose a movie from the dropdown and click <strong>Show Details</strong> to see
        the full record in table format.
    </p>
<% } %>

</body>
</html>
