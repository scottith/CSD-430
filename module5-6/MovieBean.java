// *************************************************************
// Author: Scott Macioce
// Course: CSD430 – Server-Side Development
// Assignment: Module 6 – JavaBean DB Read (Movies)
// Purpose: JavaBean representing a single movie record and
//          helper methods to load records from the CSD430 DB.
// *************************************************************

package csd430;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class MovieBean implements Serializable {

    // ----- Fields map directly to table columns -----
    private int id;
    private String title;
    private String genre;
    private int releaseYear;
    private Double rating;
    private Integer durationMin;
    private String director;

    // ----- DB connection info (uses student1 / pass) -----
    private static final String DB_URL  =
            "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "student1";
    private static final String DB_PASS = "pass";

    // Static block loads MySQL driver once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ----- Constructors -----
    public MovieBean() { }

    public MovieBean(int id, String title, String genre, int releaseYear,
                     Double rating, Integer durationMin, String director) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.releaseYear = releaseYear;
        this.rating = rating;
        this.durationMin = durationMin;
        this.director = director;
    }

    // ----- Getters and setters (JavaBean pattern) -----
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getReleaseYear() { return releaseYear; }
    public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }

    public Integer getDurationMin() { return durationMin; }
    public void setDurationMin(Integer durationMin) { this.durationMin = durationMin; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    // ----- DB helper methods -----

    // Get a connection for internal use
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    /**
     * Returns all movie records. Used to build the dropdown list.
     */
    public static List<MovieBean> getAllMovies() {
        List<MovieBean> movies = new ArrayList<>();

        String sql = "SELECT id, title, genre, release_year, rating, " +
                     "duration_min, director FROM scott_movies_data ORDER BY title";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

        	while (rs.next()) {
        	    BigDecimal ratingDec = rs.getBigDecimal("rating");
        	    Double rating = (ratingDec != null) ? ratingDec.doubleValue() : null;

        	    MovieBean m = new MovieBean(
        	            rs.getInt("id"),
        	            rs.getString("title"),
        	            rs.getString("genre"),
        	            rs.getInt("release_year"),
        	            rating,
        	            (Integer) rs.getObject("duration_min"),
        	            rs.getString("director")
        	    );
        	    movies.add(m);
        	}


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movies;
    }

    /**
     * Loads a single movie by ID.
     */
    public static MovieBean findById(int movieId) {
        String sql = "SELECT id, title, genre, release_year, rating, " +
                     "duration_min, director FROM scott_movies_data WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
            	if (rs.next()) {
            	    BigDecimal ratingDec = rs.getBigDecimal("rating");
            	    Double rating = (ratingDec != null) ? ratingDec.doubleValue() : null;

            	    return new MovieBean(
            	            rs.getInt("id"),
            	            rs.getString("title"),
            	            rs.getString("genre"),
            	            rs.getInt("release_year"),
            	            rating,
            	            (Integer) rs.getObject("duration_min"),
            	            rs.getString("director")
            	    );
            	}
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Return empty bean if nothing found
        return new MovieBean();
    }
}
