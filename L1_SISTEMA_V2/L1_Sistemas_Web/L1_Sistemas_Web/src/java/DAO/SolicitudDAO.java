package DAO;

import MODELO.Solicitud;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SolicitudDAO {

    // Insertar una nueva solicitud de cambio de turno
    public void insertar(Solicitud s) {
        String sql = "INSERT INTO SolicitudesCambio (fecha_turno, id_conductor_solicitante, id_asignacion_original, id_asignacion_solicitada, estado_receptor, estado_admin, observacion, id_notificacion) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, s.getFechaTurno());
            ps.setInt(2, s.getIdSolicitante());
            ps.setInt(3, s.getIdAsignacionOriginal());
            ps.setInt(4, s.getIdAsignacionSolicitada());
            ps.setString(5, s.getEstadoReceptor());
            ps.setString(6, s.getEstadoAdmin());
            ps.setString(7, s.getObservacion());
            ps.setInt(8, s.getIdNotificacion()); // Ahora estamos usando el idNotificacion correctamente

            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("❌ Error al insertar solicitud: " + e.getMessage());
        }
    }

    // Obtener todas las solicitudes pendientes (estado_admin = 'PENDIENTE')
    public List<Solicitud> listarSolicitudesPendientes() {
        List<Solicitud> lista = new ArrayList<>();
        String sql = "SELECT * FROM SolicitudesCambio WHERE estado_admin = 'PENDIENTE'";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Solicitud s = new Solicitud();
                s.setIdSolicitud(rs.getInt("id_solicitud"));
                s.setFechaTurno(rs.getDate("fecha_turno"));
                s.setIdSolicitante(rs.getInt("id_conductor_solicitante"));
                s.setIdAsignacionOriginal(rs.getInt("id_asignacion_original"));
                s.setIdAsignacionSolicitada(rs.getInt("id_asignacion_solicitada"));
                s.setEstadoReceptor(rs.getString("estado_receptor"));
                s.setEstadoAdmin(rs.getString("estado_admin"));
                s.setObservacion(rs.getString("observacion"));
                lista.add(s);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al listar solicitudes: " + e.getMessage());
        }

        return lista;
    }

    // Actualizar el estado de una solicitud (aprobada/rechazada)
    public void actualizarEstadoSolicitud(int idSolicitud, String nuevoEstado) {
        String sql = "UPDATE SolicitudesCambio SET estado_admin = ? WHERE id_solicitud = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevoEstado);
            ps.setInt(2, idSolicitud);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("❌ Error al actualizar estado de solicitud: " + e.getMessage());
        }
    }

    // Obtener todas las solicitudes realizadas por un conductor
    public List<Solicitud> getPorConductor(int idConductor) {
        List<Solicitud> lista = new ArrayList<>();
        String sql = "SELECT * FROM SolicitudesCambio WHERE id_conductor_solicitante = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idConductor);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Solicitud s = new Solicitud();
                s.setIdSolicitud(rs.getInt("id_solicitud"));
                s.setFechaTurno(rs.getDate("fecha_turno"));
                s.setIdAsignacionOriginal(rs.getInt("id_asignacion_original"));
                s.setIdAsignacionSolicitada(rs.getInt("id_asignacion_solicitada"));
                s.setEstadoReceptor(rs.getString("estado_receptor"));
                s.setEstadoAdmin(rs.getString("estado_admin"));
                s.setObservacion(rs.getString("observacion"));
                lista.add(s);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al obtener solicitudes por conductor: " + e.getMessage());
        }

        return lista;
    }

    // Obtener una solicitud específica por su ID
    public Solicitud getSolicitudPorId(int idSolicitud) {
        Solicitud s = null;
        String sql = "SELECT * FROM SolicitudesCambio WHERE id_solicitud = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idSolicitud);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Solicitud();
                s.setIdSolicitud(rs.getInt("id_solicitud"));
                s.setFechaTurno(rs.getDate("fecha_turno"));
                s.setIdSolicitante(rs.getInt("id_conductor_solicitante"));
                s.setIdAsignacionOriginal(rs.getInt("id_asignacion_original"));
                s.setIdAsignacionSolicitada(rs.getInt("id_asignacion_solicitada"));
                s.setEstadoReceptor(rs.getString("estado_receptor"));
                s.setEstadoAdmin(rs.getString("estado_admin"));
                s.setObservacion(rs.getString("observacion"));
            }

        } catch (Exception e) {
            System.out.println("❌ Error al obtener solicitud por ID: " + e.getMessage());
        }

        return s;
    }
}
