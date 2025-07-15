package pe.linea1.model;

import java.util.Date;

public class Turno {
    private int idTurno;
    private int idConductor;
    private Integer idSemana;
    private String diaSemana;
    private String horaInicio;
    private String horaFin;
    private int carreras;
    private Date fecha;
    private int saldoTiempo;
    private int tiempoLaborado;
    private Integer turnoAnterior;
    private String observaciones;

    // Getters y Setters
    public int getIdTurno() { return idTurno; }
    public void setIdTurno(int idTurno) { this.idTurno = idTurno; }

    public int getIdConductor() { return idConductor; }
    public void setIdConductor(int idConductor) { this.idConductor = idConductor; }

    public Integer getIdSemana() { return idSemana; }
    public void setIdSemana(Integer idSemana) { this.idSemana = idSemana; }

    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public int getCarreras() { return carreras; }
    public void setCarreras(int carreras) { this.carreras = carreras; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public int getSaldoTiempo() { return saldoTiempo; }
    public void setSaldoTiempo(int saldoTiempo) { this.saldoTiempo = saldoTiempo; }

    public int getTiempoLaborado() { return tiempoLaborado; }
    public void setTiempoLaborado(int tiempoLaborado) { this.tiempoLaborado = tiempoLaborado; }

    public Integer getTurnoAnterior() { return turnoAnterior; }
    public void setTurnoAnterior(Integer turnoAnterior) { this.turnoAnterior = turnoAnterior; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}
