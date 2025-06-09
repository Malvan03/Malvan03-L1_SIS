package MODELO;

import java.sql.Date;

public class Asignacion {
    private int idConductor;
    private int idTurno;
    private Date fecha;
    private String diaSemana;
    private String observaciones;

    // Nuevos campos para detalle de turno
    private String baseInicio;
    private String baseFin;
    private String tipoCarrera;
    private String horaRefrigerio;
    private String tiempoLaborado;

    // Getters y Setters básicos
    public int getIdConductor() {
        return idConductor;
    }

    public void setIdConductor(int idConductor) {
        this.idConductor = idConductor;
    }

    public int getIdTurno() {
        return idTurno;
    }

    public void setIdTurno(int idTurno) {
        this.idTurno = idTurno;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    // Getters y Setters nuevos para mostrar detalles del turno

    public String getBaseInicio() {
        return baseInicio;
    }

    public void setBaseInicio(String baseInicio) {
        this.baseInicio = baseInicio;
    }

    public String getBaseFin() {
        return baseFin;
    }

    public void setBaseFin(String baseFin) {
        this.baseFin = baseFin;
    }

    public String getTipoCarrera() {
        return tipoCarrera;
    }

    public void setTipoCarrera(String tipoCarrera) {
        this.tipoCarrera = tipoCarrera;
    }

    public String getHoraRefrigerio() {
        return horaRefrigerio;
    }

    public void setHoraRefrigerio(String horaRefrigerio) {
        this.horaRefrigerio = horaRefrigerio;
    }

    public String getTiempoLaborado() {
        return tiempoLaborado;
    }

    public void setTiempoLaborado(String tiempoLaborado) {
        this.tiempoLaborado = tiempoLaborado;
    }
}
