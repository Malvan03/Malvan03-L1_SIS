<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_conductor.jspf" %>
<link rel="stylesheet" href="css/solicitudes_cambio_conductor.css">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Mis Solicitudes de Cambio</h2>
        <a href="home_conductor.jsp" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Regresar
        </a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="table-success text-center">
                <tr>
                    <th>ID</th>
                    <th>Fecha Solicitud</th>
                    <th>Fecha Cambio</th>
                    <th>Turno Original</th>
                    <th>Turno Nuevo</th>
                    <th>Compañero</th>
                    <th>Estado Compañero</th>
                    <th>Estado Admin</th>
                    <th>Mensaje</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${solicitudes}">
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
                        <td>
                            <c:choose>
                                <c:when test="${not empty s.fechaCambio}">
                                    <fmt:formatDate value="${s.fechaCambio}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty s.turnoOriginalDesc}">
                                    ${s.turnoOriginalDesc}
                                </c:when>
                                <c:otherwise>${s.idTurnoOriginal}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty s.turnoNuevoDesc}">
                                    ${s.turnoNuevoDesc}
                                </c:when>
                                <c:otherwise>${s.idTurnoNuevo}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty s.nombreCompanero}">
                                    ${s.nombreCompanero}
                                </c:when>
                                <c:otherwise>${s.idConductorDestino}</c:otherwise>
                            </c:choose>
                        </td>
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
                    </tr>
                </c:forEach>
                <c:if test="${empty solicitudes}">
                    <tr>
                        <td colspan="9" class="text-center">No tienes solicitudes de cambio.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
