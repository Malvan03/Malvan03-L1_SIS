<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="MODELO.Solicitud" %>
<%@ page import="java.time.LocalDate" %>
<%
    // Validación de sesión y rol de administrador
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    LocalDate fechaActual = LocalDate.now();

    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtener lista de solicitudes desde el request
    List<Solicitud> solicitudes = (List<Solicitud>) request.getAttribute("solicitudes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Solicitudes de Cambio</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts & Bootstrap -->
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        /* Mejora general de fuente y fondo */
        body {
            font-family: 'Exo 2', sans-serif;
            background-color: #e7d8b6;
        }

        /* Barra superior como en home_admin.jsp */
        .top-bar {
            background-color: #215c1f;
            color: white;
            padding: 1rem;
            text-align: center;
            font-weight: bold;
        }

        /* Cabecera replicada del home_admin.jsp */
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
            color: #d32f2f;
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

        /* Botón para volver al home_admin.jsp */
        .btn-volver {
            margin-bottom: 2rem;
        }

        /* Tabla estilizada con hover */
        .table th, .table td {
            vertical-align: middle;
        }

        /* Caja blanca estilizada para formularios y tablas */
        .card-form {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

    <!-- Barra superior del sistema -->
    <div class="top-bar">
        <h4>SOLICITUDES DE CAMBIO DE TURNO</h4>
    </div>

    <!-- Cabecera con usuario y fecha (copiada de home_admin.jsp) -->
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
            <img src="assets/images/LOGOL1.png" class="logo" alt="Logo Línea 1">
            <form action="CerrarSesionController" method="post">
                <button type="submit" class="icono-btn">
                    <span class="material-icons">logout</span>
                </button>
            </form>
        </div>
    </div>

    <!-- Contenido principal -->
    <div class="container mt-4">

        <!-- ✅ Botón para volver al panel principal -->
        <a href="home_admin.jsp" class="btn btn-secondary btn-volver">
            ← Volver al Panel Principal
        </a>

        <!-- ✅ Formulario de filtros con diseño mejorado -->
        <div class="card-form mb-4">
            <h4>Buscar Solicitudes</h4>
            <form action="SolicitudesAdminController" method="GET">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" name="id" id="id" class="form-control" placeholder="Buscar por ID" />
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="fs" class="form-label">Fecha de Solicitud</label>
                        <input type="date" name="fs" id="fs" class="form-control" />
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="fd" class="form-label">Fecha de Turno</label>
                        <input type="date" name="fd" id="fd" class="form-control" />
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Buscar</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- ✅ Tabla mejorada visualmente -->
        <div class="card-form">
            <h4 class="mb-3">Solicitudes de Cambio de Turnos</h4>
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Fecha de Solicitud</th>
                            <th>Fecha de Turno</th>
                            <th>Conductor Solicitante</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- ✅ Corrección: se usaba fechaTurno dos veces antes -->
                        <c:forEach var="solicitud" items="${solicitudes}">
                            <tr>
                                <td>${solicitud.id}</td>
                                <td>${solicitud.fechaSolicitud}</td>
                                <td>${solicitud.fechaTurno}</td>
                                <td>${solicitud.idSolicitante}</td>
                                <td>${solicitud.estadoAdmin}</td>
                                <td>
                                    <form action="SolicitudesAdminController" method="post" class="d-flex gap-1">
                                        <input type="hidden" name="id_solicitud" value="${solicitud.id}" />
                                        <button type="submit" class="btn btn-success btn-sm" name="accion" value="SI">Aprobar</button>
                                        <button type="submit" class="btn btn-danger btn-sm" name="accion" value="NO">Rechazar</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
