<%@ page language="java" contentType="text/html; charset=UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="templates/header_conductor.jspf" %>
<%
    String fechaHoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Home Conductor | Metro Línea 1</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/home_conductor.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="container-home">
    <div class="header d-flex justify-content-between align-items-center p-3 mb-4 shadow-sm bg-white rounded">
        <img src="images/LOGOL1.png" alt="Logo Línea 1" class="logo" style="height:60px;cursor:pointer;" onclick="window.location.href='home_conductor.jsp'">

        <div class="welcome text-center flex-grow-1">
            <div class="modo-conductor fw-bold" style="color:#43b049;">Modo Conductor</div>
            <div>Bienvenido <b>${sessionScope.nombre}</b></div>
            <div class="fecha text-secondary" style="font-size:0.98em;">
                <%= fechaHoy %>
            </div>
        </div>

        <div class="user-panel d-flex align-items-center gap-3">
            <img src="images/${sessionScope.foto}" alt="Foto de perfil" class="user-foto rounded-circle" width="50" height="50">
            <button class="btn btn-outline-success btn-sm" onclick="window.location.href='editar_perfil.jsp'" title="Editar perfil">
                <span class="bi bi-gear"></span> Perfil
            </button>
            <button class="btn btn-danger btn-sm" onclick="window.location.href='logout.jsp'">Salir</button>
        </div>

        <div class="notificaciones position-relative ms-3">
            <button id="btnNoti" onclick="toggleNotificaciones()" class="btn btn-light position-relative" title="Ver notificaciones">
                <span class="bi bi-bell"></span>
                <c:if test="${notiCount > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${notiCount}
                    </span>
                </c:if>
            </button>
            <div id="notiDropdown" class="noti-dropdown card shadow" style="display:none; position:absolute; right:0; z-index:10; min-width:230px;">
                <c:choose>
                    <c:when test="${notificaciones != null && notificaciones.size() > 0}">
                        <c:forEach var="noti" items="${notificaciones}" varStatus="idx">
                            <div class="noti-item p-2 <c:if test='${!noti.leido}'>fw-bold bg-warning-subtle</c:if>">
                                <span><fmt:formatDate value="${noti.fecha}" pattern="dd/MM HH:mm"/></span>
                                <br>
                                <span>${noti.mensaje}</span>
                            </div>
                            <c:if test="${idx.count == 4}"><hr><a href="notificaciones.jsp" class="ms-2">Ver más...</a></c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="noti-item p-2">No hay notificaciones.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="main-admin-menu d-flex flex-wrap gap-3 justify-content-center mb-5">
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='ver_mis_turnos.jsp'"><i class="bi bi-calendar2-check"></i> Ver mis turnos</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='gestionar_cambio.jsp'"><i class="bi bi-arrow-repeat"></i> Gestionar Cambio</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='historial_cambios_conductor.jsp'"><i class="bi bi-clock-history"></i> Historial de Cambios</button>
        <button class="btn btn-outline-success btn-lg" onclick="window.location.href='solicitudes_cambio_conductor.jsp'"><i class="bi bi-arrow-left-right"></i> Solicitudes de Cambio</button>
    </div>

    <div class="ayuda-conductor text-center mb-3">
        <a href="mailto:soporte@linea1.com" class="btn btn-link"><i class="bi bi-info-circle"></i> ¿Necesitas ayuda? Escríbenos</a>
    </div>
</div>
<%@include file="templates/footer.jspf"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleNotificaciones() {
    var drop = document.getElementById('notiDropdown');
    drop.style.display = (drop.style.display === "none" || drop.style.display === "") ? "block" : "none";
}
document.addEventListener('click', function(event) {
    var btn = document.getElementById('btnNoti');
    var drop = document.getElementById('notiDropdown');
    if (drop && btn && !btn.contains(event.target) && !drop.contains(event.target)) {
        drop.style.display = "none";
    }
});
</script>
</body>
</html>
