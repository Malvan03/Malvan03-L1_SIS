package pe.linea1.model;

import java.util.Date;

public class Conductor {
    private int idConductor;
    private int idUsuario;
    private String dni;
    private String nombres;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String correo;
    private String telefono;
    private String modalidad;
    private String turnoActual;
    private String base;
    private Date fechaIngreso;
    private boolean habilitado;
    private String estadoPersonal;
    private String observaciones;
    private Usuario usuario; // Referencia al objeto Usuario

    // Getters y Setters
    public int getIdConductor() { return idConductor; }
    public void setIdConductor(int idConductor) { this.idConductor = idConductor; }

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

    // Por compatibilidad
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

    public String getModalidad() { return modalidad; }
    public void setModalidad(String modalidad) { this.modalidad = modalidad; }

    public String getBase() { return base; }
    public void setBase(String base) { this.base = base; }

    public Date getFechaIngreso() { return fechaIngreso; }
    public void setFechaIngreso(Date fechaIngreso) { this.fechaIngreso = fechaIngreso; }

    public boolean isHabilitado() { return habilitado; }
    public void setHabilitado(boolean habilitado) { this.habilitado = habilitado; }

    public String getEstadoPersonal() { return estadoPersonal; }
    public void setEstadoPersonal(String estadoPersonal) { this.estadoPersonal = estadoPersonal; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public String getTurnoActual() { return turnoActual; }
    public void setTurnoActual(String turnoActual) { this.turnoActual = turnoActual; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
        if (usuario != null) {
            this.idUsuario = usuario.getIdUsuario();
            this.dni = usuario.getDni();
            this.nombres = usuario.getNombres();
            this.apellidoPaterno = usuario.getApellidoPaterno();
            this.apellidoMaterno = usuario.getApellidoMaterno();
            this.correo = usuario.getCorreo();
            this.telefono = usuario.getTelefono();
        }
    }
}
