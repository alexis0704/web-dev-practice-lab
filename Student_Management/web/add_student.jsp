<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Add Student</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Add Student</h1>

  <%
    String msg = request.getParameter("msg");
    String err = request.getParameter("err");
    if (msg != null && !msg.isBlank()) {
  %>
      <div class="message"><%= msg %></div>
  <%
    } else if (err != null && !err.isBlank()) {
  %>
      <div class="error"><%= err %></div>
  <%
    }
  %>

  <form action="process_add.jsp" method="post"> 
    <label>Student Code*:
      <input type="text" name="student_code" required>
    </label><br><br>

    <label>Full Name*:
      <input type="text" name="full_name" required>
    </label><br><br>

    <label>Email:
      <input type="email" name="email">
    </label><br><br>

    <label>Major:
      <input type="text" name="major">
    </label><br><br>

    <button type="submit">Submit</button>
    <a href="list_student.jsp">Cancel</a> 
  </form>

</body>
</html>
