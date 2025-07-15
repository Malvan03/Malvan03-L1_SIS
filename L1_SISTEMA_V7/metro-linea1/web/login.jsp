<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Metro Línea 1</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
    <div class="form-container">
        <!-- Logo Metro Línea 1 -->
        <div style="width: 100%; text-align: center;">
            <img src="images/LOGOL1.png" alt="Logo Metro Línea 1" style="height: 120px; max-width: 80%; object-fit: contain; margin-bottom: 18px;">
        </div>
        <h2>Login Metro Línea 1</h2>
        <form action="LoginServlet" method="post" autocomplete="off">
            <label for="usuario">DNI:</label>
            <input type="text" id="usuario" name="usuario" maxlength="8" required pattern="\d{8}" title="Ingrese 8 dígitos" autofocus />

            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required />

            <!-- Mostrar/Ocultar contraseña -->
            <div style="margin-bottom: 14px; margin-top: -7px;">
                <input type="checkbox" id="showPass" onclick="togglePassword()" style="vertical-align: middle;">
                <label for="showPass" style="font-size: 0.98em; vertical-align: middle; cursor:pointer;">Mostrar contraseña</label>
            </div>

            <input type="submit" value="Ingresar" />

            <div style="margin-top:8px; text-align: right;">
                <a href="recuperar_contrasena.jsp" style="font-size:0.98em;">¿Olvidaste tu contraseña?</a>
            </div>
        </form>
        <%
            String error = request.getParameter("error");
            if ("datos".equals(error)) {
        %>
            <div class="error">Usuario o contraseña incorrectos.</div>
        <% } else if ("bloqueado".equals(error)) { %>
            <div class="error">Usuario bloqueado temporalmente por intentos fallidos. Intente nuevamente en 15 minutos.</div>
        <% } else if ("tipo".equals(error)) { %>
            <div class="error">Tipo de usuario no permitido.</div>
        <% } else if ("inactivo".equals(error)) { %>
            <div class="error">Usuario inactivo o no habilitado.</div>
        <% } %>
    </div>
    <script>
        function togglePassword() {
            var passInput = document.getElementById("password");
            passInput.type = passInput.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>
