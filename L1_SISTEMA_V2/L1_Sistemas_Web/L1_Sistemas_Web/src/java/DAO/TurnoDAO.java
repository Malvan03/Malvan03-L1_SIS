package DAO;

import MODELO.Turno;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TurnoDAO {

    // ✅ Método para listar todos los turnos
    public List<Turno> listarTurnos() {
        List<Turno> lista = new ArrayList<>();
        String sql = "SELECT id_turno, codigo_turno, tipo_turno, hora_inicio, hora_fin FROM Turnos";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Turno t = new Turno();
                t.setIdTurno(rs.getInt("id_turno"));
                t.setCodigoTurno(rs.getString("codigo_turno"));
                t.setTipoTurno(rs.getString("tipo_turno"));
                t.setHoraInicio(rs.getString("hora_inicio"));
                t.setHoraFin(rs.getString("hora_fin"));
                lista.add(t);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al listar turnos: " + e.getMessage());
        }

        return lista;
    }

    // ✅ Método para insertar un nuevo turno
    public void insertarTurno(Turno t) {
        String sql = "INSERT INTO Turnos (codigo_turno, tipo_turno, hora_inicio, hora_fin, base_inicio, base_fin, carrera_asignada, tipo_carrera, tiene_refrigerio, hora_refrigerio, tiempo_laborado) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getCodigoTurno());
            ps.setString(2, t.getTipoTurno());
            ps.setString(3, t.getHoraInicio());
            ps.setString(4, t.getHoraFin());
            ps.setString(5, t.getBaseInicio());
            ps.setString(6, t.getBaseFin());
            ps.setString(7, t.getCarreraAsignada());
            ps.setString(8, t.getTipoCarrera());
            ps.setInt(9, t.getTieneRefrigerio());
            ps.setString(10, t.getHoraRefrigerio());
            ps.setString(11, t.getTiempoLaborado());

            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("❌ Error al insertar turno: " + e.getMessage());
        }
    }
}
