<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/solicitudes_cambio_admin.css">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Solicitudes de Cambio de Turno Pendientes</h2>
        <a href="home_admin.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Regresar</a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="table-primary text-center">
                <tr>
                    <th>ID</th>
                    <th>Fecha Solicitud</th>
                    <th>Solicitante</th>
                    <th>Turno Original</th>
                    <th>Turno Nuevo</th>
                    <th>Estado Compañero</th>
                    <th>Estado Admin</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${listaSolicitudes}">
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
                        <td>${s.nombreSolicitante != null ? s.nombreSolicitante : s.idConductorSolicitante}</td>
                        <td>${s.turnoOriginalDesc != null ? s.turnoOriginalDesc : s.idTurnoOriginal}</td>
                        <td>${s.turnoNuevoDesc != null ? s.turnoNuevoDesc : s.idTurnoNuevo}</td>
                        <td class="text-center">
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
                        <td class="text-center">
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
                        <td>
                            <a href="SolicitudCambioTurnoServlet?accion=ver&idSolicitud=${s.idSolicitud}" class="btn btn-info btn-sm">Ver</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaSolicitudes}">
                    <tr>
                        <td colspan="8" class="text-center">No hay solicitudes pendientes.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
