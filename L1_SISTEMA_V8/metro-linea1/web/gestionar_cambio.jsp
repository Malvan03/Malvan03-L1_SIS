<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="templates/header_conductor.jspf" %>
<link rel="stylesheet" href="css/gestionar_cambio.css">

<div class="container py-4">
    <h2 class="mb-4 text-success text-center">Solicitud de Cambio de Turno</h2>
    <form method="POST" action="GestionarCambioServlet" class="card p-4 shadow-sm mb-3">
        <div class="mb-3">
            <label class="form-label">Turno que deseo cambiar:</label>
            <select name="idTurnoOriginal" class="form-select" required>
                <option value="">Seleccione un turno</option>
                <c:forEach var="turno" items="${turnosConductor}">
                    <option value="${turno.idTurno}">
                        ${turno.diaSemana} - ${turno.horaInicio} a ${turno.horaFin} (${turno.fecha})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Rango de horario que necesito:</label>
            <div class="row g-2">
                <div class="col">
                    <input type="time" name="horaInicio" class="form-control" required>
                </div>
                <div class="col">
                    <input type="time" name="horaFin" class="form-control" required>
                </div>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Seleccione conductor para intercambiar turno:</label>
            <select name="idConductorDestino" class="form-select" required>
                <option value="">Seleccione un conductor</option>
                <c:forEach var="c" items="${conductoresDisponibles}">
                    <option value="${c.idConductor}">
                        ${c.nombres} ${c.apellidoPaterno} ${c.apellidoMaterno}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Seleccione el turno destino:</label>
            <select name="idTurnoNuevo" class="form-select" required>
                <option value="">Seleccione turno destino</option>
                <c:forEach var="turno" items="${turnosDestino}">
                    <option value="${turno.idTurno}">
                        ${turno.diaSemana} - ${turno.horaInicio} a ${turno.horaFin} (${turno.fecha})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Mensaje (motivo):</label>
            <input type="text" name="mensaje" maxlength="255" class="form-control">
        </div>

        <div class="d-flex justify-content-center gap-2">
            <button type="submit" class="btn btn-success px-4">Solicitar Cambio</button>
            <a href="home_conductor.jsp" class="btn btn-secondary px-4">Regresar</a>
        </div>
    </form>

    <c:if test="${not empty error}">
        <div class="alert alert-danger text-center">${error}</div>
    </c:if>
</div>
<%@ include file="templates/footer.jspf" %>
