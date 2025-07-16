package pe.linea1.dao;

import pe.linea1.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ReportesDAO {
    // Cabecera según el tipo de reporte
    public List<String> obtenerCabecera(String tipoReporte) {
        switch (tipoReporte) {
            case "turnos":
                return Arrays.asList("DNI", "Nombres", "Fecha", "Día", "Turno", "Hora Inicio", "Hora Fin", "Carreras");
            case "cambios":
                return Arrays.asList("ID", "Fecha Solicitud", "Solicitante", "Fecha de Cambio", "Turno Original", "Hora Inicio", "Hora Fin", "Turno Nuevo", "Hora Inicio Nuevo", "Hora Fin Nuevo", "Estado");
            case "especiales":
                return Arrays.asList("DNI", "Nombres", "Fecha", "Detalle", "Observaciones");
            case "estadisticas":
                return Arrays.asList("Tipo", "Cantidad");
            case "auditoria":
                return Arrays.asList("Usuario", "Acción", "Fecha/Hora", "Descripción");
            default:
                return Collections.emptyList();
        }
    }

    // Ejemplo simple: implementa consultas reales según tus tablas
    public List<List<String>> generarReporte(String tipo, String fechaInicio, String fechaFin, String idConductor) throws Exception {
        List<List<String>> data = new ArrayList<>();
        // Aquí deberás implementar la lógica de consulta real según "tipo"
        // Por ejemplo:
        if ("turnos".equals(tipo)) {
            String sql = "SELECT u.dni, u.nombres, t.fecha, t.dia_semana, t.nombre_turno, t.hora_inicio, t.hora_fin, t.carreras " +
                    "FROM TURNO t INNER JOIN CONDUCTOR c ON t.id_conductor = c.id_conductor " +
                    "INNER JOIN USUARIO u ON c.id_usuario = u.id_usuario " +
                    "WHERE (? IS NULL OR t.fecha >= ?) AND (? IS NULL OR t.fecha <= ?) AND (? IS NULL OR c.id_conductor = ?) " +
                    "ORDER BY t.fecha DESC";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, fechaInicio);
                ps.setString(2, fechaInicio);
                ps.setString(3, fechaFin);
                ps.setString(4, fechaFin);
                ps.setString(5, idConductor);
                ps.setString(6, idConductor);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        List<String> row = new ArrayList<>();
                        row.add(rs.getString("dni"));
                        row.add(rs.getString("nombres"));
                        row.add(rs.getString("fecha"));
                        row.add(rs.getString("dia_semana"));
                        row.add(rs.getString("nombre_turno"));
                        row.add(rs.getString("hora_inicio"));
                        row.add(rs.getString("hora_fin"));
                        row.add(rs.getString("carreras"));
                        data.add(row);
                    }
                }
            }
        }
        // Agrega más casos para "cambios", "especiales", etc.
        return data;
    }
}