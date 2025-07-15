<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%
    pe.linea1.model.Usuario usuario = (pe.linea1.model.Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String rol = usuario.getRol();
    String nombre = usuario.getNombres();
    if (usuario.getApellidoPaterno() != null && !usuario.getApellidoPaterno().isEmpty()) nombre += " " + usuario.getApellidoPaterno();
    if (usuario.getApellidoMaterno() != null && !usuario.getApellidoMaterno().isEmpty()) nombre += " " + usuario.getApellidoMaterno();
    String foto = (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty()) ? usuario.getFotoPerfil() : "default_avatar.png";
    String correo = usuario.getCorreo();
    String telefono = usuario.getTelefono() == null ? "" : usuario.getTelefono();
    String emergencia = usuario.getContactoEmergencia() == null ? "" : usuario.getContactoEmergencia();
    String nacimiento = usuario.getFechaNacimiento() == null ? "" : new java.text.SimpleDateFormat("yyyy-MM-dd").format(usuario.getFechaNacimiento());
%>
<%
    if ("ADMINISTRADOR".equalsIgnoreCase(rol)) {
%>
    <%@include file="templates/header_admin.jspf"%>
<%
    } else {
%>
    <%@include file="templates/header_conductor.jspf"%>
<%
    }
%>
<div class="perfil-container">
    <div class="text-center mb-3">
        <img src="images/<%= foto %>" class="perfil-foto mb-2" id="fotoPerfilVista" alt="Foto de perfil" style="width:120px;height:120px;border-radius:50%;object-fit:cover;border:2px solid #227c23;">
        <form action="PerfilServlet" method="post" enctype="multipart/form-data" class="mb-3">
            <input type="file" name="nuevaFoto" id="nuevaFoto" accept="image/*" style="display:none;" onchange="mostrarPrevisualizacion(this)">
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="document.getElementById('nuevaFoto').click()">
                <i class="bi bi-image"></i> Cambiar foto
            </button>
            <button type="submit" class="btn btn-success btn-sm" name="accion" value="actualizarFoto">
                <i class="bi bi-upload"></i> Guardar Foto
            </button>
        </form>
        <h4><%= nombre %></h4>
        <span class="badge bg-info text-dark"><%= rol %></span>
    </div>
    <form action="PerfilServlet" method="post" autocomplete="off">
        <div class="mb-3">
            <label class="form-label">Correo electrónico:</label>
            <input type="email" name="correo" class="form-control" value="<%= correo %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono:</label>
            <input type="text" name="telefono" class="form-control" value="<%= telefono %>" maxlength="15">
        </div>
        <div class="mb-3">
            <label class="form-label">Contacto de emergencia:</label>
            <input type="text" name="emergencia" class="form-control" value="<%= emergencia %>" maxlength="100">
        </div>
        <div class="mb-3">
            <label class="form-label">Fecha de nacimiento:</label>
            <input type="date" name="nacimiento" class="form-control" value="<%= nacimiento %>">
        </div>
        <button type="submit" name="accion" value="actualizarPerfil" class="btn btn-primary w-100">Guardar cambios</button>
    </form>
    <hr>
    <form action="PerfilServlet" method="post" autocomplete="off">
        <h6 class="mt-3 mb-2"><i class="bi bi-key"></i> Cambiar contraseña</h6>
        <div class="mb-2">
            <input type="password" name="actual" class="form-control mb-2" placeholder="Contraseña actual" required>
            <input type="password" name="nueva" class="form-control mb-2" placeholder="Nueva contraseña" required id="nuevaPass" oninput="nivelPassword()">
            <input type="password" name="repetir" class="form-control mb-2" placeholder="Repetir nueva contraseña" required>
            <div id="nivel" style="font-size:0.92em;" class="text-secondary mb-1"></div>
        </div>
        <button type="submit" name="accion" value="cambiarContrasena" class="btn btn-warning w-100">Actualizar contraseña</button>
    </form>
</div>
<%@include file="templates/footer.jspf"%>
<script src="js/editar_perfil.js"></script>
<script>
function mostrarPrevisualizacion(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('fotoPerfilVista').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function nivelPassword() {
    var pass = document.getElementById('nuevaPass').value;
    var nivel = "Débil";
    var color = "red";
    if (pass.length >= 8 && /[A-Z]/.test(pass) && /[0-9]/.test(pass) && /[\W_]/.test(pass)) {
        nivel = "Alto";
        color = "green";
    } else if (pass.length >= 6 && /[A-Z]/.test(pass) && /[0-9]/.test(pass)) {
        nivel = "Medio";
        color = "orange";
    }
    document.getElementById('nivel').innerText = "Nivel de seguridad: " + nivel;
    document.getElementById('nivel').style.color = color;
}
</script>
</body>
</html>