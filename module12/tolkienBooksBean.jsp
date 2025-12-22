<%--
 Name: Scott Macioce
 Course: CSD430 - Server-Side Development
 Assignment: Module 12 - Module 4 rework
 Purpose: Create TolkienBook JavaBean objects, store them in a list, and display them
          in an HTML table format using JSP scriptlets
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList, java.util.List, csd430.TolkienBook" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tolkien Books - JavaBean Data Display</title>

    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        h1 { margin-bottom: 4px; }
        .subtitle { color: #555; margin-top: 0; }
        .desc { max-width: 900px; color: #333; }
        table { border-collapse: collapse; width: 100%; margin-top: 14px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #f2f2f2; }
        caption { caption-side: top; text-align: left; font-weight: bold; margin-bottom: 8px; }
        .note { margin-top: 12px; color: #444; }
        code { background: #f6f6f6; padding: 2px 5px; border-radius: 4px; }
    </style>
</head>

<body>

<h1>Tolkien Book Records</h1>
<p class="subtitle">JavaBean + JSP Scriptlet Data Display</p>

<p class="desc">
    This page demonstrates using a <code>Serializable</code> JavaBean (<code>TolkienBook</code>)
    to hold book record data, then displaying those records in an HTML table.
    Java code is kept inside scriptlets while all HTML tags remain outside scriptlets.
</p>

<%
    // Create list of TolkienBook beans
    List<TolkienBook> books = new ArrayList<TolkienBook>();

    books.add(new TolkienBook("The Hobbit", "Middle-earth (Pre-LOTR)", 1937, "Novel", 310, "The Shire / Lonely Mountain"));
    books.add(new TolkienBook("The Fellowship of the Ring", "The Lord of the Rings", 1954, "Novel", 423, "Rivendell / Moria"));
    books.add(new TolkienBook("The Two Towers", "The Lord of the Rings", 1954, "Novel", 352, "Rohan / Isengard"));
    books.add(new TolkienBook("The Return of the King", "The Lord of the Rings", 1955, "Novel", 416, "Gondor / Mordor"));
    books.add(new TolkienBook("The Silmarillion", "Middle-earth (Legendarium)", 1977, "Mythopoeia", 365, "Valinor / Beleriand"));

    
    request.setAttribute("books", books);
%>

<table>
    <caption>Book Data Table (5+ Fields, 5+ Records)</caption>
    <thead>
        <tr>
            <th>Title</th>
            <th>Series</th>
            <th>Publication Year</th>
            <th>Format</th>
            <th>Pages</th>
            <th>Main Setting</th>
        </tr>
    </thead>
    <tbody>
        <%
            // Retrieve list from request scope
            List<TolkienBook> displayBooks = (List<TolkienBook>) request.getAttribute("books");

            for (TolkienBook b : displayBooks) {
        %>
        <tr>
            <td><%= b.getTitle() %></td>
            <td><%= b.getSeries() %></td>
            <td><%= b.getPublicationYear() %></td>
            <td><%= b.getFormat() %></td>
            <td><%= b.getPages() %></td>
            <td><%= b.getMainSetting() %></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<p class="note">
    Field descriptions: Title = name of the book, Series = collection it belongs to, Publication Year = original release year,
    Format = type of writing, Pages = approximate page count, Main Setting = primary locations.
</p>

</body>
</html>
