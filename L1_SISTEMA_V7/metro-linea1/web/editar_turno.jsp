<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="templates/header_admin.jspf" %>
<%
    pe.linea1.model.Turno turno = (pe.linea1.model.Turno) request.getAttribute("turno");
%>
<div class="container py-4">
    <h2 class="mb-4 text-center">Editar Turno</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form action="EditarTurnoServlet" method="post" autocomplete="off">
        <input type="hidden" name="idTurno" value="<%= turno.getIdTurno() %>">
        <input type="hidden" name="idConductor" value="<%= turno.getIdConductor() %>">
        <div class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Día Semana*</label>
                <select name="diaSemana" class="form-select" required>
                    <option value="LUNES" <%= "LUNES".equals(turno.getDiaSemana()) ? "selected" : "" %>>Lunes</option>
                    <option value="MARTES" <%= "MARTES".equals(turno.getDiaSemana()) ? "selected" : "" %>>Martes</option>
                    <option value="MIERCOLES" <%= "MIERCOLES".equals(turno.getDiaSemana()) ? "selected" : "" %>>Miércoles</option>
                    <option value="JUEVES" <%= "JUEVES".equals(turno.getDiaSemana()) ? "selected" : "" %>>Jueves</option>
                    <option value="VIERNES" <%= "VIERNES".equals(turno.getDiaSemana()) ? "selected" : "" %>>Viernes</option>
                    <option value="SABADO" <%= "SABADO".equals(turno.getDiaSemana()) ? "selected" : "" %>>Sábado</option>
                    <option value="DOMINGO" <%= "DOMINGO".equals(turno.getDiaSemana()) ? "selected" : "" %>>Domingo</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Fecha*</label>
                <input type="date" name="fecha" class="form-control" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(turno.getFecha()) %>" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Inicio*</label>
                <input type="time" name="horaInicio" class="form-control" value="<%= turno.getHoraInicio() %>" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Fin*</label>
                <input type="time" name="horaFin" class="form-control" value="<%= turno.getHoraFin() %>" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Carreras*</label>
                <input type="number" name="carreras" class="form-control" value="<%= turno.getCarreras() %>" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Saldo Tiempo (min)</label>
                <input type="number" name="saldoTiempo" class="form-control" value="<%= turno.getSaldoTiempo() %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Tiempo Laborado (min)</label>
                <input type="number" name="tiempoLaborado" class="form-control" value="<%= turno.getTiempoLaborado() %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Turno Anterior (opcional)</label>
                <input type="number" name="turnoAnterior" class="form-control" value="<%= turno.getTurnoAnterior() != null ? turno.getTurnoAnterior() : "" %>">
            </div>
            <div class="col-md-12">
                <label class="form-label">Observaciones</label>
                <input type="text" name="observaciones" class="form-control" value="<%= turno.getObservaciones() %>">
            </div>
        </div>
        <div class="d-flex justify-content-center mt-4 gap-2">
            <button type="submit" class="btn btn-primary px-4">Guardar Cambios</button>
            <a href="VerTurnosServlet" class="btn btn-secondary px-4">Cancelar</a>
        </div>
    </form>
</div>
<%@ include file="templates/footer.jspf" %>
