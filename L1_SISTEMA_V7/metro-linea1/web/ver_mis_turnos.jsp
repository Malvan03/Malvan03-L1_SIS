<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pe.linea1.model.Usuario usuario = (pe.linea1.model.Usuario) session.getAttribute("usuario");
    if (usuario == null || !"CONDUCTOR".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nombre = usuario.getNombres();
    if (usuario.getApellidoPaterno() != null && !usuario.getApellidoPaterno().isEmpty()) nombre += " " + usuario.getApellidoPaterno();
    if (usuario.getApellidoMaterno() != null && !usuario.getApellidoMaterno().isEmpty()) nombre += " " + usuario.getApellidoMaterno();
    String foto = (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty()) ? usuario.getFotoPerfil() : "default_avatar.png";
    String fechaHoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
    String dni = usuario.getDni();
%>
<%@ include file="templates/header_conductor.jspf" %>
<div class="container py-4">
    <!-- Encabezado estético y alineado -->
    <div class="ver-turnos-header row align-items-center mb-4 px-2">
        <div class="col-md-8 col-12">
            <h2 class="mb-1 fw-bold">VER MIS TURNOS</h2>
            <div class="mb-1" style="font-size:1.15em; color:#2376d9;">
                <strong><i class="bi bi-person-badge"></i> <%= nombre %></strong>
            </div>
            <div class="mb-1 text-secondary" style="font-size:1em;">
                <i class="bi bi-calendar-event"></i> <%= fechaHoy %>
            </div>
            <div class="mb-1 text-muted" style="font-size:1em;">
                <i class="bi bi-credit-card"></i> <span class="fw-bold">DNI:</span> <%= dni %>
            </div>
        </div>
        <div class="col-md-4 col-12 d-flex align-items-center justify-content-md-end justify-content-start mt-md-0 mt-3 gap-3">
            <img src="images/<%= foto %>" alt="Foto de perfil" class="rounded-circle border border-2 border-success shadow" width="70" height="70" style="object-fit:cover;">
            <button class="btn btn-outline-success btn-sm" onclick="window.location.href='editar_perfil.jsp'" title="Editar perfil">
                <i class="bi bi-gear"></i>
            </button>
        </div>
    </div>
    <hr>
    <!-- Tabla de turnos -->
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="table-success">
                <tr>
                    <th>Día</th>
                    <th>Turno</th>
                    <th>Hora de inicio</th>
                    <th>Hora de salida</th>
                    <th>Carreras</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="turno" items="${misTurnos}">
                    <tr>
                        <td>${turno.dia}</td>
                        <td>${turno.nombreTurno}</td>
                        <td>${turno.horaInicio}</td>
                        <td>${turno.horaSalida}</td>
                        <td>${turno.carreras}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty misTurnos}">
                    <tr>
                        <td colspan="5" class="text-center">No tienes turnos asignados.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <div class="mt-4 d-flex justify-content-between flex-wrap gap-2">
        <button class="btn btn-outline-secondary" onclick="window.history.back()">
            <i class="bi bi-arrow-left"></i> Regresar
        </button>
        <a href="gestionar_cambio.jsp" class="btn btn-primary">
            ¿DESEAS REALIZAR ALGÚN CAMBIO?
        </a>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
<link rel="stylesheet" href="css/ver_mis_turnos.css">