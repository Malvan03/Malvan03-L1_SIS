<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/solicitudes_cambio_admin.css">

<div class="container py-4">
    <h2 class="mb-4 text-center text-primary">Solicitudes de Cambio de Turno</h2>
    <!-- Pestañas -->
    <ul class="nav nav-tabs mb-3" id="solicitudesTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="pendientes-tab" data-bs-toggle="tab" data-bs-target="#pendientes" type="button" role="tab" aria-controls="pendientes" aria-selected="true">
                Pendientes
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="historial-tab" data-bs-toggle="tab" data-bs-target="#historial" type="button" role="tab" aria-controls="historial" aria-selected="false">
                Historial
            </button>
        </li>
    </ul>
    <div class="tab-content" id="solicitudesTabContent">
        <!-- Pendientes -->
        <div class="tab-pane fade show active" id="pendientes" role="tabpanel" aria-labelledby="pendientes-tab">
            <c:if test="${empty listaPendientes}">
                <div class="alert alert-info text-center">No hay solicitudes pendientes.</div>
            </c:if>
            <c:if test="${not empty listaPendientes}">
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-warning text-center">
                            <tr>
                                <th>ID</th>
                                <th>Fecha Solicitud</th>
                                <th>Solicitante</th>
                                <th>Turno Original</th>
                                <th>Turno Nuevo</th>
                                <th>Estado Compañero</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${listaPendientes}">
                            <tr>
                                <td>${s.idSolicitud}</td>
                                <td>
                                    <fmt:formatDate value="${s.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>${s.nombreSolicitante}</td>
                                <td>${s.turnoOriginalDesc}</td>
                                <td>${s.turnoNuevoDesc}</td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${s.estadoConfirmacionCompanero eq 'ACEPTADO'}">bg-success</c:when>
                                            <c:when test="${s.estadoConfirmacionCompanero eq 'RECHAZADO'}">bg-danger</c:when>
                                            <c:otherwise>bg-warning text-dark</c:otherwise>
                                        </c:choose>
                                    ">${s.estadoConfirmacionCompanero}</span>
                                </td>
                                <td class="text-center">
                                    <a href="SolicitudCambioTurnoServlet?accion=ver&idSolicitud=${s.idSolicitud}" class="btn btn-info btn-sm">Ver Detalle</a>
                                    <a href="SolicitudCambioTurnoServlet?accion=aprobarAdmin&idSolicitud=${s.idSolicitud}" class="btn btn-success btn-sm ms-1">Aprobar</a>
                                    <a href="SolicitudCambioTurnoServlet?accion=rechazarAdmin&idSolicitud=${s.idSolicitud}" class="btn btn-danger btn-sm ms-1">Rechazar</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
        <!-- Historial -->
        <div class="tab-pane fade" id="historial" role="tabpanel" aria-labelledby="historial-tab">
            <form class="row g-2 mb-3" method="get" action="SolicitudCambioTurnoServlet">
                <input type="hidden" name="accion" value="historial"/>
                <div class="col-md-3">
                    <select name="estado" class="form-select">
                        <option value="">Todos los estados</option>
                        <option value="ACEPTADO">Aceptadas</option>
                        <option value="RECHAZADO">Rechazadas</option>
                        <option value="PENDIENTE">Pendientes</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="date" name="desde" class="form-control" placeholder="Desde"/>
                </div>
                <div class="col-md-3">
                    <input type="date" name="hasta" class="form-control" placeholder="Hasta"/>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-outline-primary w-100" type="submit">Filtrar</button>
                </div>
            </form>
            <c:if test="${empty listaHistorial}">
                <div class="alert alert-info text-center">No hay historial de solicitudes.</div>
            </c:if>
            <c:if test="${not empty listaHistorial}">
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-secondary text-center">
                            <tr>
                                <th>ID</th>
                                <th>Fecha Solicitud</th>
                                <th>Solicitante</th>
                                <th>Turno Original</th>
                                <th>Turno Nuevo</th>
                                <th>Estado Compañero</th>
                                <th>Estado Admin</th>
                                <th>Mensaje</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${listaHistorial}">
                            <tr>
                                <td>${s.idSolicitud}</td>
                                <td><fmt:formatDate value="${s.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${s.nombreSolicitante}</td>
                                <td>${s.turnoOriginalDesc}</td>
                                <td>${s.turnoNuevoDesc}</td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${s.estadoConfirmacionCompanero eq 'ACEPTADO'}">bg-success</c:when>
                                            <c:when test="${s.estadoConfirmacionCompanero eq 'RECHAZADO'}">bg-danger</c:when>
                                            <c:otherwise>bg-warning text-dark</c:otherwise>
                                        </c:choose>
                                    ">${s.estadoConfirmacionCompanero}</span>
                                </td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${s.estadoConfirmacionAdmin eq 'ACEPTADO'}">bg-success</c:when>
                                            <c:when test="${s.estadoConfirmacionAdmin eq 'RECHAZADO'}">bg-danger</c:when>
                                            <c:otherwise>bg-warning text-dark</c:otherwise>
                                        </c:choose>
                                    ">${s.estadoConfirmacionAdmin}</span>
                                </td>
                                <td>${s.mensaje}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
