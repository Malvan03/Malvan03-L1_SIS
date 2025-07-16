package pe.linea1.dao;

import pe.linea1.model.Notificacion;
import pe.linea1.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificacionDAO {
    public List<Notificacion> getNotificacionesNoLeidas(int usuarioId) {
        List<Notificacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM NOTIFICACION WHERE usuario_id = ? AND leido = 0 ORDER BY fecha DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notificacion n = new Notificacion();
                n.setId(rs.getInt("id_notificacion"));
                n.setUsuarioId(rs.getInt("usuario_id"));
                n.setMensaje(rs.getString("mensaje"));
                n.setLeido(rs.getBoolean("leido"));
                n.setFecha(rs.getTimestamp("fecha"));
                lista.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}