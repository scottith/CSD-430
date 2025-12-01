<%--
  Author: Scott Macioce
  Course: CSD430 – Server-Side Development
  Assignment: Project – Part 2
  Purpose: Gather movie data from the user, insert into the database
           via MovieBean, and display all movie records in a table
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="java.util.List, csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 – Add Movie (CREATE)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        h1 { margin-bottom: .25rem; }
        .note { color: #555; margin-bottom: 1rem; max-width: 700px; }
        form { margin-bottom: 1.5rem; }
        label { display: block; margin-top: .5rem; font-weight: bold; }
        input[type=text],
        input[type=number] { padding: .3rem .4rem; width: 280px; }
        button { margin-top: .75rem; padding: .4rem .8rem; }
        .error { color: #b00020; margin-top: .5rem; }
        .success { color: #006400; margin-top: .5rem; }
        table { border-collapse: collapse; margin-top: 1.5rem; min-width: 700px; }
        th, td { border: 1px solid #ccc; padding: .45rem .6rem; text-align: left; }
        th { background: #f5f5f5; }
    </style>
</head>
<body>

<h1>CSD430 – Add Movie</h1>
<p class="note">
    This page uses a JavaBean (<code>MovieBean</code>) to insert a new movie
    into the <code>CSD430.scott_movies_data</code> table and then display all
    movies in an HTML table. The primary key (<code>id</code>) is auto-generated
    by the database when you submit the form.
</p>

<%
    // ----- Handle form submission (CREATE) -----
    request.setCharacterEncoding("UTF-8");

    String messageError = null;
    String messageSuccess = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String yearStr = request.getParameter("year");
        String ratingStr = request.getParameter("rating");
        String durationStr = request.getParameter("duration");
        String director = request.getParameter("director");

        // Basic required-field validation
        if (title == null || title.isBlank() ||
            genre == null || genre.isBlank() ||
            yearStr == null || yearStr.isBlank()) {

            messageError = "Title, genre, and release year are required.";
        } else {
            try {
                int year = Integer.parseInt(yearStr.trim());

                Double rating = null;
                if (ratingStr != null && !ratingStr.isBlank()) {
                    rating = Double.parseDouble(ratingStr.trim());
                }

                Integer duration = null;
                if (durationStr != null && !durationStr.isBlank()) {
                    duration = Integer.parseInt(durationStr.trim());
                }

                // Insert new movie using JavaBean helper method
                MovieBean.insertMovie(title.trim(), genre.trim(), year,
                                      rating, duration,
                                      (director == null ? "" : director.trim()));

                messageSuccess = "Movie \"" + title + "\" was added successfully.";
            } catch (NumberFormatException ex) {
                messageError = "Release year, rating, and duration (if provided) must be numeric values.";
            }
        }
    }

    // ----- Always load all movies to display in the table -----
    List<MovieBean> movies = MovieBean.getAllMovies();
%>

<form method="post" action="createMovie.jsp">
    <h2>Enter New Movie Information</h2>

    <label for="title">Title *</label>
    <input type="text" name="title" id="title" required />

    <label for="genre">Genre *</label>
    <input type="text" name="genre" id="genre" required />

    <label for="year">Release Year *</label>
    <input type="number" name="year" id="year" min="1900" max="2100" required />

    <label for="rating">Rating (0.0 – 10.0)</label>
    <input type="text" name="rating" id="rating" />

    <label for="duration">Duration (minutes)</label>
    <input type="number" name="duration" id="duration" min="1" />

    <label for="director">Director</label>
    <input type="text" name="director" id="director" />

    <button type="submit">Add Movie</button>

    <% if (messageError != null) { %>
        <p class="error"><%= messageError %></p>
    <% } else if (messageSuccess != null) { %>
        <p class="success"><%= messageSuccess %></p>
    <% } %>
</form>

<h2>All Movies in Database</h2>
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
    </tbody>
</table>

<p class="note">
    The table above demonstrates the CREATE + READ operations for at least
    five fields (id, title, genre, release year, rating, duration, director)
    using the shared MovieBean and database from Project Part 1.
</p>

</body>
</html>
