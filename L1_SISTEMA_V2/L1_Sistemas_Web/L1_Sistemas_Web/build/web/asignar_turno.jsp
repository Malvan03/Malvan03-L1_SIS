<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Asignar Turno</title>
</head>
<body>
    <h2>Asignar Turno a Conductor</h2>
    <form action="AsignarTurnoController" method="post">
        ID del conductor: <input type="number" name="id_conductor" required><br><br>
        ID del turno: <input type="number" name="id_turno" required><br><br>
        Fecha: <input type="date" name="fecha" required><br><br>
        Día de la semana:
        <select name="dia_semana" required>
            <option value="Lun">Lunes</option>
            <option value="Mar">Martes</option>
            <option value="Mie">Miércoles</option>
            <option value="Jue">Jueves</option>
            <option value="Vie">Viernes</option>
            <option value="Sab">Sábado</option>
            <option value="Dom">Domingo</option>
        </select><br><br>
        Observaciones: <br>
        <textarea name="observaciones" rows="3" cols="40"></textarea><br><br>
        <input type="submit" value="Asignar Turno">
    </form>
</body>
</html>
