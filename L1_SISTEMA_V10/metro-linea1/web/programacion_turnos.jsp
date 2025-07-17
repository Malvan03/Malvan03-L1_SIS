<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Programación de Turnos</h2>
        <a href="home_admin.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Regresar</a>
    </div>

    <form class="row g-3 mb-4" method="get" action="ProgramacionTurnosServlet">
        <div class="col-md-4">
            <label class="form-label">Semana</label>
            <select name="idSemana" class="form-select">
                <option value="">Todas</option>
                <c:forEach var="s" items="${semanas}">
                    <option value="${s.idSemana}" <c:if test="${param.idSemana == s.idSemana}">selected</c:if>>
                        Semana ${s.numeroSemana}
                        (<fmt:formatDate value="${s.fechaInicio}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${s.fechaFin}" pattern="dd/MM/yyyy"/>)
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <label class="form-label">Conductor</label>
            <select name="idConductor" class="form-select">
                <option value="">Todos</option>
                <c:forEach var="c" items="${conductores}">
                    <option value="${c.idConductor}" <c:if test="${param.idConductor == c.idConductor}">selected</c:if>>
                        <c:out value="${c.nombres}"/> <c:out value="${c.apellidoPaterno}"/> <c:out value="${c.apellidoMaterno}"/>
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Buscar</button>
        </div>
    </form>

    <div class="d-flex justify-content-end mb-3">
        <a href="AgregarTurnoServlet" class="btn btn-success"><i class="bi bi-plus-circle"></i> Nuevo Turno</a>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-primary text-center">
                <tr>
                    <th>Semana</th>
                    <th>Conductor</th>
                    <th>Día</th>
                    <th>Fecha</th>
                    <th>Hora Inicio</th>
                    <th>Hora Fin</th>
                    <th>Carreras</th>
                    <th>Turno Nombre</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="t" items="${listaTurnos}">
                    <tr>
                        <td><c:out value="${t.semanaLabel}"/></td>
                        <td><c:out value="${t.nombreConductor}"/></td>
                        <td><c:out value="${t.diaSemana}"/></td>
                        <td><fmt:formatDate value="${t.fecha}" pattern="dd/MM/yyyy"/></td>
                        <td><c:out value="${t.horaInicio}"/></td>
                        <td><c:out value="${t.horaFin}"/></td>
                        <td><c:out value="${t.carreras}"/></td>
                        <td><c:out value="${t.nombreTurno}"/></td>
                        <td>
                            <a href="EditarTurnoServlet?id=${t.idTurno}" class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil"></i> Editar
                            </a>
                            <a href="EliminarTurnoServlet?id=${t.idTurno}" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro de eliminar este turno?')">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaTurnos}">
                    <tr>
                        <td colspan="9" class="text-center text-muted">No se encontraron turnos para los filtros seleccionados.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>