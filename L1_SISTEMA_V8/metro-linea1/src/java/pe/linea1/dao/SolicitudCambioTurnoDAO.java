package pe.linea1.dao;

import pe.linea1.model.SolicitudCambioTurno;
import pe.linea1.util.DBConnection;
import java.sql.*;
import java.util.*;

public class SolicitudCambioTurnoDAO {

    // Crear una nueva solicitud de cambio de turno
    public boolean crearSolicitud(SolicitudCambioTurno solicitud) {
        String sql = "INSERT INTO SOLICITUD_CAMBIO_TURNO (fecha_cambio, id_conductor_solicitante, id_turno_original, id_conductor_destino, id_turno_nuevo, mensaje, observaciones, validacion_horas_sueno, validacion_coincidencia, validacion_saldo_tiempo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(solicitud.getFechaCambio().getTime()));
            ps.setInt(2, solicitud.getIdConductorSolicitante());
            ps.setInt(3, solicitud.getIdTurnoOriginal());
            ps.setInt(4, solicitud.getIdConductorDestino());
            ps.setInt(5, solicitud.getIdTurnoNuevo());
            ps.setString(6, solicitud.getMensaje());
            ps.setString(7, solicitud.getObservaciones());
            ps.setBoolean(8, solicitud.isValidacionHorasSueno());
            ps.setBoolean(9, solicitud.isValidacionCoincidencia());
            ps.setBoolean(10, solicitud.isValidacionSaldoTiempo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Listar solicitudes de un conductor (para vista del conductor)
    public List<SolicitudCambioTurno> listarSolicitudesPorConductor(int idConductor) {
        List<SolicitudCambioTurno> lista = new ArrayList<>();
        String sql = "SELECT * FROM SOLICITUD_CAMBIO_TURNO WHERE id_conductor_solicitante = ? ORDER BY fecha_solicitud DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idConductor);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SolicitudCambioTurno s = mapear(rs);
                lista.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Listar solicitudes pendientes para el admin
    public List<SolicitudCambioTurno> listarSolicitudesPendientesAdmin() {
        List<SolicitudCambioTurno> lista = new ArrayList<>();
        String sql = "SELECT * FROM SOLICITUD_CAMBIO_TURNO WHERE estado_confirmacion_admin = 'PENDIENTE' ORDER BY fecha_solicitud DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SolicitudCambioTurno s = mapear(rs);
                lista.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Obtener una solicitud por su ID (para detalle)
    public SolicitudCambioTurno obtenerPorIdBasico(int idSolicitud) {
        String sql = "SELECT * FROM SOLICITUD_CAMBIO_TURNO WHERE id_solicitud = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSolicitud);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapear(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ACTUALIZAR ESTADO con 5 parámetros
    public boolean actualizarEstado(int idSolicitud, String tipo, String nuevoEstado, int idAdmin, String observaciones) {
        String campo = tipo.equals("COMPANERO") ? "estado_confirmacion_companero" : "estado_confirmacion_admin";
        String fechaCampo = tipo.equals("COMPANERO") ? "fecha_respuesta_companero" : "fecha_respuesta_admin";
        String sql = "UPDATE SOLICITUD_CAMBIO_TURNO SET " + campo + " = ?, " + fechaCampo + " = GETDATE(), id_admin = ?, observaciones = ? WHERE id_solicitud = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idAdmin);
            ps.setString(3, observaciones);
            ps.setInt(4, idSolicitud);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Mapear un ResultSet a un objeto SolicitudCambioTurno
    private SolicitudCambioTurno mapear(ResultSet rs) throws SQLException {
        SolicitudCambioTurno s = new SolicitudCambioTurno();
        s.setIdSolicitud(rs.getInt("id_solicitud"));
        s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
        s.setFechaCambio(rs.getDate("fecha_cambio"));
        s.setIdConductorSolicitante(rs.getInt("id_conductor_solicitante"));
        s.setIdTurnoOriginal(rs.getInt("id_turno_original"));
        s.setIdConductorDestino(rs.getInt("id_conductor_destino"));
        s.setIdTurnoNuevo(rs.getInt("id_turno_nuevo"));
        s.setEstadoConfirmacionCompanero(rs.getString("estado_confirmacion_companero"));
        s.setEstadoConfirmacionAdmin(rs.getString("estado_confirmacion_admin"));
        s.setMensaje(rs.getString("mensaje"));
        s.setObservaciones(rs.getString("observaciones"));
        s.setValidacionHorasSueno(rs.getBoolean("validacion_horas_sueno"));
        s.setValidacionCoincidencia(rs.getBoolean("validacion_coincidencia"));
        s.setValidacionSaldoTiempo(rs.getBoolean("validacion_saldo_tiempo"));
        s.setFechaRespuestaCompanero(rs.getTimestamp("fecha_respuesta_companero"));
        s.setFechaRespuestaAdmin(rs.getTimestamp("fecha_respuesta_admin"));
        s.setIdAdmin(rs.getInt("id_admin"));
        return s;
    }
}
