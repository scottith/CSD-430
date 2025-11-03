<%-- 
  Scott Macioce
  CSD430 – Server-Side Development
  Module 3 – User Data Form (Job Application)
  10/31/2025
  Collect job application data using multiple input types (text, email, number, date, select, textarea)
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Job Application Form</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    fieldset { border: 1px solid #ddd; padding: 1rem 1.5rem; margin-bottom: 1rem; }
    legend { font-weight: bold; }
    label { display:block; margin-top: .6rem; }
    input, select, textarea { width: 100%; max-width: 520px; padding: .5rem; }
    .hint { color:#666; font-size:.9rem; }
    .actions { margin-top: 1rem; }
  </style>
</head>
<body>
  <h1>Job Application</h1>
  <p class="hint">Please complete all required fields (marked *). Your information will be reviewed by our team.</p>

  <!-- The form submits to the JSP that will display the data -->
  <form method="post" action="displayApplication.jsp">
    <fieldset>
      <legend>Applicant Information</legend>
      <label for="fullName">Full Name *</label>
      <input type="text" id="fullName" name="fullName" required />

      <label for="email">Email *</label>
      <input type="email" id="email" name="email" required />

      <label for="phone">Phone *</label>
      <input type="tel" id="phone" name="phone" placeholder="555-123-4567" required />
    </fieldset>

    <fieldset>
      <legend>Position Details</legend>
      <label for="position">Position Applying For *</label>
      <select id="position" name="position" required>
        <option value="">-- Select a position --</option>
        <option value="Software Engineer I">Software Engineer I</option>
        <option value="QA Analyst">QA Analyst</option>
        <option value="DevOps Intern">DevOps Intern</option>
      </select>

      <label for="yearsExp">Years of Experience *</label>
      <input type="number" id="yearsExp" name="yearsExp" min="0" max="50" step="1" required />

      <label for="startDate">Earliest Start Date</label>
      <input type="date" id="startDate" name="startDate" />
    </fieldset>

    <fieldset>
      <legend>Extras</legend>
      <label for="resumeUrl">Résumé URL (GitHub/Portfolio)</label>
      <input type="url" id="resumeUrl" name="resumeUrl" placeholder="https://example.com/resume" />

      <label for="coverLetter">Cover Letter / Notes</label>
      <textarea id="coverLetter" name="coverLetter" rows="5" placeholder="Briefly introduce yourself..."></textarea>

      <label>Authorization to work in the U.S.? *</label>
      <label><input type="radio" name="workAuth" value="Yes" required /> Yes</label>
      <label><input type="radio" name="workAuth" value="No" /> No</label>
    </fieldset>

    <div class="actions">
      <button type="submit">Submit Application</button>
      <button type="reset">Clear</button>
    </div>
  </form>
</body>
</html>
