<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/reportes_externos.css">
<script src="js/reportes_externos.js"></script>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Reportes Externos</h2>
        <a href="home_admin.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Regresar</a>
    </div>
    
    <form class="row g-3 align-items-end mb-4" method="get" action="ReportesServlet">
        <div class="col-md-3">
            <label class="form-label">Tipo de Reporte</label>
            <select name="tipoReporte" class="form-select" id="tipoReporte">
                <option value="turnos">Turnos asignados</option>
                <option value="cambios">Cambios de turno realizados</option>
                <option value="especiales">Turnos especiales</option>
                <option value="estadisticas">Estadísticas de uso</option>
                <option value="auditoria">Auditoría de actividad</option>
            </select>
        </div>
        <div class="col-md-3" id="filtroFecha">
            <label class="form-label">Fecha Desde</label>
            <input type="date" name="fechaInicio" class="form-control">
        </div>
        <div class="col-md-3" id="filtroFechaHasta">
            <label class="form-label">Fecha Hasta</label>
            <input type="date" name="fechaFin" class="form-control">
        </div>
        <div class="col-md-3" id="filtroConductor">
            <label class="form-label">Conductor</label>
            <select name="idConductor" class="form-select">
                <option value="">Todos</option>
                <c:forEach var="c" items="${conductores}">
                    <option value="${c.idConductor}">${c.nombres} ${c.apellidoPaterno} ${c.apellidoMaterno}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-12 d-flex justify-content-end gap-2">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Generar</button>
            <c:if test="${not empty reporteGenerado}">
                <a href="ReportesServlet?export=excel&${queryString}" class="btn btn-success"><i class="bi bi-file-earmark-excel"></i> Exportar Excel</a>
                <a href="ReportesServlet?export=pdf&${queryString}" class="btn btn-danger"><i class="bi bi-file-earmark-pdf"></i> Exportar PDF</a>
            </c:if>
        </div>
    </form>
    
    <!-- Tabla de resultados -->
    <c:if test="${not empty reporteGenerado}">
        <div class="table-responsive mt-4">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-secondary text-center">
                    <tr>
                        <c:forEach var="th" items="${reporteCabecera}">
                            <th>${th}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="fila" items="${reporteGenerado}">
                        <tr>
                            <c:forEach var="col" items="${fila}">
                                <td>${col}</td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty reporteGenerado}">
                        <tr><td colspan="${fn:length(reporteCabecera)}" class="text-center text-muted">No hay datos para mostrar.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
<%@ include file="templates/footer.jspf" %>