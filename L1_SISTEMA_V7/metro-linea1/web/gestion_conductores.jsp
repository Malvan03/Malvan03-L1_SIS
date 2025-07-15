<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    pe.linea1.model.Usuario usuario = (pe.linea1.model.Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nombre = usuario.getNombres();
    if (usuario.getApellidoPaterno() != null && !usuario.getApellidoPaterno().isEmpty()) nombre += " " + usuario.getApellidoPaterno();
    if (usuario.getApellidoMaterno() != null && !usuario.getApellidoMaterno().isEmpty()) nombre += " " + usuario.getApellidoMaterno();
    String foto = (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty()) ? usuario.getFotoPerfil() : "default_avatar.png";
    String fechaHoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
%>
<%@include file="templates/header_admin.jspf" %>
<!-- ... resto del código igual ... -->

<div class="container py-4">
    <div class="d-flex align-items-center justify-content-between flex-wrap bg-white rounded shadow-sm p-3 mb-4">
        <img src="images/LOGOL1.png" alt="Logo Línea 1" class="logo" onclick="window.location.href='home_admin.jsp'" style="cursor:pointer;">
        <div class="text-center flex-grow-1">
            <div class="fw-bold" style="color:#2376d9;">Modo Administrador</div>
            <div>Bienvenido <b><%= nombre %></b></div>
            <div class="text-secondary" style="font-size:0.98em;"><%= fechaHoy %></div>
            <div style="font-size:1.2em; font-weight:bold; margin-top:10px;">UNNA TRANSPORTE</div>
        </div>
        <div class="d-flex align-items-center gap-3">
            <img src="images/<%= foto %>" alt="Foto de perfil" class="rounded-circle border border-2 border-primary" width="54" height="54" style="object-fit:cover;">
            <button class="btn btn-outline-primary btn-sm" onclick="window.location.href='editar_perfil.jsp'" title="Editar perfil">
                <i class="bi bi-gear"></i>
            </button>
            <button class="btn btn-danger btn-sm" onclick="window.location.href='logout.jsp'">Salir</button>
        </div>
    </div>

    <div class="mb-3">
        <button class="btn btn-outline-secondary" onclick="window.location.href='home_admin.jsp'"><i class="bi bi-arrow-left"></i> Regresar</button>
    </div>

    <h2 class="mb-3 text-center text-primary">Gestión de Conductores</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty mensaje}">
        <div class="alert alert-success">${mensaje}</div>
    </c:if>

    <div class="row mb-3 justify-content-center align-items-end g-2">
        <div class="col-md-3">
            <select id="buscadorCampo" class="form-select">
                <option value="dni">DNI</option>
                <option value="fechaIngreso">Fecha Ingreso</option>
                <option value="modalidad">Modalidad</option>
                <option value="estado">Estado</option>
            </select>
        </div>
        <div class="col-md-4" id="buscadorValorContainer">
            <input type="text" class="form-control" id="buscadorValor" placeholder="Ingrese valor de búsqueda">
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" onclick="buscarConductores()">Buscar</button>
        </div>
        <div class="col-md-3">
            <a href="agregar_conductor.jsp" class="btn btn-success w-100">Agregar Conductor</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle table-custom">
            <thead>
                <tr class="table-primary text-center">
                    <th>DNI</th>
                    <th>NOMBRES Y APELLIDOS</th>
                    <th>MODALIDAD</th>
                    <th>TURNO ACTUAL</th>
                    <th>BASE</th>
                    <th>HABILITADO</th>
                    <th>FECHA DE INGRESO</th>
                    <th>ANTIGÜEDAD</th>
                    <th>ESTADO DEL PERSONAL</th>
                    <th>OBSERVACIONES</th>
                    <th>ACCIONES</th>
                    <th>REQUERIMIENTOS</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${listaConductores}">
                <tr>
                    <td>${c.usuario.dni}</td>
                    <td>${c.usuario.nombres} ${c.usuario.apellidoPaterno} ${c.usuario.apellidoMaterno}</td>
                    <td>${c.modalidad}</td>
                    <td>
                        <c:choose>
                            <c:when test="${c.modalidad eq 'FULL-TIME'}">Siempre disponible</c:when>
                            <c:otherwise>${c.turnoActual}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${c.base}</td>
                    <td>
                        <c:choose>
                            <c:when test="${c.habilitado}">Sí</c:when>
                            <c:otherwise>No</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty c.fechaIngreso}">
                            <fmt:formatDate value="${c.fechaIngreso}" pattern="dd/MM/yyyy"/>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${not empty c.fechaIngreso}">
                            <fmt:formatDate value="${c.fechaIngreso}" pattern="yyyy-MM-dd" var="fechaIngresoFmt"/>
                            <%
                            try {
                                String fechaIngresoStr = (String) pageContext.getAttribute("fechaIngresoFmt");
                                java.time.LocalDate ingreso = java.time.LocalDate.parse(fechaIngresoStr);
                                java.time.Period antiguedad = java.time.Period.between(ingreso, java.time.LocalDate.now());
                                out.print(antiguedad.getYears() + " años, " + antiguedad.getMonths() + " meses, " + antiguedad.getDays() + " días");
                            } catch (Exception e) {
                                out.print("-");
                            }
                            %>
                        </c:if>
                    </td>
                    <td>${c.estadoPersonal}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty c.observaciones}">
                                <button type="button" class="btn btn-outline-info btn-sm" data-bs-toggle="modal" data-bs-target="#obsModal${c.idConductor}">Ver</button>
                                <div class="modal fade" id="obsModal${c.idConductor}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Observaciones</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>${c.observaciones}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-center">
                        <a href="EditarConductorServlet?id=${c.idConductor}" class="action-link" title="Editar"><i class="bi bi-pencil-square"></i></a>
                        <a href="EliminarConductorServlet?id=${c.idConductor}" class="action-link text-danger" title="Eliminar"
                           onclick="return confirm('¿Está seguro de eliminar al conductor?')"><i class="bi bi-trash"></i></a>
                    </td>
                    <td class="text-center">
                        <a href="#" class="action-link" onclick="verRequerimientos(${c.idConductor})"><i class="bi bi-search"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listaConductores}">
                <tr>
                    <td colspan="12" class="text-center">No se encontraron conductores.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <div class="mt-3 mb-2 text-center">
        <button id="btnEditar" class="btn btn-warning">Editar</button>
        <button id="btnGuardar" class="btn btn-primary" style="display:none;">Guardar</button>
    </div>
