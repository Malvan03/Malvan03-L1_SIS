<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="MODELO.Solicitud" %>
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

    DAO.SolicitudDAO dao = new DAO.SolicitudDAO();
    List<Solicitud> solicitudes = dao.getPorConductor(idConductor);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historial de Cambios de Turno</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        }

        .modo {
            font-weight: bold;
            color: #2e7d32;
        }

        .logo {
            height: 50px;
        }

        .btn-volver {
            margin: 20px 0;
        }

        .table-container {
            background-color: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .glosario {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 15px;
            font-size: 14px;
            border-radius: 10px;
        }

        .material-icons {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div class="top-bar">
    <h4>HISTORIAL DE CAMBIOS DE TURNO</h4>
</div>

<div class="header">
    <div class="left-section">
        <div><strong>UNNA TRANSPORTE</strong></div>
        <div class="modo">MODO CONDUCTOR</div>
        <span>WELCOME <%= usuario.toUpperCase() %></span>
    </div>
    <div class="right-section d-flex align-items-center gap-3">
        <div><%= fechaActual %></div>
        <img src="assets/images/LOGOL1.png" alt="Logo Línea 1" class="logo">
        <form action="CerrarSesionController" method="post" style="margin: 0;">
            <button type="submit" class="btn btn-outline-danger btn-sm">Cerrar Sesión</button>
        </form>
    </div>
</div>

<div class="container mt-4">
    <a href="home_conductor.jsp" class="btn btn-secondary btn-volver">← Volver al Panel Principal</a>

    <div class="table-container">
        <div class="mb-3 d-flex justify-content-between align-items-center">
            <div>
                <label class="form-label">Filtrar por:</label>
                <select id="filtro" class="form-select form-select-sm d-inline w-auto" onchange="filtrarTabla()">
                    <option value="id">ID</option>
                    <option value="fs">FS</option>
                    <option value="fd">FD</option>
                </select>
                <input type="text" id="busqueda" class="form-control form-control-sm d-inline w-auto ms-2" onkeyup="filtrarTabla()" placeholder="Buscar...">
            </div>
            <button class="btn btn-outline-success btn-sm" onclick="toggleGlosario()">📘 Glosario</button>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-sm text-center align-middle" id="tabla">
                <thead class="table-light">
                    <tr>
                        <th>ID</th><th>FS</th><th>FD</th><th>DÍA</th><th>CONDUCTOR</th>
                        <th>TO</th><th>HI O</th><th>HS O</th><th>C</th>
                        <th>CON QUIÉN CAMBIA</th><th>TN</th><th>HI N</th><th>HS N</th><th>C N</th>
                        <th>AC</th><th>CD</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Solicitud s : solicitudes) { %>
                        <tr>
                            <td><%= s.getIdSolicitud() %></td>
                            <td><%= s.getFechaTurno() %></td>
                            <td><%= s.getFechaTurno() %></td>
                            <td>--</td>
                            <td><%= usuario %></td>
                            <td><%= s.getIdAsignacionOriginal() %></td>
                            <td>--</td>
                            <td>--</td>
                            <td>2</td>
                            <td>--</td>
                            <td><%= s.getIdAsignacionSolicitada() %></td>
                            <td>--</td>
                            <td>--</td>
                            <td>2</td>
                            <td><%= s.getEstadoReceptor() %></td>
                            <td><%= s.getEstadoAdmin() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="glosario mt-4" id="glosario" style="display:none;">
            <h5>📘 GLOSARIO</h5>
            <ul>
                <li><b>FS</b>: Fecha de solicitud</li>
                <li><b>FD</b>: Fecha del turno</li>
                <li><b>TO</b>: Turno Original</li>
                <li><b>HI O</b>: Hora de Inicio del Turno Original</li>
                <li><b>HS O</b>: Hora de Salida del Turno Original</li>
                <li><b>C</b>: Carreras del turno original</li>
                <li><b>TN</b>: Turno Nuevo</li>
                <li><b>HI N</b>: Hora de Inicio del Turno Nuevo</li>
                <li><b>HS N</b>: Hora de Salida del Turno Nuevo</li>
                <li><b>C N</b>: Carreras del turno nuevo</li>
                <li><b>AC</b>: Aceptado por conductor</li>
                <li><b>CD</b>: Confirmado por administrador</li>
            </ul>
        </div>
    </div>
</div>

<script>
    function toggleGlosario() {
        const g = document.getElementById("glosario");
        g.style.display = g.style.display === "block" ? "none" : "block";
    }

    function filtrarTabla() {
        let columna = document.getElementById("filtro").value;
        let valor = document.getElementById("busqueda").value.toLowerCase();
        let tabla = document.getElementById("tabla");
        let tr = tabla.getElementsByTagName("tr");

        let index = {
            "id": 0,
            "fs": 1,
            "fd": 2
        }[columna];

        for (let i = 1; i < tr.length; i++) {
            let td = tr[i].getElementsByTagName("td")[index];
            if (td) {
                tr[i].style.display = td.innerText.toLowerCase().includes(valor) ? "" : "none";
            }
        }
    }
</script>

</body>
</html>
