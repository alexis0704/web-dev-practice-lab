<%@ page import="com.example.student_mgmt.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String idStr   = request.getParameter("id");
    String name    = request.getParameter("full_name");
    String email   = request.getParameter("email");
    String major   = request.getParameter("major");

    int id;
    try {
        id = Integer.parseInt(idStr);
    } catch (Exception e) {
        response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode("Invalid or missing ID", "UTF-8"));
        return;
    }

    if (name == null || name.isBlank()) {
        response.sendRedirect("edit_student.jsp?id=" + id + "&err=" + java.net.URLEncoder.encode("Required field missing: Full Name", "UTF-8"));
        return;
    }

    email = (email == null || email.isBlank()) ? null : email.trim();
    major = (major == null || major.isBlank()) ? null : major.trim();

    try {
        Student existing = new StudentDAO().findById(id);
        if (existing == null) {
            response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode("Student not found", "UTF-8"));
            return;
        }

        int rows = new StudentDAO().update(id, name.trim(), email, major);
        if (rows == 0) {
            response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode("Update failed (no rows affected)", "UTF-8"));
        } else {
            response.sendRedirect("list_student.jsp?msg=" + java.net.URLEncoder.encode("Student updated successfully", "UTF-8"));
        }
    } catch (java.sql.SQLIntegrityConstraintViolationException dup) {
        response.sendRedirect("edit_student.jsp?id=" + id + "&err=" + java.net.URLEncoder.encode("Email already exists", "UTF-8"));
    } catch (Exception e) {
        response.sendRedirect("edit_student.jsp?id=" + id + "&err=" + java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
    }
%>
