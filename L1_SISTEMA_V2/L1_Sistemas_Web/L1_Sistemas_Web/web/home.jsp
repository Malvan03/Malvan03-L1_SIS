<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="MODELO.Turno" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    LocalDate fechaActual = LocalDate.now();

    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String filtroCodigo = request.getParameter("codigo");
    List<Turno> turnos = (List<Turno>) request.getAttribute("turnos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Turnos Registrados</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap y Material Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Exo 2', sans-serif;
            background-color: #e7d8b6;
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
        }

        .modo {
            color: #d32f2f;
        }

        .logo {
            height: 50px;
        }

        .card-form {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .btn-volver {
            margin-bottom: 20px;
        }

        .material-icons {
            vertical-align: middle;
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
        <div class="d-flex align-items-center gap-3">
            <span><%= fechaActual %></span>
            <img src="assets/images/LOGOL1.png" alt="Logo" class="logo">
        </div>
    </div>

    <div class="container mt-4">
        <a href="home_admin.jsp" class="btn btn-secondary btn-volver">← Volver al Panel Principal</a>

        <div class="card-form mb-4">
            <h4>Filtrar por Código</h4>
            <form action="TurnoController" method="get">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <input type="text" name="codigo" class="form-control" placeholder="Ingrese código de turno" value="<%= (filtroCodigo != null) ? filtroCodigo : "" %>">
                    </div>
                    <div class="col-md-2 mb-3">
                        <button type="submit" class="btn btn-primary w-100">Buscar</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="card-form">
            <h4 class="mb-3">Turnos Registrados</h4>
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Código</th>
                            <th>Tipo</th>
                            <th>Hora Inicio</th>
                            <th>Hora Fin</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (turnos != null && !turnos.isEmpty()) {
                                for (Turno t : turnos) {
                        %>
                        <tr>
                            <td><%= t.getIdTurno() %></td>
                            <td><%= t.getCodigoTurno() %></td>
                            <td><%= t.getTipoTurno() %></td>
                            <td><%= t.getHoraInicio() %></td>
                            <td><%= t.getHoraFin() %></td>
                            <td>
                                <a href="TurnoController?accion=editar&id=<%= t.getIdTurno() %>" class="btn btn-sm btn-info me-2">
                                    <span class="material-icons">edit</span>
                                </a>
                                <a href="TurnoController?accion=eliminar&id=<%= t.getIdTurno() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Estás seguro de eliminar este turno?');">
                                    <span class="material-icons">delete</span>
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="6" class="text-center">No hay turnos disponibles</td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
