<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="templates/header_admin.jspf" %>
<link rel="stylesheet" href="css/gestion_conductores.css">

<div class="container mt-4">
    <h2 class="mb-4 text-primary text-center">Editar Conductor</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form method="post" action="EditarConductorServlet" autocomplete="off">
        <input type="hidden" name="idConductor" value="${conductor.idConductor}">
        <input type="hidden" name="idUsuario" value="${conductor.idUsuario}">
        <div class="mb-3">
            <label>DNI:</label>
            <input type="text" value="${conductor.dni}" readonly class="form-control">
        </div>
        <div class="mb-3">
            <label>Nombres*:</label>
            <input type="text" name="nombres" value="${conductor.nombres}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Apellido paterno*:</label>
            <input type="text" name="apellidoPaterno" value="${conductor.apellidoPaterno}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Apellido materno*:</label>
            <input type="text" name="apellidoMaterno" value="${conductor.apellidoMaterno}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Correo*:</label>
            <input type="email" name="correo" value="${conductor.correo}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Teléfono:</label>
            <input type="text" name="telefono" value="${conductor.telefono}" class="form-control">
        </div>
        <div class="mb-3">
            <label>Contacto emergencia:</label>
            <input type="text" name="contactoEmergencia" value="${conductor.contactoEmergencia}" class="form-control">
        </div>
        <div class="mb-3">
            <label>Fecha nacimiento:</label>
            <input type="date" name="fechaNacimiento" value="${conductor.fechaNacimiento}" class="form-control">
        </div>
        <div class="mb-3">
            <label>Modalidad*:</label>
            <select name="modalidad" required class="form-select">
                <option value="FIJO" ${conductor.modalidad == 'FIJO' ? 'selected' : ''}>FIJO</option>
                <option value="ROTATIVO" ${conductor.modalidad == 'ROTATIVO' ? 'selected' : ''}>ROTATIVO</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Base*:</label>
            <input type="text" name="base" value="${conductor.base}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Fecha ingreso*:</label>
            <input type="date" name="fechaIngreso" value="${conductor.fechaIngreso}" required class="form-control">
        </div>
        <div class="mb-3">
            <label>Observaciones:</label>
            <input type="text" name="observaciones" value="${conductor.observaciones}" class="form-control">
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" name="habilitado" id="chkHabilitado" class="form-check-input" ${conductor.habilitado ? 'checked' : ''}>
            <label class="form-check-label" for="chkHabilitado">Habilitado</label>
        </div>
        <div class="mb-3">
            <label>Estado Personal:</label>
            <select name="estadoPersonal" class="form-select">
                <option value="ACTIVO" ${conductor.estadoPersonal == 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                <option value="SUSPENDIDO" ${conductor.estadoPersonal == 'SUSPENDIDO' ? 'selected' : ''}>SUSPENDIDO</option>
                <option value="CESADO" ${conductor.estadoPersonal == 'CESADO' ? 'selected' : ''}>CESADO</option>
            </select>
        </div>
        <div class="d-flex justify-content-center gap-2">
            <button type="submit" class="btn btn-success px-4">Guardar</button>
            <a href="GestionConductoresServlet" class="btn btn-secondary px-4">Cancelar</a>
        </div>
    </form>
</div>
<%@include file="templates/footer.jspf" %>
