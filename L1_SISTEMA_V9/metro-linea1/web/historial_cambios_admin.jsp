<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/solicitudes_cambio_admin.css">

<div class="container py-4">
    <!-- Título y botón Regresar -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Solicitudes de Cambio de Turno</h2>
        <a href="home_admin.jsp" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Regresar
        </a>
    </div>

    <!-- Tabs para cambiar entre pendientes/historial -->
    <ul class="nav nav-tabs mb-4">
        <li class="nav-item">
            <a class="nav-link ${empty param.tab || param.tab == 'pendientes' ? 'active' : ''}" href="SolicitudCambioTurnoServlet?accion=pendientes&tab=pendientes">Pendientes</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${param.tab == 'historial' ? 'active' : ''}" href="SolicitudCambioTurnoServlet?accion=historial&tab=historial">Historial</a>
        </li>
    </ul>

    <!-- TAB: Pendientes -->
    <c:if test="${empty param.tab || param.tab == 'pendientes'}">
        <c:choose>
            <c:when test="${empty listaPendientes}">
                <div class="alert alert-info text-center" style="font-size:1.1em;">
                    No hay solicitudes pendientes.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-success text-center">
                            <tr>
                                <th>ID</th>
                                <th>Fecha Solicitud</th>
                                <th>Solicitante</th>
                                <th>Turno Original</th>
                                <th>Turno Nuevo</th>
                                <th>Compañero</th>
                                <th>Estado Compañero</th>
                                <th>Estado Admin</th>
                                <th>Mensaje</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${listaPendientes}">
                                <tr>
                                    <td>${s.idSolicitud}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty s.fechaSolicitud}">
                                                <fmt:formatDate value="${s.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${s.idConductorSolicitante}</td>
                                    <td>${s.idTurnoOriginal}</td>
                                    <td>${s.idTurnoNuevo}</td>
                                    <td>${s.idConductorDestino}</td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${s.estadoConfirmacionCompanero eq 'ACEPTADO'}">bg-success</c:when>
                                                <c:when test="${s.estadoConfirmacionCompanero eq 'RECHAZADO'}">bg-danger</c:when>
                                                <c:otherwise>bg-warning text-dark</c:otherwise>
                                            </c:choose>
                                        ">
                                            ${s.estadoConfirmacionCompanero}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${s.estadoConfirmacionAdmin eq 'ACEPTADO'}">bg-success</c:when>
                                                <c:when test="${s.estadoConfirmacionAdmin eq 'RECHAZADO'}">bg-danger</c:when>
                                                <c:otherwise>bg-warning text-dark</c:otherwise>
                                            </c:choose>
                                        ">
                                            ${s.estadoConfirmacionAdmin}
                                        </span>
                                    </td>
                                    <td>${s.mensaje}</td>
                                    <td>
                                        <a href="SolicitudCambioTurnoServlet?accion=ver&idSolicitud=${s.idSolicitud}" class="btn btn-info btn-sm">Ver</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <!-- TAB: Historial -->
    <c:if test="${param.tab == 'historial'}">
        <form method="get" action="SolicitudCambioTurnoServlet" class="row g-3 mb-4">
            <input type="hidden" name="accion" value="historial">
            <input type="hidden" name="tab" value="historial">
            <div class="col-md-3">
                <label class="form-label mb-0">Estado</label>
                <select name="estado" class="form-select">
                    <option value="">Todos</option>
                    <option value="ACEPTADO" ${param.estado == 'ACEPTADO' ? 'selected' : ''}>Aceptado</option>
                    <option value="RECHAZADO" ${param.estado == 'RECHAZADO' ? 'selected' : ''}>Rechazado</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label mb-0">Desde</label>
                <input type="date" name="desde" class="form-control" value="${param.desde}">
            </div>
            <div class="col-md-3">
                <label class="form-label mb-0">Hasta</label>
                <input type="date" name="hasta" class="form-control" value="${param.hasta}">
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Buscar</button>
            </div>
        </form>
        <c:choose>
            <c:when test="${empty listaHistorial}">
                <div class="alert alert-info text-center" style="font-size:1.1em;">
                    No se encontraron solicitudes en el historial.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>ID</th>
                                <th>Fecha Solicitud</th>
                                <th>Solicitante</th>
                                <th>Turno Original</th>
                                <th>Turno Nuevo</th>
                                <th>Compañero</th>
                                <th>Estado Compañero</th>
                                <th>Estado Admin</th>
                                <th>Mensaje</th>
                                <th>Observaciones</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${listaHistorial}">
                                <tr>
                                    <td>${s.idSolicitud}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty s.fechaSolicitud}">
                                                <fmt:formatDate value="${s.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${s.idConductorSolicitante}</td>
                                    <td>${s.idTurnoOriginal}</td>
                                    <td>${s.idTurnoNuevo}</td>
                                    <td>${s.idConductorDestino}</td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${s.estadoConfirmacionCompanero eq 'ACEPTADO'}">bg-success</c:when>
                                                <c:when test="${s.estadoConfirmacionCompanero eq 'RECHAZADO'}">bg-danger</c:when>
                                                <c:otherwise>bg-warning text-dark</c:otherwise>
                                            </c:choose>
                                        ">
                                            ${s.estadoConfirmacionCompanero}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${s.estadoConfirmacionAdmin eq 'ACEPTADO'}">bg-success</c:when>
                                                <c:when test="${s.estadoConfirmacionAdmin eq 'RECHAZADO'}">bg-danger</c:when>
                                                <c:otherwise>bg-warning text-dark</c:otherwise>
                                            </c:choose>
                                        ">
                                            ${s.estadoConfirmacionAdmin}
                                        </span>
                                    </td>
                                    <td>${s.mensaje}</td>
                                    <td>${s.observaciones}</td>
                                    <td>
                                        <a href="SolicitudCambioTurnoServlet?accion=ver&idSolicitud=${s.idSolicitud}" class="btn btn-info btn-sm">Ver</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>
<%@ include file="templates/footer.jspf" %>
