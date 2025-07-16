<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/solicitudes_cambio_admin.css">

<div class="container py-4">
    <h2 class="mb-4 text-primary text-center">Detalle de Solicitud de Cambio</h2>
    <table class="table table-bordered">
        <tr><th>ID Solicitud:</th><td>${solicitud.idSolicitud}</td></tr>
        <tr><th>Fecha Solicitud:</th><td>${solicitud.fechaSolicitud}</td></tr>
        <tr><th>Fecha Cambio:</th><td>${solicitud.fechaCambio}</td></tr>
        <tr><th>Solicitante:</th><td>${solicitud.idConductorSolicitante}</td></tr>
        <tr><th>Turno Original:</th><td>${solicitud.idTurnoOriginal}</td></tr>
        <tr><th>Conductor Destino:</th><td>${solicitud.idConductorDestino}</td></tr>
        <tr><th>Turno Nuevo:</th><td>${solicitud.idTurnoNuevo}</td></tr>
        <tr><th>Estado Compañero:</th><td>${solicitud.estadoConfirmacionCompanero}</td></tr>
        <tr><th>Estado Admin:</th><td>${solicitud.estadoConfirmacionAdmin}</td></tr>
        <tr><th>Motivo:</th><td>${solicitud.mensaje}</td></tr>
        <tr><th>Observaciones:</th><td>${solicitud.observaciones}</td></tr>
        <tr><th>Validación Horas Sueño:</th><td>
            <c:choose>
                <c:when test="${solicitud.validacionHorasSueno}">Sí</c:when>
                <c:otherwise>No</c:otherwise>
            </c:choose>
        </td></tr>
        <tr><th>Validación Coincidencia:</th><td>
            <c:choose>
                <c:when test="${solicitud.validacionCoincidencia}">Sí</c:when>
                <c:otherwise>No</c:otherwise>
            </c:choose>
        </td></tr>
        <tr><th>Validación Saldo Tiempo:</th><td>
            <c:choose>
                <c:when test="${solicitud.validacionSaldoTiempo}">Sí</c:when>
                <c:otherwise>No</c:otherwise>
            </c:choose>
        </td></tr>
    </table>

    <c:if test="${sessionScope.rol eq 'ADMINISTRADOR' && solicitud.estadoConfirmacionCompanero eq 'ACEPTADO' && solicitud.estadoConfirmacionAdmin eq 'PENDIENTE'}">
        <form action="SolicitudCambioTurnoServlet" method="get">
            <input type="hidden" name="accion" value="aprobarAdmin">
            <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}">
            <div class="mb-2">
                <label>Observaciones:</label>
                <textarea name="observaciones" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-success">Aceptar Solicitud</button>
        </form>
        <form action="SolicitudCambioTurnoServlet" method="get" class="mt-2">
            <input type="hidden" name="accion" value="rechazarAdmin">
            <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}">
            <div class="mb-2">
                <label>Motivo de rechazo:</label>
                <textarea name="observaciones" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-danger">Rechazar Solicitud</button>
        </form>
    </c:if>

    <c:if test="${sessionScope.id_conductor eq solicitud.idConductorDestino && solicitud.estadoConfirmacionCompanero eq 'PENDIENTE'}">
        <a href="SolicitudCambioTurnoServlet?accion=aprobarCompanero&idSolicitud=${solicitud.idSolicitud}" class="btn btn-success">Aceptar Cambio</a>
        <a href="SolicitudCambioTurnoServlet?accion=rechazarCompanero&idSolicitud=${solicitud.idSolicitud}" class="btn btn-danger">Rechazar Cambio</a>
    </c:if>

    <a href="SolicitudCambioTurnoServlet?accion=pendientes" class="btn btn-outline-secondary mt-3">
        <i class="bi bi-arrow-left"></i> Regresar
    </a>
</div>
<%@ include file="templates/footer.jspf" %>
