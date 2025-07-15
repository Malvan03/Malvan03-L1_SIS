<%@page language="java" contentType="text/html; charset=UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pe.linea1.model.Usuario usuario = (pe.linea1.model.Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"CONDUCTOR".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect("login.jsp?error=tipo");
        return;
    }
    String nombre = usuario.getNombres();
    String apellidoPaterno = usuario.getApellidoPaterno() == null ? "" : usuario.getApellidoPaterno();
    String apellidoMaterno = usuario.getApellidoMaterno() == null ? "" : usuario.getApellidoMaterno();
    String foto = (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty()) ? usuario.getFotoPerfil() : "default_avatar.png";
    String fechaHoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Home Conductor | Metro Línea 1</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/home_conductor.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>
<div class="container-home">
    <div class="header d-flex justify-content-between align-items-center p-3 mb-4 shadow-sm bg-white rounded">
        <img src="images/LOGOL1.png" alt="Logo Línea 1" class="logo" style="height:60px;cursor:pointer;" onclick="window.location.href='home_conductor.jsp'">

        <div class="welcome text-center flex-grow-1">
            <div class="modo-conductor fw-bold" style="color:#43b049;">Modo Conductor</div>
            <div>Bienvenido <b><%= nombre %> <%= apellidoPaterno %> <%= apellidoMaterno %></b></div>
            <div class="fecha text-secondary" style="font-size:0.98em;"><%= fechaHoy %></div>
        </div>

        <div class="user-panel d-flex align-items-center gap-3">
            <img src="images/<%= foto %>" alt="Foto de perfil" class="user-foto rounded-circle" width="50" height="50">
            <button class="btn btn-outline-success btn-sm" onclick="window.location.href='editar_perfil.jsp'" title="Editar perfil">
                <span class="bi bi-gear"></span> Perfil
            </button>
            <button class="btn btn-danger btn-sm" onclick="window.location.href='logout.jsp'">Salir</button>
        </div>
    </div>

    <div class="main-conductor-menu d-flex flex-wrap gap-3 justify-content-center mb-5">
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='ver_mis_turnos.jsp'"><i class="bi bi-calendar2-check"></i> Ver mis turnos</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='gestionar_cambio.jsp'"><i class="bi bi-arrow-repeat"></i> Gestionar Cambio</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='historial_cambios_conductor.jsp'"><i class="bi bi-clock-history"></i> Historial de Cambios</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='solicitudes_cambio_conductor.jsp'"><i class="bi bi-bell"></i> Solicitudes de Cambio</button>
    </div>

    <div class="ayuda-conductor text-center mb-3">
        <a href="mailto:soporte@linea1.com" class="btn btn-link"><i class="bi bi-info-circle"></i> ¿Necesitas ayuda? Escríbenos</a>
    </div>
</div>
<%@include file="templates/footer.jspf"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
