<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_conductor.jspf" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Historial de Cambios de Turno</h2>
        <a href="home_conductor.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Regresar</a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="table-success text-center">
                <tr>
                    <th>#</th>
                    <th>Fecha Solicitud</th>
                    <th>Fecha Cambio</th>
                    <th>Turno Original</th>
                    <th>Turno Nuevo</th>
                    <th>Compañero</th>
                    <th>Estado Compañero</th>
                    <th>Estado Admin</th>
                    <th>Mensaje</th>
                    <th>Observaciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="h" items="${historial}" varStatus="loop">
                    <tr>
                        <td>${loop.count}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty h.fechaSolicitud}">
                                    <fmt:formatDate value="${h.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty h.fechaCambio}">
                                    <fmt:formatDate value="${h.fechaCambio}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${h.turnoOriginalDesc != null ? h.turnoOriginalDesc : h.idTurnoOriginal}</td>
                        <td>${h.turnoNuevoDesc != null ? h.turnoNuevoDesc : h.idTurnoNuevo}</td>
                        <td>${h.nombreCompanero != null ? h.nombreCompanero : h.idConductorDestino}</td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${h.estadoConfirmacionCompanero eq 'ACEPTADO'}">bg-success</c:when>
                                    <c:when test="${h.estadoConfirmacionCompanero eq 'RECHAZADO'}">bg-danger</c:when>
                                    <c:otherwise>bg-warning text-dark</c:otherwise>
                                </c:choose>
                            ">
                                ${h.estadoConfirmacionCompanero}
                            </span>
                        </td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${h.estadoConfirmacionAdmin eq 'ACEPTADO'}">bg-success</c:when>
                                    <c:when test="${h.estadoConfirmacionAdmin eq 'RECHAZADO'}">bg-danger</c:when>
                                    <c:otherwise>bg-warning text-dark</c:otherwise>
                                </c:choose>
                            ">
                                ${h.estadoConfirmacionAdmin}
                            </span>
                        </td>
                        <td>${h.mensaje}</td>
                        <td>${h.observaciones}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty historial}">
                    <tr>
                        <td colspan="10" class="text-center text-muted">
                            <i class="bi bi-clock-history"></i> No hay cambios de turno en tu historial.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
