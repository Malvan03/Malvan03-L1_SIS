package CONTROLADOR;

import DAO.TurnoDAO;
import MODELO.Turno;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegistrarTurnoController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        Turno t = new Turno();
        t.setCodigoTurno(request.getParameter("codigo_turno"));
        t.setTipoTurno(request.getParameter("tipo_turno"));
        t.setHoraInicio(request.getParameter("hora_inicio"));
        t.setHoraFin(request.getParameter("hora_fin"));
        t.setBaseInicio(request.getParameter("base_inicio"));
        t.setBaseFin(request.getParameter("base_fin"));
        t.setCarreraAsignada(request.getParameter("carrera_asignada"));
        t.setTipoCarrera(request.getParameter("tipo_carrera"));
        t.setTieneRefrigerio(Integer.parseInt(request.getParameter("tiene_refrigerio")));
        t.setHoraRefrigerio(request.getParameter("hora_refrigerio"));
        t.setTiempoLaborado(request.getParameter("tiempo_laborado"));

        TurnoDAO dao = new TurnoDAO();
        dao.insertarTurno(t);

        response.sendRedirect("TurnoController");
    }
}
