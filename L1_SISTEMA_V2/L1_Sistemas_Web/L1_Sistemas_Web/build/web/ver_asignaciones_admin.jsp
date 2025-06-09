<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="MODELO.Asignacion" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }

    DAO.AsignacionDAO dao = new DAO.AsignacionDAO();
    List<Asignacion> asignaciones = dao.listarAsignaciones();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Asignaciones Registradas</title>
    <style>
        body {
            font-family: Arial;
            padding: 20px;
        }
        table {
            border-collapse: collapse;
            width: 90%;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <h2>Asignaciones Realizadas</h2>
    <table>
        <tr>
            <th>ID Conductor</th>
            <th>ID Turno</th>
            <th>Fecha</th>
            <th>Día</th>
            <th>Observaciones</th>
        </tr>
        <%
            for (Asignacion a : asignaciones) {
        %>
        <tr>
            <td><%= a.getIdConductor() %></td>
            <td><%= a.getIdTurno() %></td>
            <td><%= a.getFecha() %></td>
            <td><%= a.getDiaSemana() %></td>
            <td><%= a.getObservaciones() %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
