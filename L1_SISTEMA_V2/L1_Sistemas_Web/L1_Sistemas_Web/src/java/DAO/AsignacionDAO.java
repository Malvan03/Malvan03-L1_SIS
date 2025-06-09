package DAO;

import MODELO.Asignacion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AsignacionDAO {

    // ✅ Insertar una nueva asignación
    public void insertarAsignacion(Asignacion a) {
        String sql = "INSERT INTO Asignaciones (id_conductor, id_turno, fecha, dia_semana, observaciones) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, a.getIdConductor());
            ps.setInt(2, a.getIdTurno());
            ps.setDate(3, a.getFecha());
            ps.setString(4, a.getDiaSemana());
            ps.setString(5, a.getObservaciones());

            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("❌ Error al insertar asignación: " + e.getMessage());
        }
    }

    // ✅ Listar todas las asignaciones (modo admin)
    public List<Asignacion> listarAsignaciones() {
        List<Asignacion> lista = new ArrayList<>();
        String sql = "SELECT id_conductor, id_turno, fecha, dia_semana, observaciones FROM Asignaciones";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Asignacion a = new Asignacion();
                a.setIdConductor(rs.getInt("id_conductor"));
                a.setIdTurno(rs.getInt("id_turno"));
                a.setFecha(rs.getDate("fecha"));
                a.setDiaSemana(rs.getString("dia_semana"));
                a.setObservaciones(rs.getString("observaciones"));
                lista.add(a);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al listar asignaciones: " + e.getMessage());
        }

        return lista;
    }

    // ✅ Obtener turnos asignados por id_conductor (modo conductor) con detalles de turno
    public List<Asignacion> getTurnosPorConductor(int idConductor) {
        List<Asignacion> lista = new ArrayList<>();

        String sql = "SELECT a.id_turno, a.fecha, a.dia_semana, a.observaciones, " +
                     "t.base_inicio, t.base_fin, t.tipo_carrera, t.hora_refrigerio, t.tiempo_laborado " +
                     "FROM Asignaciones a " +
                     "JOIN Turnos t ON a.id_turno = t.id_turno " +
                     "WHERE a.id_conductor = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idConductor);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Asignacion a = new Asignacion();
                a.setIdTurno(rs.getInt("id_turno"));
                a.setFecha(rs.getDate("fecha"));
                a.setDiaSemana(rs.getString("dia_semana"));
                a.setObservaciones(rs.getString("observaciones"));

                // Detalles del turno
                a.setBaseInicio(rs.getString("base_inicio"));
                a.setBaseFin(rs.getString("base_fin"));
                a.setTipoCarrera(rs.getString("tipo_carrera"));
                a.setHoraRefrigerio(rs.getString("hora_refrigerio"));
                a.setTiempoLaborado(rs.getString("tiempo_laborado"));

                lista.add(a);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al obtener turnos por conductor: " + e.getMessage());
        }

        return lista;
    }
}
