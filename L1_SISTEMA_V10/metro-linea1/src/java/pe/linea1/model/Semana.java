package pe.linea1.model;

import java.util.Date;

public class Semana {
    private int idSemana;
    private int numeroSemana;
    private Date fechaInicio;
    private Date fechaFin;
    private String estado;

    // Getters y Setters
    public int getIdSemana() { return idSemana; }
    public void setIdSemana(int idSemana) { this.idSemana = idSemana; }
    public int getNumeroSemana() { return numeroSemana; }
    public void setNumeroSemana(int numeroSemana) { this.numeroSemana = numeroSemana; }
    public Date getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(Date fechaInicio) { this.fechaInicio = fechaInicio; }
    public Date getFechaFin() { return fechaFin; }
    public void setFechaFin(Date fechaFin) { this.fechaFin = fechaFin; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}