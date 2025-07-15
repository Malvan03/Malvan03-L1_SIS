<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pe.linea1.model.Usuario usuario = (pe.linea1.model.Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nombre = usuario.getNombres();
    if (usuario.getApellidoPaterno() != null && !usuario.getApellidoPaterno().isEmpty())
        nombre += " " + usuario.getApellidoPaterno();
    if (usuario.getApellidoMaterno() != null && !usuario.getApellidoMaterno().isEmpty())
        nombre += " " + usuario.getApellidoMaterno();
    String foto = (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty()) ? usuario.getFotoPerfil() : "default_avatar.png";
%>
<%@include file="templates/header_admin.jspf" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container py-4">
    <div class="mb-3">
        <button class="btn btn-outline-secondary" onclick="window.location.href='gestion_conductores.jsp'">
            <i class="bi bi-arrow-left"></i> Regresar
        </button>
    </div>
    <div class="card shadow-sm">
        <div class="card-body">
            <h2 class="mb-4 text-center text-primary">Agregar Conductor</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form method="post" action="AgregarConductorServlet" autocomplete="off">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">DNI*:</label>
                        <input type="text" name="dni" maxlength="8" required class="form-control" pattern="[0-9]{8}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Nombres*:</label>
                        <input type="text" name="nombres" required class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Apellido paterno*:</label>
                        <input type="text" name="apellidoPaterno" required class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Apellido materno*:</label>
                        <input type="text" name="apellidoMaterno" required class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Correo*:</label>
                        <input type="email" name="correo" required class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Teléfono:</label>
                        <input type="text" name="telefono" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Contacto emergencia:</label>
                        <input type="text" name="contactoEmergencia" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Fecha nacimiento:</label>
                        <input type="date" name="fechaNacimiento" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Modalidad*:</label>
                        <select name="modalidad" required class="form-select">
                            <option value="">Seleccionar</option>
                            <option value="FIJO">FIJO</option>
                            <option value="ROTATIVO">ROTATIVO</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Base*:</label>
                        <input type="text" name="base" required class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Fecha ingreso*:</label>
                        <input type="date" name="fechaIngreso" required class="form-control">
                    </div>
                    <div class="col-md-8">
                        <label class="form-label">Observaciones:</label>
                        <input type="text" name="observaciones" class="form-control">
                    </div>
                </div>
                <div class="d-flex justify-content-center mt-4 gap-2">
                    <button type="submit" class="btn btn-success px-4">Agregar</button>
                    <a href="gestion_conductores.jsp" class="btn btn-secondary px-4">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="templates/footer.jspf" %>
