package pe.linea1.dao;

import pe.linea1.model.Auditoria;
import pe.linea1.model.Usuario;
import pe.linea1.util.DBConnection;

import java.sql.*;
import java.util.*;

public class AuditoriaDAO {
    public List<Usuario> listarUsuariosParaFiltro() throws Exception {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, nombres, apellido_paterno, apellido_materno FROM USUARIO ORDER BY nombres";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                lista.add(u);
            }
        }
        return lista;
    }

    public List<String> listarTiposAccion() {
        // Puedes consultar a la base de datos si tienes una tabla, o definirlos fijo:
        return Arrays.asList("LOGIN", "LOGOUT", "CREAR", "ACTUALIZAR", "ELIMINAR", "CAMBIO TURNO", "REPORTE", "OTRO");
    }

    public List<Auditoria> buscarAuditoria(String idUsuario, String tipoAccion, String fechaInicio, String fechaFin) throws Exception {
        List<Auditoria> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT a.id_auditoria, a.id_usuario, u.nombres, u.apellido_paterno, u.apellido_materno, u.rol, " +
                        "a.tipo_accion, a.fecha_hora, a.descripcion " +
                "FROM AUDITORIA a INNER JOIN USUARIO u ON a.id_usuario = u.id_usuario WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();
        if (idUsuario != null && !idUsuario.isEmpty()) {
            sql.append(" AND a.id_usuario = ?");
            params.add(Integer.valueOf(idUsuario));
        }
        if (tipoAccion != null && !tipoAccion.isEmpty()) {
            sql.append(" AND a.tipo_accion = ?");
            params.add(tipoAccion);
        }
        if (fechaInicio != null && !fechaInicio.isEmpty()) {
            sql.append(" AND a.fecha_hora >= ?");
            params.add(fechaInicio + " 00:00:00");
        }
        if (fechaFin != null && !fechaFin.isEmpty()) {
            sql.append(" AND a.fecha_hora <= ?");
            params.add(fechaFin + " 23:59:59");
        }
        sql.append(" ORDER BY a.fecha_hora DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Auditoria a = new Auditoria();
                    a.setIdAuditoria(rs.getInt("id_auditoria"));
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidoPaterno(rs.getString("apellido_paterno"));
                    u.setApellidoMaterno(rs.getString("apellido_materno"));
                    u.setRol(rs.getString("rol"));
                    a.setUsuario(u);
                    a.setTipoAccion(rs.getString("tipo_accion"));
                    a.setFechaHora(rs.getTimestamp("fecha_hora"));
                    a.setDescripcion(rs.getString("descripcion"));
                    lista.add(a);
                }
            }
        }
        return lista;
    }
}