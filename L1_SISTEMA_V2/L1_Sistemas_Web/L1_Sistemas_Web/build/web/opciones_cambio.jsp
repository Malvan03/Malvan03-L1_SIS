<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="MODELO.Asignacion" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    Integer idConductor = (Integer) session.getAttribute("id_conductor");
    LocalDate fechaActual = LocalDate.now();

    if (usuario == null || !"CONDUCTOR".equals(rol) || idConductor == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idTurnoStr = request.getParameter("turno_actual");
    String horaInicio = request.getParameter("hora_inicio");
    String horaFin = request.getParameter("hora_fin");

    int idTurnoActual = idTurnoStr != null ? Integer.parseInt(idTurnoStr) : 0;

    DAO.AsignacionDAO dao = new DAO.AsignacionDAO();
    List<Asignacion> disponibles = dao.listarAsignaciones();
    Asignacion turnoSeleccionado = null;

    for (Asignacion a : disponibles) {
        if (a.getIdTurno() == idTurnoActual) {
            turnoSeleccionado = a;
            break;
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Opciones de Cambio</title>
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

        .mensaje {
            width: 100%;
            padding: 5px;
        }

        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #dff0d8;
        }

        .solicitar-btn {
            margin-top: 20px;
            display: block;
            padding: 10px 20px;
            background-color: #2ecc71;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .solicitar-btn:hover {
            background-color: #27ae60;
        }

        h2, h3 {
            color: #2e7d32;
            text-align: center;
        }

        .btn-volver {
            margin-top: 20px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
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

    <!-- Título -->
    <h2>TURNOS DISPONIBLES</h2>

    <form action="SolicitarCambioController" method="post">
        <input type="hidden" name="id_asignacion_original" value="<%= idTurnoActual %>">

        <!-- Turnos disponibles -->
        <table>
            <tr>
                <th>NOMBRES</th>
                <th>DÍA</th>
                <th>TURNO</th>
                <th>HORA DE INICIO</th>
                <th>HORA DE SALIDA</th>
                <th>DISPONIBLE</th>
            </tr>
            <% for (Asignacion a : disponibles) {
                   if (a.getIdTurno() != idTurnoActual) {
            %>
            <tr>
                <td>CONDUCTOR <%= a.getIdConductor() %></td>
                <td><%= a.getDiaSemana() %></td>
                <td><%= a.getIdTurno() %></td>
                <td>07:00</td>
                <td>11:00</td>
                <td><input type="radio" name="id_asignacion_solicitada" value="<%= a.getIdTurno() %>" required></td>
            </tr>
            <% } } %>
        </table>

        <!-- Turno seleccionado -->
        <h2>TURNO SELECCIONADO</h2>
        <table>
            <tr>
                <th>NOMBRES</th>
                <th>DÍA</th>
                <th>TURNO</th>
                <th>HORA DE INICIO</th>
                <th>HORA DE SALIDA</th>
                <th>DISPONIBLE</th>
                <th>MENSAJE</th>
            </tr>
            <% if (turnoSeleccionado != null) { %>
            <tr>
                <td><%= usuario %></td>
                <td><%= turnoSeleccionado.getDiaSemana() %></td>
                <td><%= turnoSeleccionado.getIdTurno() %></td>
                <td>07:00</td>
                <td>11:00</td>
                <td>✔</td>
                <td><input name="observacion" placeholder="Mensaje opcional..." class="form-control"></td>
            </tr>
            <% } %>
        </table>

        <!-- Botón solicitar -->
        <button type="submit" class="solicitar-btn">SOLICITAR ➤</button>
    </form>
</div>

</body>
</html>
