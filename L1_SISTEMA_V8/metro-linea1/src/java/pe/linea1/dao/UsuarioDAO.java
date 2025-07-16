package pe.linea1.dao;

import pe.linea1.model.Usuario;
import pe.linea1.util.DBConnection;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

public class UsuarioDAO {

    // 1. Validar usuario (con bloqueo, hash, activo)
    public Usuario validarUsuario(String dni, String password) {
        Usuario user = null;
        String sql = "SELECT * FROM USUARIO WHERE dni = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashAlmacenado = rs.getString("contrasena_hash");
                    int intentosFallidos = rs.getInt("intentos_fallidos");
                    Timestamp bloqueadoHasta = rs.getTimestamp("bloqueado_hasta");
                    String estado = rs.getString("estado");

                    // ¿Está bloqueado?
                    if (bloqueadoHasta != null && bloqueadoHasta.after(new java.util.Date())) {
                        return null;
                    }
                    // ¿Está activo?
                    if (!"ACTIVO".equalsIgnoreCase(estado)) {
                        return null;
                    }

                    // Validar password (bcrypt)
                    if (BCrypt.checkpw(password, hashAlmacenado)) {
                        // Éxito: resetear intentos y bloqueo
                        String resetSql = "UPDATE USUARIO SET intentos_fallidos=0, bloqueado_hasta=NULL, fecha_ultimo_login=GETDATE() WHERE id_usuario=?";
                        try (PreparedStatement ps2 = conn.prepareStatement(resetSql)) {
                            ps2.setInt(1, rs.getInt("id_usuario"));
                            ps2.executeUpdate();
                        }
                        user = mapUsuario(rs);
                    } else {
                        // Fallo: aumentar intentos y/o bloquear
                        intentosFallidos++;
                        if (intentosFallidos >= 4) {
                            String lockSql = "UPDATE USUARIO SET intentos_fallidos=?, bloqueado_hasta=DATEADD(MINUTE, 15, GETDATE()) WHERE id_usuario=?";
                            try (PreparedStatement ps2 = conn.prepareStatement(lockSql)) {
                                ps2.setInt(1, intentosFallidos);
                                ps2.setInt(2, rs.getInt("id_usuario"));
                                ps2.executeUpdate();
                            }
                        } else {
                            String failSql = "UPDATE USUARIO SET intentos_fallidos=? WHERE id_usuario=?";
                            try (PreparedStatement ps2 = conn.prepareStatement(failSql)) {
                                ps2.setInt(1, intentosFallidos);
                                ps2.setInt(2, rs.getInt("id_usuario"));
                                ps2.executeUpdate();
                            }
                        }
                        return null;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // 2. Verifica si usuario está bloqueado temporalmente
    public boolean estaBloqueado(String dni) {
        String sql = "SELECT bloqueado_hasta FROM USUARIO WHERE dni = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Timestamp bloqueadoHasta = rs.getTimestamp("bloqueado_hasta");
                    if (bloqueadoHasta != null && bloqueadoHasta.after(new java.util.Date())) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Insertar nuevo usuario
    public int insertar(Usuario u) throws Exception {
        int id = 0;
        String sql = "INSERT INTO USUARIO (dni, nombres, apellido_paterno, apellido_materno, correo, telefono, contacto_emergencia, fecha_nacimiento, contrasena_hash, rol, estado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getDni());
            ps.setString(2, u.getNombres());
            ps.setString(3, u.getApellidoPaterno());
            ps.setString(4, u.getApellidoMaterno());
            ps.setString(5, u.getCorreo());
            ps.setString(6, u.getTelefono());
            ps.setString(7, u.getContactoEmergencia());
            if (u.getFechaNacimiento() != null) {
                ps.setDate(8, new java.sql.Date(u.getFechaNacimiento().getTime()));
            } else {
                ps.setNull(8, java.sql.Types.DATE);
            }
            ps.setString(9, u.getContrasenaHash());
            ps.setString(10, u.getRol());
            ps.setString(11, u.getEstado());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) id = rs.getInt(1);
            }
        }
        return id;
    }

    // 4. Actualizar datos de usuario (excepto password y rol)
    public void actualizar(Usuario u) throws Exception {
        String sql = "UPDATE USUARIO SET correo=?, telefono=?, contacto_emergencia=?, fecha_nacimiento=? WHERE id_usuario=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getCorreo());
            ps.setString(2, u.getTelefono());
            ps.setString(3, u.getContactoEmergencia());
            if (u.getFechaNacimiento() != null) {
                ps.setDate(4, new java.sql.Date(u.getFechaNacimiento().getTime()));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }
            ps.setInt(5, u.getId());
            ps.executeUpdate();
        }
    }

    // 5. Cambia la contraseña (con hash)
    public void actualizarPassword(int idUsuario, String nuevoHash) throws Exception {
        String sql = "UPDATE USUARIO SET contrasena_hash=? WHERE id_usuario=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoHash);
            ps.setInt(2, idUsuario);
            ps.executeUpdate();
        }
    }

    // 6. Actualiza solo la foto de perfil
    public void actualizarFoto(int id, String nombreArchivo) throws Exception {
        String sql = "UPDATE USUARIO SET foto_perfil=? WHERE id_usuario=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nombreArchivo);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    // 7. Cambia estado (ACTIVO, INACTIVO)
    public void cambiarEstado(int idUsuario, String nuevoEstado) throws Exception {
        String sql = "UPDATE USUARIO SET estado=? WHERE id_usuario=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idUsuario);
            ps.executeUpdate();
        }
    }

    // 8. Buscar usuario por DNI (devuelve objeto Usuario)
    public Usuario buscarPorDni(String dni) {
        Usuario user = null;
        String sql = "SELECT * FROM USUARIO WHERE dni = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = mapUsuario(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // 9. Buscar usuario por ID (opcional)
    public Usuario buscarPorId(int idUsuario) {
        Usuario user = null;
        String sql = "SELECT * FROM USUARIO WHERE id_usuario = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = mapUsuario(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Mapear ResultSet -> Usuario
    private Usuario mapUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id_usuario"));
        u.setDni(rs.getString("dni"));
        u.setNombres(rs.getString("nombres"));
        u.setApellidoPaterno(rs.getString("apellido_paterno"));
        u.setApellidoMaterno(rs.getString("apellido_materno"));
        u.setCorreo(rs.getString("correo"));
        u.setTelefono(rs.getString("telefono"));
        u.setContactoEmergencia(rs.getString("contacto_emergencia"));
        u.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
        u.setContrasenaHash(rs.getString("contrasena_hash"));
        u.setRol(rs.getString("rol"));
        u.setFotoPerfil(rs.getString("foto_perfil"));
        u.setEstado(rs.getString("estado"));
        u.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        u.setFechaUltimoLogin(rs.getTimestamp("fecha_ultimo_login"));
        return u;
    }
}
