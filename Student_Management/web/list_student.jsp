<%@ page import="java.util.*,com.example.student_mgmt.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Student List</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Students</h1>

  <%
    String msg = request.getParameter("msg");
    String err = request.getParameter("err");
    if (msg != null && !msg.isBlank()) { %>
      <div class="message"><%= msg %></div>
  <% } else if (err != null && !err.isBlank()) { %>
      <div class="error"><%= err %></div>
  <% } %>

  <p><a href="add_student.jsp">+ Add Student</a></p>

  <table class="table">
    <tr>
      <th>ID</th><th>Student Code</th><th>Full Name</th><th>Email</th><th>Major</th><th>Created At</th><th>Actions</th>
    </tr>
    <%
      List<Student> students = Collections.emptyList();
      try {
          students = new StudentDAO().findAll();
      } catch (Exception e) {
          out.println("<tr><td colspan='7'><div class='error'>Database error: " + e.getMessage() + "</div></td></tr>");
      }
      for (Student s : students) {
    %>
      <tr>
        <td><%= s.getId() %></td>
        <td><%= s.getStudentCode() %></td>
        <td><%= s.getFullName() %></td>
        <td><%= s.getEmail() == null ? "" : s.getEmail() %></td>
        <td><%= s.getMajor() == null ? "" : s.getMajor() %></td>
        <td><%= s.getCreatedAt() %></td>
        <td class="actions">
          <a href="edit_student.jsp?id=<%= s.getId() %>">Edit</a>
          <a href="delete_student.jsp?id=<%= s.getId() %>"
             class="delete-link"
             onclick="return confirm('Are you sure you want to delete this student?');">
             Delete
          </a>
        </td>
      </tr>
    <% } %>
  </table>
</body>
</html>
