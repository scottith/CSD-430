// *************************************************************
// Author: Scott Macioce
// Course: CSD430 – Server-Side Development
// Assignment: Project – Part 2 Update
// Purpose: JavaBean representing a movie record and providing
//          helper methods to read/insert data from/to CSD430 DB
// *************************************************************

package csd430;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // ----- Fields map directly to table columns -----
    private int id;
    private String title;
    private String genre;
    private int releaseYear;
    private Double rating;
    private Integer durationMin;
    private String director;

    // ----- DB connection info -----
    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "student1";
    private static final String DB_PASS = "pass";

    // Load MySQL driver once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ----- Constructors -----
    public MovieBean() {}

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

    // ----- Getters / setters -----
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

    // ----- Internal connection helper -----
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    
    // Return all movie records

    public static List<MovieBean> getAllMovies() {
        List<MovieBean> movies = new ArrayList<>();

        String sql = "SELECT id, title, genre, release_year, rating, " +
                     "duration_min, director FROM scott_movies_data ORDER BY id";

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


    // Find a single movie by its primary key

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

        return new MovieBean(); // empty bean if not found
    }


    // Insert a new movie record

    public static void insertMovie(String title, String genre, int releaseYear,
                                   Double rating, Integer durationMin, String director) {

        String sql = "INSERT INTO scott_movies_data " +
                     "(title, genre, release_year, rating, duration_min, director) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, genre);
            ps.setInt(3, releaseYear);

            if (rating != null) {
                ps.setBigDecimal(4, BigDecimal.valueOf(rating));
            } else {
                ps.setNull(4, Types.DECIMAL);
            }

            if (durationMin != null) {
                ps.setInt(5, durationMin);
            } else {
                ps.setNull(5, Types.INTEGER);
            }

            ps.setString(6, director);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    

 // Modify an existing movie record

 public static void updateMovie(int id, String title, String genre, int releaseYear,
                                Double rating, Integer durationMin, String director) {

     String sql = "UPDATE scott_movies_data " +
                  "SET title = ?, genre = ?, release_year = ?, rating = ?, " +
                  "duration_min = ?, director = ? WHERE id = ?";

     try (Connection conn = getConnection();
          PreparedStatement ps = conn.prepareStatement(sql)) {

         ps.setString(1, title);
         ps.setString(2, genre);
         ps.setInt(3, releaseYear);

         if (rating != null) {
             ps.setBigDecimal(4, BigDecimal.valueOf(rating));
         } else {
             ps.setNull(4, Types.DECIMAL);
         }

         if (durationMin != null) {
             ps.setInt(5, durationMin);
         } else {
             ps.setNull(5, Types.INTEGER);
         }

         ps.setString(6, director);
         ps.setInt(7, id);

         ps.executeUpdate();
     } catch (SQLException e) {
         e.printStackTrace();
     }
 }
 

//DELETE: Remove an existing movie by ID

public static void deleteMovie(int id) {

  String sql = "DELETE FROM scott_movies_data WHERE id = ?";

  try (Connection conn = getConnection();
       PreparedStatement ps = conn.prepareStatement(sql)) {

      ps.setInt(1, id);
      ps.executeUpdate();

  } catch (SQLException e) {
      e.printStackTrace();
  }
}

}
