<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate"%>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }

    LocalDate fechaActual = LocalDate.now();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modo Administrador</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Exo 2', sans-serif;
            background-color: #e7d8b6;
        }
             /* titulo cambio de turno linea uno */
        .top-bar {
            background-color: #215c1f;
            color: white;
            padding: 1rem;
            text-align: center;
            font-weight: bold;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            
        }

        .left-section {
            display: flex;
            flex-direction: column;
            gap: 0.3rem;
        }

        .modo {
            font-weight: bold;
            color: #d32f2f;
        }

        .fecha {
            font-size: 1rem;
            margin-right: 1rem;
        }

        .logo {
            height: 50px;
            margin: 0 1rem;
        }

        .icono-btn {
            background: none;
            border: none;
            cursor: pointer;
            color: #333;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            padding: 2rem;
        }

        .card-option {
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background-color: #ffffff;
            overflow: hidden;
        }

        .card-option:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .card-option img {
            width: 100%;
            height: 140px;
            object-fit: cover;
        }

        .card-option h5 {
            margin-top: 1rem;
            font-weight: 600;
        }

        .card-option a {
            display: block;
            padding: 1rem;
            color: inherit;
            text-decoration: none;
        }

        .ayuda {
            position: fixed;
            bottom: 20px;
            right: 20px;
            font-size: 2rem;
            cursor: pointer;
            background-color: #1a237e;
            color: white;
            border-radius: 50%;
            padding: 0.5rem 0.75rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

    <div class="top-bar">
        <h4>CAMBIOS DE TURNOS LÍNEA UNO</h4>
    </div>

    <div class="header">
        <div class="left-section">
            <div><strong>UNNA TRANSPORTE</strong></div>
            <div class="modo">MODO ADMINISTRADOR</div>
            <span>WELCOME <%= usuario.toUpperCase() %></span>
        </div>
        <div class="right-section d-flex align-items-center">
            <div class="fecha"><%= fechaActual %></div>
            <button class="icono-btn" onclick="alert('Notificaciones clickeadas!')">
                <span class="material-icons">notifications</span>
            </button>
            <img src="assets/images/LOGOL1.png" class="logo" alt="Linea1">
            <form action="CerrarSesionController" method="post">
                <button type="submit" class="icono-btn">
                    <span class="material-icons">logout</span>
                </button>
            </form>
        </div>
    </div>

    <!-- Tarjetas visuales -->
    <div class="grid">

        <div class="card-option">
            <a href="ver_solicitudes.jsp">
                <img src="assets/images/solicitudes.jpg" alt="Solicitudes de Cambio">
                <h5>Solicitudes de Cambio</h5>
            </a>
        </div>

        <div class="card-option">
            <a href="#">
                <img src="assets/images/conductores.jpg" alt="Gestión de Conductores">
                <h5>Gestión de Conductores</h5>
            </a>
        </div>

        <div class="card-option">
            <a href="TurnoController">
                <img src="assets/images/turnos.jpg" alt="Programación de Turnos">
                <h5>Programación de Turnos</h5>
            </a>
        </div>

        <div class="card-option">
            <a href="#">
                <img src="assets/images/reportes.jpg" alt="Reportes Externos">
                <h5>Reportes Externos</h5>
            </a>
        </div>

        <div class="card-option">
            <a href="#">
                <img src="assets/images/auditoria.jpg" alt="Auditoría de Actividad">
                <h5>Auditoría de Actividad</h5>
            </a>
        </div>

    </div>

    <div class="ayuda" title="Ayuda">❔</div>

</body>
</html>
