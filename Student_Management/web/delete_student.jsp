<%@ page import="com.example.student_mgmt.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null || idStr.isBlank()) {
        response.sendRedirect("list_student.jsp?err=Missing ID");
        return;
    }

    try {
        int id = Integer.parseInt(idStr);
        int rows = new StudentDAO().delete(id);
        if (rows == 0) {
            response.sendRedirect("list_student.jsp?err=ID not found");
        } else {
            response.sendRedirect("list_student.jsp?msg=Student deleted");
        }
    } catch (NumberFormatException nfe) {
        response.sendRedirect("list_student.jsp?err=Invalid ID");
    } catch (Exception e) {
        response.sendRedirect("list_student.jsp?err=" + java.net.URLEncoder.encode(e.getMessage(),"UTF-8"));
    }
%>
