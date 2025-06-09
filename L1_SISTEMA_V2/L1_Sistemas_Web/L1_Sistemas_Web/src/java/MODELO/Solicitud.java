package MODELO;

import java.sql.Date;

public class Solicitud {
    private int idSolicitud;
    private Date fechaTurno;
    private int idSolicitante;
    private int idAsignacionOriginal;
    private int idAsignacionSolicitada;
    private String estadoReceptor;
    private String estadoAdmin;
    private String observacion;
    private int idNotificacion;  // Atributo agregado para la notificación

    // Getters y Setters
    public int getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(int idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Date getFechaTurno() {
        return fechaTurno;
    }

    public void setFechaTurno(Date fechaTurno) {
        this.fechaTurno = fechaTurno;
    }

    public int getIdSolicitante() {
        return idSolicitante;
    }

    public void setIdSolicitante(int idSolicitante) {
        this.idSolicitante = idSolicitante;
    }

    public int getIdAsignacionOriginal() {
        return idAsignacionOriginal;
    }

    public void setIdAsignacionOriginal(int idAsignacionOriginal) {
        this.idAsignacionOriginal = idAsignacionOriginal;
    }

    public int getIdAsignacionSolicitada() {
        return idAsignacionSolicitada;
    }

    public void setIdAsignacionSolicitada(int idAsignacionSolicitada) {
        this.idAsignacionSolicitada = idAsignacionSolicitada;
    }

    public String getEstadoReceptor() {
        return estadoReceptor;
    }

    public void setEstadoReceptor(String estadoReceptor) {
        this.estadoReceptor = estadoReceptor;
    }

    public String getEstadoAdmin() {
        return estadoAdmin;
    }

    public void setEstadoAdmin(String estadoAdmin) {
        this.estadoAdmin = estadoAdmin;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    // Getter y Setter para el idNotificacion
    public int getIdNotificacion() {
        return idNotificacion;
    }

    public void setIdNotificacion(int idNotificacion) {
        this.idNotificacion = idNotificacion;
    }
}
