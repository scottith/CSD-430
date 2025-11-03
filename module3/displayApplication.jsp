<%-- 
  Scott Macioce
  CSD430 – Server-Side Development
  Module 3 – User Data Form (Job Application)
  10/31/2025
  Receive POSTed form data, minimally validate with scriptlets, and display in an HTML table.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%!
// Small HTML escape helper to keep output safe in this simple example
private static String esc(String s) {
  if (s == null) return "";
  return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
          .replace("\"","&quot;").replace("'","&#x27;");
}
%>

<%
  request.setCharacterEncoding("UTF-8");

  // Retrieve parameters
  String fullName   = request.getParameter("fullName");
  String email      = request.getParameter("email");
  String phone      = request.getParameter("phone");
  String position   = request.getParameter("position");
  String yearsExp   = request.getParameter("yearsExp");
  String startDate  = request.getParameter("startDate");
  String resumeUrl  = request.getParameter("resumeUrl");
  String cover      = request.getParameter("coverLetter");
  String workAuth   = request.getParameter("workAuth");

  // Minimal validation and defaults
  if (fullName == null || fullName.trim().isEmpty()) fullName = "(missing)";
  if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) email = "(invalid email format)";
  if (phone == null || phone.trim().isEmpty()) phone = "(missing)";
  if (position == null || position.isBlank()) position = "(not selected)";
  if (yearsExp == null || yearsExp.isBlank()) yearsExp = "0";
  if (workAuth == null) workAuth = "(not answered)";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Application Received</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    h1, h2 { margin-bottom: .25rem; }
    .desc { color:#555; margin-bottom: 1rem; }
    table { border-collapse: collapse; min-width: 720px; }
    th, td { border:1px solid #ddd; padding:.65rem; vertical-align: top; }
    th { background:#f7f7f7; text-align: left; width: 240px; }
    .ok { color: #137333; }
    .warn { color: #b80606; }
  </style>
</head>
<body>
  <h1>Application Received</h1>
  <p class="desc">
    The table below summarizes the data you submitted. Values are rendered on the server using JSP scriptlets
    and expressions, meeting the assignment’s server-side requirement.
  </p>

  <h2>Applicant Summary</h2>
  <table>
    <tr><th>Full Name</th><td><%= esc(fullName) %></td></tr>
    <tr><th>Email</th><td><%= esc(email) %></td></tr>
    <tr><th>Phone</th><td><%= esc(phone) %></td></tr>
    <tr><th>Position</th><td><%= esc(position) %></td></tr>
    <tr><th>Years of Experience</th><td><%= esc(yearsExp) %> years</td></tr>
    <tr><th>Earliest Start Date</th><td><%= esc(startDate == null || startDate.isBlank() ? "(not provided)" : startDate) %></td></tr>
    <tr><th>Résumé URL</th>
      <td>
        <%
          if (resumeUrl != null && resumeUrl.startsWith("http")) {
        %>
          <a href="<%= esc(resumeUrl) %>" target="_blank"><%= esc(resumeUrl) %></a>
        <%
          } else {
        %>
          <span class="warn">(not provided or invalid)</span>
        <%
          }
        %>
      </td>
    </tr>
    <tr><th>Authorization to Work</th><td><%= esc(workAuth) %></td></tr>
    <tr><th>Cover Letter / Notes</th><td><pre style="white-space:pre-wrap;margin:0;"><%= esc(cover) %></pre></td></tr>
  </table>

  <p class="desc">
    <strong>Notes:</strong> This page demonstrates: (1) HTML outside Java code, (2) Scriptlets for server-side logic,
    (3) Data displayed in an HTML table, and (4) Field/record descriptions via table headers and section text.
  </p>

  <p><a href="applicationForm.jsp">← Submit another application</a></p>
</body>
</html>