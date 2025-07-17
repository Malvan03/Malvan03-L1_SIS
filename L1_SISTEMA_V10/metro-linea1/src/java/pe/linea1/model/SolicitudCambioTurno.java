package pe.linea1.model;

import java.util.Date;

public class SolicitudCambioTurno {
    private int idSolicitud;
    private Date fechaSolicitud;
    private Date fechaCambio;
    private int idConductorSolicitante;
    private int idTurnoOriginal;
    private int idConductorDestino;
    private int idTurnoNuevo;
    private String estadoConfirmacionCompanero; // PENDIENTE, ACEPTADO, RECHAZADO
    private String estadoConfirmacionAdmin;     // PENDIENTE, ACEPTADO, RECHAZADO
    private String mensaje;
    private String observaciones;
    private boolean validacionHorasSueno;
    private boolean validacionCoincidencia;
    private boolean validacionSaldoTiempo;
    private Date fechaRespuestaCompanero;
    private Date fechaRespuestaAdmin;
    private int idAdmin;

    // ----------- Campos extra para mostrar en tablas (descripciones) -----------
    private String turnoOriginalDesc;
    private String turnoNuevoDesc;
    private String nombreCompanero;
    // ---------------------------------------------------------------------------

    public SolicitudCambioTurno() {}

    // Getters y Setters
    public int getIdSolicitud() { return idSolicitud; }
    public void setIdSolicitud(int idSolicitud) { this.idSolicitud = idSolicitud; }

    public Date getFechaSolicitud() { return fechaSolicitud; }
    public void setFechaSolicitud(Date fechaSolicitud) { this.fechaSolicitud = fechaSolicitud; }

    public Date getFechaCambio() { return fechaCambio; }
    public void setFechaCambio(Date fechaCambio) { this.fechaCambio = fechaCambio; }

    public int getIdConductorSolicitante() { return idConductorSolicitante; }
    public void setIdConductorSolicitante(int idConductorSolicitante) { this.idConductorSolicitante = idConductorSolicitante; }

    public int getIdTurnoOriginal() { return idTurnoOriginal; }
    public void setIdTurnoOriginal(int idTurnoOriginal) { this.idTurnoOriginal = idTurnoOriginal; }

    public int getIdConductorDestino() { return idConductorDestino; }
    public void setIdConductorDestino(int idConductorDestino) { this.idConductorDestino = idConductorDestino; }

    public int getIdTurnoNuevo() { return idTurnoNuevo; }
    public void setIdTurnoNuevo(int idTurnoNuevo) { this.idTurnoNuevo = idTurnoNuevo; }

    public String getEstadoConfirmacionCompanero() { return estadoConfirmacionCompanero; }
    public void setEstadoConfirmacionCompanero(String estadoConfirmacionCompanero) { this.estadoConfirmacionCompanero = estadoConfirmacionCompanero; }

    public String getEstadoConfirmacionAdmin() { return estadoConfirmacionAdmin; }
    public void setEstadoConfirmacionAdmin(String estadoConfirmacionAdmin) { this.estadoConfirmacionAdmin = estadoConfirmacionAdmin; }

    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public boolean isValidacionHorasSueno() { return validacionHorasSueno; }
    public void setValidacionHorasSueno(boolean validacionHorasSueno) { this.validacionHorasSueno = validacionHorasSueno; }

    public boolean isValidacionCoincidencia() { return validacionCoincidencia; }
    public void setValidacionCoincidencia(boolean validacionCoincidencia) { this.validacionCoincidencia = validacionCoincidencia; }

    public boolean isValidacionSaldoTiempo() { return validacionSaldoTiempo; }
    public void setValidacionSaldoTiempo(boolean validacionSaldoTiempo) { this.validacionSaldoTiempo = validacionSaldoTiempo; }

    public Date getFechaRespuestaCompanero() { return fechaRespuestaCompanero; }
    public void setFechaRespuestaCompanero(Date fechaRespuestaCompanero) { this.fechaRespuestaCompanero = fechaRespuestaCompanero; }

    public Date getFechaRespuestaAdmin() { return fechaRespuestaAdmin; }
    public void setFechaRespuestaAdmin(Date fechaRespuestaAdmin) { this.fechaRespuestaAdmin = fechaRespuestaAdmin; }

    public int getIdAdmin() { return idAdmin; }
    public void setIdAdmin(int idAdmin) { this.idAdmin = idAdmin; }

    // --------- Getters y Setters para los campos extra ---------
    public String getTurnoOriginalDesc() { return turnoOriginalDesc; }
    public void setTurnoOriginalDesc(String turnoOriginalDesc) { this.turnoOriginalDesc = turnoOriginalDesc; }

    public String getTurnoNuevoDesc() { return turnoNuevoDesc; }
    public void setTurnoNuevoDesc(String turnoNuevoDesc) { this.turnoNuevoDesc = turnoNuevoDesc; }

    public String getNombreCompanero() { return nombreCompanero; }
    public void setNombreCompanero(String nombreCompanero) { this.nombreCompanero = nombreCompanero; }

    @Override
    public String toString() {
        return "SolicitudCambioTurno{" +
                "idSolicitud=" + idSolicitud +
                ", fechaSolicitud=" + fechaSolicitud +
                ", fechaCambio=" + fechaCambio +
                ", idConductorSolicitante=" + idConductorSolicitante +
                ", idTurnoOriginal=" + idTurnoOriginal +
                ", idConductorDestino=" + idConductorDestino +
                ", idTurnoNuevo=" + idTurnoNuevo +
                ", estadoConfirmacionCompanero='" + estadoConfirmacionCompanero + '\'' +
                ", estadoConfirmacionAdmin='" + estadoConfirmacionAdmin + '\'' +
                ", mensaje='" + mensaje + '\'' +
                ", observaciones='" + observaciones + '\'' +
                ", validacionHorasSueno=" + validacionHorasSueno +
                ", validacionCoincidencia=" + validacionCoincidencia +
                ", validacionSaldoTiempo=" + validacionSaldoTiempo +
                ", fechaRespuestaCompanero=" + fechaRespuestaCompanero +
                ", fechaRespuestaAdmin=" + fechaRespuestaAdmin +
                ", idAdmin=" + idAdmin +
                ", turnoOriginalDesc='" + turnoOriginalDesc + '\'' +
                ", turnoNuevoDesc='" + turnoNuevoDesc + '\'' +
                ", nombreCompanero='" + nombreCompanero + '\'' +
                '}';
    }
}
