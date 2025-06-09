package CONTROLADOR;

import DAO.AsignacionDAO;
import MODELO.Asignacion;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

public class AsignarTurnoController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Asignacion a = new Asignacion();
        a.setIdConductor(Integer.parseInt(request.getParameter("id_conductor")));
        a.setIdTurno(Integer.parseInt(request.getParameter("id_turno")));
        a.setFecha(Date.valueOf(request.getParameter("fecha")));
        a.setDiaSemana(request.getParameter("dia_semana"));
        a.setObservaciones(request.getParameter("observaciones"));

        AsignacionDAO dao = new AsignacionDAO();
        dao.insertarAsignacion(a);

        response.sendRedirect("home_admin.jsp");
    }
}
