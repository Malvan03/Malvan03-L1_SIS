<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Previene el cacheo de la página en el navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Si ya hay usuario en sesión, redirigir a su panel correspondiente
    if (session.getAttribute("usuario") != null) {
        pe.linea1.model.Usuario u = (pe.linea1.model.Usuario) session.getAttribute("usuario");
        if ("ADMINISTRADOR".equalsIgnoreCase(u.getRol())) {
            response.sendRedirect("home_admin.jsp");
        } else if ("CONDUCTOR".equalsIgnoreCase(u.getRol())) {
            response.sendRedirect("home_conductor.jsp");
        }
        return;
    }
%>
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

        <!-- Mensajes de error limpios, usando JSTL -->
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'datos'}">
                    <div class="error">Usuario o contraseña incorrectos.</div>
                </c:when>
                <c:when test="${param.error eq 'bloqueado'}">
                    <div class="error">Usuario bloqueado temporalmente por intentos fallidos. Intente nuevamente en 15 minutos.</div>
                </c:when>
                <c:when test="${param.error eq 'tipo'}">
                    <div class="error">Tipo de usuario no permitido.</div>
                </c:when>
                <c:when test="${param.error eq 'inactivo'}">
                    <div class="error">Usuario inactivo o no habilitado.</div>
                </c:when>
                <c:otherwise>
                    <div class="error">${param.error}</div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
    <script>
        function togglePassword() {
            var passInput = document.getElementById("password");
            passInput.type = passInput.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>
