<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_admin.jspf" %> <!-- O header_conductor.jspf según rol -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Notificaciones</h2>
        <a href="${sessionScope.usuario.rol == 'ADMINISTRADOR' ? 'home_admin.jsp' : 'home_conductor.jsp'}"
           class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Regresar
        </a>
    </div>

    <div class="mb-3">
        <span class="badge bg-primary fs-6">
            No leídas: ${noLeidas}
        </span>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-primary">
                <tr>
                    <th>#</th>
                    <th>Fecha</th>
                    <th>Remitente</th>
                    <th>Mensaje</th>
                    <th>Tipo</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="n" items="${notificaciones}" varStatus="idx">
                    <tr class="${n.leido ? '' : 'fw-bold bg-warning-subtle'}">
                        <td>${idx.count}</td>
                        <td>
                            <fmt:formatDate value="${n.fecha}" pattern="dd/MM/yyyy HH:mm" />
                        </td>
                        <td>${n.remitente}</td>
                        <td>${n.mensaje}</td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${n.tipoNotificacion == 'SOLICITUD_CAMBIO'}">bg-info</c:when>
                                    <c:when test="${n.tipoNotificacion == 'APROBACION'}">bg-success</c:when>
                                    <c:when test="${n.tipoNotificacion == 'RECHAZO'}">bg-danger</c:when>
                                    <c:otherwise>bg-secondary</c:otherwise>
                                </c:choose>
                            ">
                                ${n.tipoNotificacion}
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${!n.leido}">
                                    <a href="NotificacionServlet?accion=leer&id=${n.idNotificacion}" 
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye"></i> Marcar como leída
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-success"><i class="bi bi-check-circle"></i> Leída</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty notificaciones}">
                    <tr>
                        <td colspan="6" class="text-center text-muted">
                            <i class="bi bi-bell-slash"></i> No tienes notificaciones.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="templates/footer.jspf" %>
