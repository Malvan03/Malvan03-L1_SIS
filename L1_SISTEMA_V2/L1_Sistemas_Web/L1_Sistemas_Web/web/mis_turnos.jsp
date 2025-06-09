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
    <title>Turnos Asignados</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Exo 2', sans-serif;
            background-color: #f4f4f4;
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
            margin-bottom: 2rem;
        }

        .container {
            padding: 2rem;
        }

        .btn-change {
            display: block;
            margin: 2rem auto;
            background-color: #a3d3a1;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
        }

        .btn-change:hover {
            background-color: #8bc48a;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 2;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
        }

        .modal-content {
            background: white;
            width: 60%;
            margin: 100px auto;
            padding: 20px;
            border-radius: 6px;
        }

        .close {
            float: right;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<!-- Barra superior -->
<div class="top-bar">
    <h4>TUS TURNOS ASIGNADOS</h4>
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

<!-- Contenido -->
<div class="container">

    <!-- Botón para volver -->
    <a href="home_conductor.jsp" class="btn btn-secondary btn-volver">
        ← Volver al Panel Principal
    </a>

    <div class="table-responsive">
        <table class="table table-bordered text-center align-middle">
            <thead class="table-success">
                <tr>
                    <th>NOMBRES</th>
                    <th>DÍA</th>
                    <th>TURNO</th>
                    <th>HORA DE INICIO</th>
                    <th>HORA DE SALIDA</th>
                    <th>CARRERAS</th>
                </tr>
            </thead>
            <tbody>
            <% for (Asignacion a : misTurnos) { %>
                <tr>
                    <td><%= usuario %></td>
                    <td><%= a.getDiaSemana() %></td>
                    <td><%= a.getIdTurno() %></td>
                    <td>07:00</td>
                    <td>11:00</td>
                    <td>
                        2 <button class="icono-btn" onclick="abrirModal(<%= a.getIdTurno() %>)">
                            <span class="material-icons">search</span>
                        </button>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <button class="btn-change" onclick="location.href='solicitar_cambio.jsp'">
        ¿Deseas realizar algún cambio?
    </button>
</div>

<!-- Modal dinámico -->
<div id="modalDetalle" class="modal">
    <div class="modal-content">
        <span class="close" onclick="cerrarModal()">✖</span>
        <h3>Detalle del Turno</h3>
        <p id="baseInicio"></p>
        <p id="baseFin"></p>
        <p id="tipoCarrera"></p>
        <p id="horaRefrigerio"></p>
        <p id="tiempoLaborado"></p>
    </div>
</div>

<script>
    function abrirModal(idTurno) {
        fetch("DetalleTurnoController?id_turno=" + idTurno)
            .then(res => res.json())
            .then(data => {
                document.getElementById("baseInicio").innerText = "Base Inicio: " + data.baseInicio;
                document.getElementById("baseFin").innerText = "Base Fin: " + data.baseFin;
                document.getElementById("tipoCarrera").innerText = "Tipo Carrera: " + data.tipoCarrera;
                document.getElementById("horaRefrigerio").innerText = "Hora Refrigerio: " + data.horaRefrigerio;
                document.getElementById("tiempoLaborado").innerText = "Tiempo Laborado: " + data.tiempoLaborado;
                document.getElementById("modalDetalle").style.display = "block";
            });
    }

    function cerrarModal() {
        document.getElementById("modalDetalle").style.display = "none";
    }
</script>

</body>
</html>
