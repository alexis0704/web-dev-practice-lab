<%@ page import="com.example.student_mgmt.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("student_code");
    String name = request.getParameter("full_name");
    String email = request.getParameter("email");
    String major = request.getParameter("major");

    if (code == null || code.isBlank() || name == null || name.isBlank()) {
        response.sendRedirect("add_student.jsp?err=Required fields missing");
        return;
    }

    try {
        new StudentDAO().insert(code.trim(), name.trim(),
                                (email == null ? null : email.trim()),
                                (major == null ? null : major.trim()));
        response.sendRedirect("list_student.jsp?msg=Student added successfully");
    } catch (java.sql.SQLIntegrityConstraintViolationException dup) {
        response.sendRedirect("add_student.jsp?err=Student code already exists");
    } catch (Exception e) {
        response.sendRedirect("add_student.jsp?err=Error: " + e.getMessage());
    }
%>
