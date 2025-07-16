package pe.linea1.model;

import java.util.Date;

public class Notificacion {
    private int id;
    private int usuarioId;
    private String mensaje;
    private boolean leido;
    private Date fecha;

    // Getters
    public int getId() { return id; }
    public int getUsuarioId() { return usuarioId; }
    public String getMensaje() { return mensaje; }
    public boolean isLeido() { return leido; }
    public Date getFecha() { return fecha; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    public void setLeido(boolean leido) { this.leido = leido; }
    public void setFecha(Date fecha) { this.fecha = fecha; }
}