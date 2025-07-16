package pe.linea1.model;

import java.util.Date;

public class Usuario {
    private int idUsuario;
    private String dni;
    private String nombres;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String correo;
    private String telefono;
    private String contactoEmergencia;
    private Date fechaNacimiento;
    private String contrasenaHash;
    private String rol;
    private String fotoPerfil;
    private String estado;
    private Date fechaRegistro;
    private Date fechaUltimoLogin;

    // NUEVO: ID CONDUCTOR
    private int idConductor;

    public Usuario() {}

    // Getters y Setters
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidoPaterno() { return apellidoPaterno; }
    public void setApellidoPaterno(String apellidoPaterno) { this.apellidoPaterno = apellidoPaterno; }

    public String getApellidoMaterno() { return apellidoMaterno; }
    public void setApellidoMaterno(String apellidoMaterno) { this.apellidoMaterno = apellidoMaterno; }

    // Auxiliar para compatibilidad con código antiguo
    public String getApellidos() {
        return ((apellidoPaterno != null) ? apellidoPaterno : "") +
               ((apellidoPaterno != null && apellidoMaterno != null) ? " " : "") +
               ((apellidoMaterno != null) ? apellidoMaterno : "");
    }
    public void setApellidos(String apellidos) {
        if (apellidos != null && !apellidos.isEmpty()) {
            String[] parts = apellidos.trim().split("\\s+", 2);
            this.apellidoPaterno = parts[0];
            if (parts.length > 1) {
                this.apellidoMaterno = parts[1];
            }
        }
    }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getContactoEmergencia() { return contactoEmergencia; }
    public void setContactoEmergencia(String contactoEmergencia) { this.contactoEmergencia = contactoEmergencia; }

    public Date getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(Date fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public String getContrasenaHash() { return contrasenaHash; }
    public void setContrasenaHash(String contrasenaHash) { this.contrasenaHash = contrasenaHash; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public String getFotoPerfil() { return fotoPerfil; }
    public void setFotoPerfil(String fotoPerfil) { this.fotoPerfil = fotoPerfil; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Date getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Date fechaRegistro) { this.fechaRegistro = fechaRegistro; }

    public Date getFechaUltimoLogin() { return fechaUltimoLogin; }
    public void setFechaUltimoLogin(Date fechaUltimoLogin) { this.fechaUltimoLogin = fechaUltimoLogin; }

    // Para compatibilidad con código antiguo
    public int getId() { return idUsuario; }
    public void setId(int id) { this.idUsuario = id; }

    // NUEVO: GETTER Y SETTER ID CONDUCTOR
    public int getIdConductor() { return idConductor; }
    public void setIdConductor(int idConductor) { this.idConductor = idConductor; }
}
