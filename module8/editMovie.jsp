<%--
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Assignment: Project – Part 3
  Purpose: Step 2 & 3 of update workflow:
           - GET: show form pre-populated with selected movie
           - POST: update record and display updated row in a table
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="csd430.MovieBean" %>
<%! 
    // Helper for safe HTML output
    private String esc(String s) {
        return (s == null) ? "" :
                s.replace("&","&amp;")
                 .replace("<","&lt;")
                 .replace(">","&gt;")
                 .replace("\"","&quot;");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Edit Movie</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: .25rem; }
        h2 { margin-top: 1.5rem; }
        .note { color: #555; margin-bottom: 1rem; max-width: 700px; }
        form { margin-bottom: 1.5rem; max-width: 500px; }
        label { display: block; margin-top: .5rem; font-weight: bold; }
        input[type=text],
        input[type=number] { width: 100%; padding: .35rem .45rem; }
        button { margin-top: .75rem; padding: .4rem .8rem; }
        .error { color: #b00020; margin-top: .5rem; }
        .success { color: #006400; margin-top: .5rem; }
        table { border-collapse: collapse; margin-top: 1rem; min-width: 700px; }
        th, td { border: 1px solid #ccc; padding: .45rem .6rem; text-align: left; }
        th { background: #f5f5f5; }
    </style>
</head>
<body>

<h1>CSD430 – Update Movie (Step 2 &amp; 3)</h1>

<%
    request.setCharacterEncoding("UTF-8");

    String messageError = null;
    String messageSuccess = null;

    MovieBean movie = null;
    boolean showForm = true;   // whether to show the editable form
    boolean showTable = false; // whether to show the updated record table

    try {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // ----- Handle update submission -----
            String idStr = request.getParameter("id");
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            String yearStr = request.getParameter("year");
            String ratingStr = request.getParameter("rating");
            String durationStr = request.getParameter("duration");
            String director = request.getParameter("director");

            if (idStr == null || idStr.isBlank() ||
                title == null || title.isBlank() ||
                genre == null || genre.isBlank() ||
                yearStr == null || yearStr.isBlank()) {

                messageError = "ID, title, genre, and release year are required.";
            } else {
                int id = Integer.parseInt(idStr.trim());
                int year = Integer.parseInt(yearStr.trim());

                Double rating = null;
                if (ratingStr != null && !ratingStr.isBlank()) {
                    rating = Double.parseDouble(ratingStr.trim());
                }

                Integer duration = null;
                if (durationStr != null && !durationStr.isBlank()) {
                    duration = Integer.parseInt(durationStr.trim());
                }

                MovieBean.updateMovie(id, title.trim(), genre.trim(), year,
                                      rating, duration,
                                      (director == null ? "" : director.trim()));

                // Reload the updated record
                movie = MovieBean.findById(id);
                messageSuccess = "Movie ID " + id + " was updated successfully.";
                showForm = false;
                showTable = true;
            }
        } else {
            // ----- Initial GET: load record to edit -----
            String movieIdParam = request.getParameter("movieId");
            if (movieIdParam == null || movieIdParam.isBlank()) {
                messageError = "No movie selected. Please go back and choose a record to update.";
                showForm = false;
            } else {
                int id = Integer.parseInt(movieIdParam.trim());
                movie = MovieBean.findById(id);

                if (movie == null || movie.getId() == 0) {
                    messageError = "Movie with ID " + id + " was not found.";
                    showForm = false;
                }
            }
        }
    } catch (NumberFormatException ex) {
        messageError = "Numeric fields (ID, year, rating, duration) must contain valid numbers.";
        showForm = false;
    }
%>

<p class="note">
    The primary key (<code>id</code>) is displayed but not editable. All other
    fields can be updated and saved back to the database through the
    <code>MovieBean</code>.
</p>

<% if (messageError != null) { %>
    <p class="error"><%= messageError %></p>
<% } %>

<% if (showForm && movie != null) { %>
    <h2>Edit Movie</h2>
    <form method="post" action="editMovie.jsp">
        <!-- ID displayed read-only, but also passed as hidden field -->
        <p><strong>Movie ID (PK):</strong> <%= movie.getId() %></p>
        <input type="hidden" name="id" value="<%= movie.getId() %>" />

        <label for="title">Title</label>
        <input type="text" id="title" name="title"
               value="<%= esc(movie.getTitle()) %>" required />

        <label for="genre">Genre</label>
        <input type="text" id="genre" name="genre"
               value="<%= esc(movie.getGenre()) %>" required />

        <label for="year">Release Year</label>
        <input type="number" id="year" name="year" min="1900" max="2100"
               value="<%= movie.getReleaseYear() %>" required />

        <label for="rating">Rating (0.0 – 10.0)</label>
        <input type="text" id="rating" name="rating"
               value="<%= movie.getRating() == null ? \"\" : movie.getRating() %>" />

        <label for="duration">Duration (minutes)</label>
        <input type="number" id="duration" name="duration" min="1"
               value="<%= movie.getDurationMin() == null ? \"\" : movie.getDurationMin() %>" />

        <label for="director">Director</label>
        <input type="text" id="director" name="director"
               value="<%= esc(movie.getDirector()) %>" />

        <button type="submit">Save Changes</button>
    </form>
<% } %>

<% if (messageSuccess != null) { %>
    <p class="success"><%= messageSuccess %></p>
<% } %>

<% if (showTable && movie != null) { %>
    <h2>Updated Movie Record</h2>
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
        <tr>
            <td><%= movie.getId() %></td>
            <td><%= esc(movie.getTitle()) %></td>
            <td><%= esc(movie.getGenre()) %></td>
            <td><%= movie.getReleaseYear() %></td>
            <td><%= movie.getRating() == null ? "" : movie.getRating() %></td>
            <td><%= movie.getDurationMin() == null ? "" : movie.getDurationMin() %></td>
            <td><%= esc(movie.getDirector()) %></td>
        </tr>
        </tbody>
    </table>
<% } %>

<p class="note">
    Use the links below to update another movie or return to the main CRUD index.
</p>

<p>
    <a href="selectMovieForUpdate.jsp">Update another movie</a> |
    <a href="index.jsp">Back to CRUD Index</a>
</p>

</body>
</html>
