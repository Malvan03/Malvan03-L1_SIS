package pe.linea1.dao;

import pe.linea1.model.Notificacion;
import pe.linea1.util.DBConnection;

import java.sql.*;
import java.util.*;

public class NotificacionDAO {

    // Crear una notificación
    public void crearNotificacion(int idUsuario, String remitente, String mensaje, String tipo, Integer idReferencia) {
        String sql = "INSERT INTO NOTIFICACION (id_usuario, remitente, mensaje, tipo_notificacion, id_referencia) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, remitente != null ? remitente : "Sistema");
            ps.setString(3, mensaje);
            ps.setString(4, tipo != null ? tipo : "GENERAL");
            if (idReferencia != null) {
                ps.setInt(5, idReferencia);
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Listar todas las notificaciones de un usuario
    public List<Notificacion> listarPorUsuario(int idUsuario) {
        List<Notificacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM NOTIFICACION WHERE id_usuario = ? ORDER BY fecha DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Listar solo NO LEÍDAS por usuario
    public List<Notificacion> listarNoLeidas(int idUsuario) {
        List<Notificacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM NOTIFICACION WHERE id_usuario = ? AND leido = 0 ORDER BY fecha DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Listar las últimas N notificaciones recientes (para la campana)
    public List<Notificacion> listarUltimasPorUsuario(int idUsuario, int limite) {
        List<Notificacion> lista = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NOTIFICACION WHERE id_usuario = ? ORDER BY fecha DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limite);
            ps.setInt(2, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Marcar como leída una notificación
    public void marcarComoLeida(int idNotificacion) {
        String sql = "UPDATE NOTIFICACION SET leido = 1 WHERE id_notificacion = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idNotificacion);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Contar no leídas
    public int contarNoLeidas(int idUsuario) {
        String sql = "SELECT COUNT(*) FROM NOTIFICACION WHERE id_usuario = ? AND leido = 0";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Mapeo ResultSet → Notificacion
    private Notificacion mapear(ResultSet rs) throws SQLException {
        Notificacion n = new Notificacion();
        n.setIdNotificacion(rs.getInt("id_notificacion"));
        n.setIdUsuario(rs.getInt("id_usuario"));
        n.setRemitente(rs.getString("remitente"));
        n.setMensaje(rs.getString("mensaje"));
        n.setFecha(rs.getTimestamp("fecha"));
        n.setLeido(rs.getBoolean("leido"));
        n.setTipoNotificacion(rs.getString("tipo_notificacion"));
        int idRef = rs.getInt("id_referencia");
        n.setIdReferencia(rs.wasNull() ? null : idRef);
        return n;
    }
}
