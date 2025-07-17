<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<%@ include file="templates/header_conductor.jspf" %>
<link rel="stylesheet" href="css/ver_mis_turnos.css">

<%
    // Asegurarse que la fecha actual esté disponible para la vista si no se pasa desde el controlador
    if (request.getAttribute("now") == null) {
        request.setAttribute("now", new Date());
    }
%>

<div class="container py-4">
    <!-- Encabezado estético y alineado -->
    <div class="ver-turnos-header row align-items-center mb-4 px-2">
        <div class="col-md-8 col-12">
            <h2 class="mb-1 fw-bold">VER MIS TURNOS</h2>
            <div class="mb-1" style="font-size:1.15em; color:#2376d9;">
                <strong>
                    <i class="bi bi-person-badge"></i> 
                    <c:out value="${sessionScope.nombre}" />
                </strong>
            </div>
            <div class="mb-1 text-secondary" style="font-size:1em;">
                <i class="bi bi-calendar-event"></i>
                <fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/>
            </div>
            <div class="mb-1 text-muted" style="font-size:1em;">
                <i class="bi bi-credit-card"></i> <span class="fw-bold">DNI:</span> 
                <c:out value="${sessionScope.dni}" />
            </div>
        </div>
        <div class="col-md-4 col-12 d-flex align-items-center justify-content-md-end justify-content-start mt-md-0 mt-3 gap-3">
            <img src="images/<c:out value='${sessionScope.foto}'/>" alt="Foto de perfil" class="rounded-circle border border-2 border-success shadow" width="70" height="70" style="object-fit:cover;">
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
                    <th>ID Turno</th>
                    <th>Hora de inicio</th>
                    <th>Hora de salida</th>
                    <th>Carreras</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty misTurnos}">
                    <c:forEach var="turno" items="${misTurnos}">
                        <tr>
                            <td><c:out value="${turno.diaSemana}" /></td>
                            <td><c:out value="${turno.idTurno}" /></td>
                            <td><c:out value="${turno.horaInicio}" /></td>
                            <td><c:out value="${turno.horaFin}" /></td>
                            <td><c:out value="${turno.carreras}" /></td>
                        </tr>
                    </c:forEach>
                </c:if>
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