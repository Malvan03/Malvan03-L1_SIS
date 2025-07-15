<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="templates/header_admin.jspf" %>
<div class="container py-4">
    <h2 class="mb-4 text-center">Agregar Turno</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form action="AgregarTurnoServlet" method="post" autocomplete="off">
        <div class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Día Semana*</label>
                <select name="diaSemana" class="form-select" required>
                    <option value="LUNES">Lunes</option>
                    <option value="MARTES">Martes</option>
                    <option value="MIERCOLES">Miércoles</option>
                    <option value="JUEVES">Jueves</option>
                    <option value="VIERNES">Viernes</option>
                    <option value="SABADO">Sábado</option>
                    <option value="DOMINGO">Domingo</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Fecha*</label>
                <input type="date" name="fecha" class="form-control" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Inicio*</label>
                <input type="time" name="horaInicio" class="form-control" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Hora Fin*</label>
                <input type="time" name="horaFin" class="form-control" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Carreras*</label>
                <input type="number" name="carreras" class="form-control" min="1" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Saldo Tiempo (min)</label>
                <input type="number" name="saldoTiempo" class="form-control" value="0">
            </div>
            <div class="col-md-3">
                <label class="form-label">Tiempo Laborado (min)</label>
                <input type="number" name="tiempoLaborado" class="form-control" value="0">
            </div>
            <div class="col-md-3">
                <label class="form-label">Turno Anterior (opcional)</label>
                <input type="number" name="turnoAnterior" class="form-control">
            </div>
            <div class="col-md-12">
                <label class="form-label">Observaciones</label>
                <input type="text" name="observaciones" class="form-control">
            </div>
        </div>
        <div class="d-flex justify-content-center mt-4 gap-2">
            <button type="submit" class="btn btn-success px-4">Agregar</button>
            <a href="VerTurnosServlet" class="btn btn-secondary px-4">Cancelar</a>
        </div>
    </form>
</div>
<%@ include file="templates/footer.jspf" %>
