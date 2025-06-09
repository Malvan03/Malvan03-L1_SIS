<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="MODELO.Asignacion" %>
<%@ page import="java.time.LocalDate" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    Integer idConductor = (Integer) session.getAttribute("id_conductor");
    LocalDate fechaActual = LocalDate.now();

    if (usuario == null || !"CONDUCTOR".equals(rol) || idConductor == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    DAO.AsignacionDAO dao = new DAO.AsignacionDAO();
    List<Asignacion> misTurnos = dao.getTurnosPorConductor(idConductor);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Cambio</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Exo 2', sans-serif;
            background-color: #f4f6f9;
        }

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
            gap: 0.2rem;
        }

        .modo {
            font-weight: bold;
            color: #2e7d32;
        }

        .logo {
            height: 50px;
            margin-left: 1rem;
        }

        .fecha {
            font-size: 1rem;
            margin-right: 1rem;
        }

        .icono-btn {
            background: none;
            border: none;
            cursor: pointer;
            color: #333;
        }

        .btn-volver {
            margin: 2rem 0 1rem 0;
        }

        .seccion {
            background-color: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2, h3 {
            color: #2e7d32;
        }

        .form-select, .form-control {
            margin-bottom: 20px;
        }

        .btn-ver-opciones {
            width: 100%;
            font-weight: bold;
        }

        .bottom-right {
            position: fixed;
            bottom: 15px;
            right: 15px;
            font-size: 22px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<!-- Barra superior -->
<div class="top-bar">
    <h4>GESTIONAR CAMBIO</h4>
</div>

<!-- Cabecera -->
<div class="header">
    <div class="left-section">
        <div><strong>UNNA TRANSPORTE</strong></div>
        <div class="modo">MODO CONDUCTOR</div>
        <span>WELCOME <%= usuario.toUpperCase() %></span>
    </div>
    <div class="right-section d-flex align-items-center">
        <div class="fecha"><%= fechaActual %></div>
        <button class="icono-btn me-3" onclick="alert('Notificaciones clickeadas!')">
            <span class="material-icons">notifications</span>
        </button>
        <img src="assets/images/LOGOL1.png" alt="Logo Línea 1" class="logo">
        <form action="CerrarSesionController" method="post">
            <button type="submit" class="icono-btn">
                <span class="material-icons">logout</span>
            </button>
        </form>
    </div>
</div>

<!-- Contenido principal -->
<div class="container">
    <!-- Botón Volver -->
    <a href="home_conductor.jsp" class="btn btn-secondary btn-volver">
        ← Volver al Panel Principal
    </a>

    <h2 class="text-center">Gestionar Cambio</h2>

    <div class="seccion">
        <form method="get" action="opciones_cambio.jsp">
            <h3>TURNO QUE DESEO CAMBIAR</h3>
            <select name="turno_actual" class="form-select" required>
                <option value="">-- Selecciona tu turno --</option>
                <% for (Asignacion a : misTurnos) { %>
                    <option value="<%= a.getIdTurno() %>">
                        <%= a.getDiaSemana() %> - ID <%= a.getIdTurno() %> - <%= a.getFecha() %>
                    </option>
                <% } %>
            </select>

            <h3>RANGO DE HORARIO QUE NECESITO</h3>
            <div class="row">
                <div class="col-md-5">
                    <input type="time" name="hora_inicio" class="form-control" required>
                </div>
                <div class="col-md-2 text-center align-self-center">
                    <strong>A</strong>
                </div>
                <div class="col-md-5">
                    <input type="time" name="hora_fin" class="form-control" required>
                </div>
            </div>

            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-success btn-ver-opciones">🔍 Ver Opciones</button>
            </div>
        </form>
    </div>
</div>

<!-- Ícono de ayuda -->
<div class="bottom-right" title="Ayuda">❓</div>

</body>
</html>
