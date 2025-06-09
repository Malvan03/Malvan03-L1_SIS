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
    <title>Registrar Turno</title>
</head>
<body>
    <h2>Registrar Nuevo Turno</h2>
    <form action="RegistrarTurnoController" method="post">
        Código Turno: <input type="text" name="codigo_turno" required><br><br>
        Tipo Turno:
        <select name="tipo_turno">
            <option value="NORMAL">NORMAL</option>
            <option value="ESPECIAL">ESPECIAL</option>
            <option value="A_LA_ORDEN">A_LA_ORDEN</option>
            <option value="MANIOBRISTA">MANIOBRISTA</option>
            <option value="CAPACITACION">CAPACITACION</option>
        </select><br><br>
        Hora Inicio: <input type="time" name="hora_inicio" required><br><br>
        Hora Fin: <input type="time" name="hora_fin" required><br><br>
        Base Inicio: <input type="text" name="base_inicio" required><br><br>
        Base Fin: <input type="text" name="base_fin" required><br><br>
        Carrera Asignada: <input type="text" name="carrera_asignada"><br><br>
        Tipo Carrera:
        <select name="tipo_carrera">
            <option value="PAR">PAR</option>
            <option value="IMPAR">IMPAR</option>
        </select><br><br>
        Refrigerio:
        <select name="tiene_refrigerio">
            <option value="1">Sí</option>
            <option value="0">No</option>
        </select><br><br>
        Hora Refrigerio: <input type="time" name="hora_refrigerio"><br><br>
        Tiempo Laborado: <input type="time" name="tiempo_laborado"><br><br>
        <input type="submit" value="Registrar Turno">
    </form>
</body>
</html>
