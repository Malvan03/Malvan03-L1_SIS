package pe.linea1.dao;

import pe.linea1.model.Turno;
import pe.linea1.util.DBConnection;

import java.sql.*;
import java.util.*;

public class TurnoDAO {

    // Listar turnos por idConductor
    public List<Turno> listarPorConductor(int idConductor) throws Exception {
        List<Turno> lista = new ArrayList<>();
        String sql = "SELECT * FROM TURNO WHERE id_conductor=? ORDER BY fecha, hora_inicio";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idConductor);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearTurno(rs));
                }
            }
        }
        return lista;
    }

    // Obtener turno por ID
    public Turno obtenerPorId(int idTurno) throws Exception {
        String sql = "SELECT * FROM TURNO WHERE id_turno=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTurno);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearTurno(rs);
                }
            }
        }
        return null;
    }

    // Insertar nuevo turno
    public void insertar(Turno t) throws Exception {
        String sql = "INSERT INTO TURNO (id_conductor, id_semana, dia_semana, hora_inicio, hora_fin, carreras, fecha, saldo_tiempo, tiempo_laborado, turno_anterior, observaciones) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, t.getIdConductor());
            if (t.getIdSemana() == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, t.getIdSemana());
            ps.setString(3, t.getDiaSemana());
            ps.setString(4, t.getHoraInicio());
            ps.setString(5, t.getHoraFin());
            ps.setInt(6, t.getCarreras());
            ps.setDate(7, new java.sql.Date(t.getFecha().getTime()));
            ps.setInt(8, t.getSaldoTiempo());
            ps.setInt(9, t.getTiempoLaborado());
            if (t.getTurnoAnterior() == null) ps.setNull(10, Types.INTEGER); else ps.setInt(10, t.getTurnoAnterior());
            ps.setString(11, t.getObservaciones());
            ps.executeUpdate();
        }
    }

    // Actualizar turno
    public void actualizar(Turno t) throws Exception {
        String sql = "UPDATE TURNO SET id_conductor=?, id_semana=?, dia_semana=?, hora_inicio=?, hora_fin=?, carreras=?, fecha=?, saldo_tiempo=?, tiempo_laborado=?, turno_anterior=?, observaciones=? WHERE id_turno=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, t.getIdConductor());
            if (t.getIdSemana() == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, t.getIdSemana());
            ps.setString(3, t.getDiaSemana());
            ps.setString(4, t.getHoraInicio());
            ps.setString(5, t.getHoraFin());
            ps.setInt(6, t.getCarreras());
            ps.setDate(7, new java.sql.Date(t.getFecha().getTime()));
            ps.setInt(8, t.getSaldoTiempo());
            ps.setInt(9, t.getTiempoLaborado());
            if (t.getTurnoAnterior() == null) ps.setNull(10, Types.INTEGER); else ps.setInt(10, t.getTurnoAnterior());
            ps.setString(11, t.getObservaciones());
            ps.setInt(12, t.getIdTurno());
            ps.executeUpdate();
        }
    }

    // Eliminar turno
    public void eliminar(int idTurno) throws Exception {
        String sql = "DELETE FROM TURNO WHERE id_turno=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTurno);
            ps.executeUpdate();
        }
    }

    // Mapeo
    private Turno mapearTurno(ResultSet rs) throws SQLException {
        Turno t = new Turno();
        t.setIdTurno(rs.getInt("id_turno"));
        t.setIdConductor(rs.getInt("id_conductor"));
        t.setIdSemana(rs.getObject("id_semana") != null ? rs.getInt("id_semana") : null);
        t.setDiaSemana(rs.getString("dia_semana"));
        t.setHoraInicio(rs.getString("hora_inicio"));
        t.setHoraFin(rs.getString("hora_fin"));
        t.setCarreras(rs.getInt("carreras"));
        t.setFecha(rs.getDate("fecha"));
        t.setSaldoTiempo(rs.getInt("saldo_tiempo"));
        t.setTiempoLaborado(rs.getInt("tiempo_laborado"));
        t.setTurnoAnterior(rs.getObject("turno_anterior") != null ? rs.getInt("turno_anterior") : null);
        t.setObservaciones(rs.getString("observaciones"));
        return t;
    }
}
