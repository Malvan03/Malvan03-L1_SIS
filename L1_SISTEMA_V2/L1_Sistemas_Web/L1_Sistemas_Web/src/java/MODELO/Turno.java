package MODELO;

public class Turno {
    private int idTurno;
    private String codigoTurno;
    private String tipoTurno;
    private String horaInicio;
    private String horaFin;
    private String baseInicio;
    private String baseFin;
    private String carreraAsignada;
    private String tipoCarrera;
    private int tieneRefrigerio;
    private String horaRefrigerio;
    private String tiempoLaborado;

    public int getIdTurno() { return idTurno; }
    public void setIdTurno(int idTurno) { this.idTurno = idTurno; }

    public String getCodigoTurno() { return codigoTurno; }
    public void setCodigoTurno(String codigoTurno) { this.codigoTurno = codigoTurno; }

    public String getTipoTurno() { return tipoTurno; }
    public void setTipoTurno(String tipoTurno) { this.tipoTurno = tipoTurno; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public String getBaseInicio() { return baseInicio; }
    public void setBaseInicio(String baseInicio) { this.baseInicio = baseInicio; }

    public String getBaseFin() { return baseFin; }
    public void setBaseFin(String baseFin) { this.baseFin = baseFin; }

    public String getCarreraAsignada() { return carreraAsignada; }
    public void setCarreraAsignada(String carreraAsignada) { this.carreraAsignada = carreraAsignada; }

    public String getTipoCarrera() { return tipoCarrera; }
    public void setTipoCarrera(String tipoCarrera) { this.tipoCarrera = tipoCarrera; }

    public int getTieneRefrigerio() { return tieneRefrigerio; }
    public void setTieneRefrigerio(int tieneRefrigerio) { this.tieneRefrigerio = tieneRefrigerio; }

    public String getHoraRefrigerio() { return horaRefrigerio; }
    public void setHoraRefrigerio(String horaRefrigerio) { this.horaRefrigerio = horaRefrigerio; }

    public String getTiempoLaborado() { return tiempoLaborado; }
    public void setTiempoLaborado(String tiempoLaborado) { this.tiempoLaborado = tiempoLaborado; }
}
