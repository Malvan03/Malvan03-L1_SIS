<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/auditoria.css">
<script src="js/auditoria.js"></script>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Auditoría de Actividad</h2>
        <a href="home_admin.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Regresar</a>
    </div>

    <form class="row g-3 align-items-end mb-4" method="get" action="AuditoriaServlet">
        <div class="col-md-3">
            <label class="form-label">Usuario</label>
            <select name="idUsuario" class="form-select">
                <option value="">Todos</option>
                <c:forEach var="u" items="${usuarios}">
                    <option value="${u.idUsuario}" <c:if test="${param.idUsuario == u.idUsuario}">selected</c:if>>
                        ${u.nombres} ${u.apellidoPaterno} ${u.apellidoMaterno}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <label class="form-label">Tipo de Acción</label>
            <select name="tipoAccion" class="form-select">
                <option value="">Todas</option>
                <c:forEach var="t" items="${tiposAccion}">
                    <option value="${t}" <c:if test="${param.tipoAccion == t}">selected</c:if>>${t}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <label class="form-label">Fecha Desde</label>
            <input type="date" name="fechaInicio" class="form-control" value="${param.fechaInicio}">
        </div>
        <div class="col-md-3">
            <label class="form-label">Fecha Hasta</label>
            <input type="date" name="fechaFin" class="form-control" value="${param.fechaFin}">
        </div>
        <div class="col-md-12 d-flex justify-content-end gap-2">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Buscar</button>
            <c:if test="${not empty auditorias}">
                <a href="AuditoriaServlet?export=excel&${queryString}" class="btn btn-success"><i class="bi bi-file-earmark-excel"></i> Exportar Excel</a>
                <a href="AuditoriaServlet?export=pdf&${queryString}" class="btn btn-danger"><i class="bi bi-file-earmark-pdf"></i> Exportar PDF</a>
            </c:if>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-secondary text-center">
                <tr>
                    <th>Usuario</th>
                    <th>Rol</th>
                    <th>Acción</th>
                    <th>Fecha/Hora</th>
                    <th>Descripción</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${auditorias}">
                    <tr>
                        <td><c:out value="${a.usuario.nombres}"/> <c:out value="${a.usuario.apellidoPaterno}"/> <c:out value="${a.usuario.apellidoMaterno}"/></td>
                        <td><c:out value="${a.usuario.rol}"/></td>
                        <td><c:out value="${a.tipoAccion}"/></td>
                        <td><fmt:formatDate value="${a.fechaHora}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                        <td><c:out value="${a.descripcion}"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty auditorias}">
                    <tr>
                        <td colspan="5" class="text-center text-muted">No se encontraron registros de auditoría para los filtros seleccionados.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>