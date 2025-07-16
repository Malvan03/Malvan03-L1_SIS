package pe.linea1.model;

import java.util.Date;

public class Auditoria {
    private int idAuditoria;
    private Usuario usuario;
    private String tipoAccion;
    private Date fechaHora;
    private String descripcion;

    public int getIdAuditoria() { return idAuditoria; }
    public void setIdAuditoria(int idAuditoria) { this.idAuditoria = idAuditoria; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public String getTipoAccion() { return tipoAccion; }
    public void setTipoAccion(String tipoAccion) { this.tipoAccion = tipoAccion; }

    public Date getFechaHora() { return fechaHora; }
    public void setFechaHora(Date fechaHora) { this.fechaHora = fechaHora; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}