<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/gestion_conductores.css">

<div class="container py-4">
    <h2 class="mb-4 text-center text-primary">Editar Turno</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form action="EditarTurnoServlet" method="post" autocomplete="off">
        <input type="hidden" name="idTurno" value="${turno.idTurno}">
        <input type="hidden" name="idConductor" value="${turno.idConductor}">
        <div class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Día Semana*</label>
                <select name="diaSemana" class="form-select" required>
                    <option value="LUNES" ${turno.diaSemana eq 'LUNES' ? 'selected' : ''}>Lunes</option>
                    <option value="MARTES" ${turno.diaSemana eq 'MARTES' ? 'selected' : ''}>Martes</option>
                    <option value="MIERCOLES" ${turno.diaSemana eq 'MIERCOLES' ? 'selected' : ''}>Miércoles</option>
                    <option value="JUEVES" ${turno.diaSemana eq 'JUEVES' ? 'selected' : ''}>Jueves</option>
                    <option value="VIERNES" ${turno.diaSemana eq 'VIERNES' ? 'selected' : ''}>Viernes</option>
                    <option value="SABADO" ${turno.diaSemana eq 'SABADO' ? 'selected' : ''}>Sábado</option>
                    <option value="DOMINGO" ${turno.diaSemana eq 'DOMINGO' ? 'selected' : ''}>Domingo</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Fecha*</label>
                <input type="date" name="fecha" class="form-control"
                       value="${turno.fecha}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Inicio*</label>
                <input type="time" name="horaInicio" class="form-control"
                       value="${turno.horaInicio}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Fin*</label>
                <input type="time" name="horaFin" class="form-control"
                       value="${turno.horaFin}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Carreras*</label>
                <input type="number" name="carreras" class="form-control"
                       value="${turno.carreras}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Saldo Tiempo (min)</label>
                <input type="number" name="saldoTiempo" class="form-control"
                       value="${turno.saldoTiempo}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Tiempo Laborado (min)</label>
                <input type="number" name="tiempoLaborado" class="form-control"
                       value="${turno.tiempoLaborado}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Turno Anterior (opcional)</label>
                <input type="number" name="turnoAnterior" class="form-control"
                       value="${empty turno.turnoAnterior ? '' : turno.turnoAnterior}">
            </div>
            <div class="col-md-12">
                <label class="form-label">Observaciones</label>
                <input type="text" name="observaciones" class="form-control"
                       value="${turno.observaciones}">
            </div>
        </div>
        <div class="d-flex justify-content-center mt-4 gap-2">
            <button type="submit" class="btn btn-primary px-4">Guardar Cambios</button>
            <a href="VerTurnosServlet" class="btn btn-secondary px-4">Cancelar</a>
        </div>
    </form>
</div>
<%@ include file="templates/footer.jspf" %>
