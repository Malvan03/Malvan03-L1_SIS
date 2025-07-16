<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%
    // Invalidar la sesión
    if (session != null) {
        session.invalidate();
    }
    // Prevenir cacheo en el navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    // Redirige a login.jsp
    response.sendRedirect("login.jsp");
%>