</div>
<%@include file="templates/footer.jspf" %>
<script src="js/gestion_conductores.js"></script>
<script>
document.getElementById('buscadorCampo').addEventListener('change', function() {
    const campo = this.value;
    let html = "";
    if (campo === 'modalidad') {
        html = '<select class="form-select" id="buscadorValor"><option value="FIJO">FIJO</option><option value="ROTATIVO">ROTATIVO</option></select>';
    } else if (campo === 'estado') {
        html = '<select class="form-select" id="buscadorValor"><option value="ACTIVO">ACTIVO</option><option value="SUSPENDIDO">SUSPENDIDO</option><option value="CESADO">CESADO</option></select>';
    } else if (campo === 'fechaIngreso') {
        html = '<input type="date" class="form-control" id="buscadorValor">';
    } else {
        html = '<input type="text" class="form-control" id="buscadorValor" placeholder="Ingrese ' + campo + '">';
    }
    document.getElementById('buscadorValorContainer').innerHTML = html;
});
function buscarConductores() {
    const campo = document.getElementById('buscadorCampo').value;
    const valor = document.getElementById('buscadorValor').value;
    if (valor) {
        let url = "GestionConductoresServlet?" + encodeURIComponent(campo) + "=" + encodeURIComponent(valor);
        window.location.href = url;
    }
}
function verRequerimientos(id) {
    alert('Funcionalidad de requerimientos para el conductor ' + id);
}
</script>
</body>
</html>