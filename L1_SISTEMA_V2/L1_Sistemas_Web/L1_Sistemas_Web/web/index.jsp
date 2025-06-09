<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    if (usuario == null || rol == null) {
        response.sendRedirect("login.jsp"); // No hay sesión activa
        return;
    }

    if ("ADMIN".equals(rol)) {
        response.sendRedirect("home_admin.jsp");
    } else if ("CONDUCTOR".equals(rol)) {
        response.sendRedirect("home_conductor.jsp");
    } else {
        response.sendRedirect("login.jsp"); // Por si acaso el rol no es válido
    }
%>
