<%@ page import="com.example.student_mgmt.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String idStr = request.getParameter("id");
    if (idStr == null || idStr.isBlank()) {
        response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode("Missing ID", "UTF-8"));
        return;
    }

    Student s = null;
    String err = null;
    try {
        int id = Integer.parseInt(idStr);
        s = new StudentDAO().findById(id);
        if (s == null) err = "Student not found";
    } catch (NumberFormatException nfe) {
        err = "Invalid ID";
    } catch (Exception ex) {
        err = "Error: " + ex.getMessage();
    }

    if (err != null) {
        response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode(err, "UTF-8"));
        return;
    }

    String pageErr = request.getParameter("err");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Edit Student</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Edit Student</h1>

  <% if (pageErr != null && !pageErr.isBlank()) { %>
    <div class="error"><%= pageErr %></div>
  <% } %>

  <form action="process_edit.jsp" method="post">
    <input type="hidden" name="id" value="<%= s.getId() %>">

    <label>Student Code (read only):
      <input type="text" value="<%= s.getStudentCode() %>" readonly>
    </label><br><br>

    <label>Full Name*:
      <input type="text" name="full_name" value="<%= s.getFullName() %>" required>
    </label><br><br>

    <label>Email:
      <input type="email" name="email" value="<%= s.getEmail() == null ? "" : s.getEmail() %>">
    </label><br><br>

    <label>Major:
      <input type="text" name="major" value="<%= s.getMajor() == null ? "" : s.getMajor() %>">
    </label><br><br>

    <button type="submit">Save</button>
    <a href="list_student.jsp">Cancel</a>
  </form>
</body>
</html>
