package pe.linea1.dao;

import pe.linea1.model.Conductor;
import pe.linea1.model.Usuario;
import pe.linea1.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConductorDAO {
    // Insertar nuevo conductor
    public void insertar(Conductor c) throws Exception {
        String sql = "INSERT INTO CONDUCTOR (id_usuario, modalidad, base, fecha_ingreso, habilitado, estado_personal, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getIdUsuario());
            ps.setString(2, c.getModalidad());
            ps.setString(3, c.getBase());
            ps.setDate(4, new java.sql.Date(c.getFechaIngreso().getTime()));
            ps.setBoolean(5, c.isHabilitado());
            ps.setString(6, c.getEstadoPersonal());
            ps.setString(7, c.getObservaciones());
            ps.executeUpdate();
        }
    }

    // Obtener conductor por ID
    public Conductor obtenerPorId(int idConductor) throws Exception {
        String sql = "SELECT c.id_conductor, c.id_usuario, u.dni, u.nombres, u.apellido_paterno, u.apellido_materno, " +
                     "u.correo, u.telefono, c.modalidad, c.base, c.fecha_ingreso, c.habilitado, " +
                     "c.estado_personal, c.observaciones " +
                     "FROM CONDUCTOR c INNER JOIN USUARIO u ON c.id_usuario = u.id_usuario WHERE c.id_conductor = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idConductor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearConductorConUsuario(rs);
                }
            }
        }
        return null;
    }

    // Actualizar conductor existente
    public void actualizar(Conductor c) throws Exception {
        String sql = "UPDATE CONDUCTOR SET modalidad=?, base=?, fecha_ingreso=?, habilitado=?, estado_personal=?, observaciones=? WHERE id_conductor=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getModalidad());
            ps.setString(2, c.getBase());
            ps.setDate(3, new java.sql.Date(c.getFechaIngreso().getTime()));
            ps.setBoolean(4, c.isHabilitado());
            ps.setString(5, c.getEstadoPersonal());
            ps.setString(6, c.getObservaciones());
            ps.setInt(7, c.getIdConductor());
            ps.executeUpdate();
        }
    }

    // Inhabilitar (cesar) conductor por ID
    public void inhabilitar(int idConductor) throws Exception {
        String sql = "UPDATE CONDUCTOR SET estado_personal='CESADO' WHERE id_conductor=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idConductor);
            ps.executeUpdate();
        }
    }

    // Buscar conductores con filtros flexibles
    public List<Conductor> buscarConductores(String dni, String modalidad, String estado, java.util.Date fechaIngreso) throws Exception {
        StringBuilder sql = new StringBuilder(
            "SELECT c.id_conductor, c.id_usuario, u.dni, u.nombres, u.apellido_paterno, u.apellido_materno, " +
            "u.correo, u.telefono, c.modalidad, c.base, c.fecha_ingreso, c.habilitado, " +
            "c.estado_personal, c.observaciones " +
            "FROM CONDUCTOR c INNER JOIN USUARIO u ON c.id_usuario = u.id_usuario WHERE 1=1");

        List<Object> params = new ArrayList<>();
        if (dni != null && !dni.isEmpty()) {
            sql.append(" AND u.dni LIKE ?");
            params.add("%" + dni + "%");
        }
        if (modalidad != null && !modalidad.isEmpty()) {
            sql.append(" AND c.modalidad = ?");
            params.add(modalidad);
        }
        if (estado != null && !estado.isEmpty()) {
            sql.append(" AND c.estado_personal = ?");
            params.add(estado);
        }
        if (fechaIngreso != null) {
            sql.append(" AND c.fecha_ingreso = ?");
            params.add(new java.sql.Date(fechaIngreso.getTime()));
        }
        sql.append(" ORDER BY u.apellido_paterno, u.apellido_materno, u.nombres");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                List<Conductor> lista = new ArrayList<>();
                while (rs.next()) {
                    lista.add(mapearConductorConUsuario(rs));
                }
                return lista;
            }
        }
    }

    // Listar todos los conductores (requerido por el servlet)
    public List<Conductor> listarTodos() throws Exception {
        return buscarConductores(null, null, null, null);
    }

    // Listar solo los conductores activos (para combos/filtros)
    public List<Conductor> listarActivos() throws Exception {
        String sql = "SELECT c.id_conductor, c.id_usuario, u.dni, u.nombres, u.apellido_paterno, u.apellido_materno, " +
                     "u.correo, u.telefono, c.modalidad, c.base, c.fecha_ingreso, c.habilitado, " +
                     "c.estado_personal, c.observaciones " +
                     "FROM CONDUCTOR c INNER JOIN USUARIO u ON c.id_usuario = u.id_usuario " +
                     "WHERE c.estado_personal = 'ACTIVO' ORDER BY u.apellido_paterno, u.apellido_materno, u.nombres";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Conductor> lista = new ArrayList<>();
            while (rs.next()) {
                lista.add(mapearConductorConUsuario(rs));
            }
            return lista;
        }
    }

    // Helper para mapear ResultSet a Conductor con Usuario
    private Conductor mapearConductorConUsuario(ResultSet rs) throws SQLException {
        // Crear objeto Usuario
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(rs.getInt("id_usuario"));
        usuario.setDni(rs.getString("dni"));
        usuario.setNombres(rs.getString("nombres"));
        usuario.setApellidoPaterno(rs.getString("apellido_paterno"));
        usuario.setApellidoMaterno(rs.getString("apellido_materno"));
        usuario.setCorreo(rs.getString("correo"));
        usuario.setTelefono(rs.getString("telefono"));

        // Crear objeto Conductor
        Conductor conductor = new Conductor();
        conductor.setIdConductor(rs.getInt("id_conductor"));
        conductor.setIdUsuario(rs.getInt("id_usuario"));
        conductor.setModalidad(rs.getString("modalidad"));
        conductor.setBase(rs.getString("base"));
        conductor.setFechaIngreso(rs.getDate("fecha_ingreso"));
        conductor.setHabilitado(rs.getBoolean("habilitado"));
        conductor.setEstadoPersonal(rs.getString("estado_personal"));
        conductor.setObservaciones(rs.getString("observaciones"));

        // Sincronizar apellidos y nombres completos en el objeto conductor
        conductor.setDni(usuario.getDni());
        conductor.setNombres(usuario.getNombres());
        conductor.setApellidoPaterno(usuario.getApellidoPaterno());
        conductor.setApellidoMaterno(usuario.getApellidoMaterno());
        conductor.setCorreo(usuario.getCorreo());
        conductor.setTelefono(usuario.getTelefono());

        // Asociar Usuario al Conductor
        conductor.setUsuario(usuario);

        return conductor;
    }
}