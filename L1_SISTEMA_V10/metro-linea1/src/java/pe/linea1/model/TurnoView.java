package pe.linea1.model;

import java.util.Date;

public class TurnoView {
    private int idTurno;
    private String semanaLabel;
    private String nombreConductor;
    private String diaSemana;
    private Date fecha;
    private String horaInicio;
    private String horaFin;
    private int carreras;
    private String nombreTurno;

    // Getters y Setters
    public int getIdTurno() { return idTurno; }
    public void setIdTurno(int idTurno) { this.idTurno = idTurno; }

    public String getSemanaLabel() { return semanaLabel; }
    public void setSemanaLabel(String semanaLabel) { this.semanaLabel = semanaLabel; }

    public String getNombreConductor() { return nombreConductor; }
    public void setNombreConductor(String nombreConductor) { this.nombreConductor = nombreConductor; }

    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public int getCarreras() { return carreras; }
    public void setCarreras(int carreras) { this.carreras = carreras; }

    public String getNombreTurno() { return nombreTurno; }
    public void setNombreTurno(String nombreTurno) { this.nombreTurno = nombreTurno; }
}