package pe.linea1.dao;

import pe.linea1.model.Semana;
import pe.linea1.util.DBConnection;

import java.sql.*;
import java.util.*;

public class SemanaDAO {
    public List<Semana> listarSemanas() throws Exception {
        List<Semana> lista = new ArrayList<>();
        String sql = "SELECT id_semana, numero_semana, fecha_inicio, fecha_fin, estado FROM SEMANA_PROGRAMACION ORDER BY numero_semana DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Semana s = new Semana();
                s.setIdSemana(rs.getInt("id_semana"));
                s.setNumeroSemana(rs.getInt("numero_semana"));
                s.setFechaInicio(rs.getDate("fecha_inicio"));
                s.setFechaFin(rs.getDate("fecha_fin"));
                s.setEstado(rs.getString("estado"));
                lista.add(s);
            }
        }
        return lista;
    }
}