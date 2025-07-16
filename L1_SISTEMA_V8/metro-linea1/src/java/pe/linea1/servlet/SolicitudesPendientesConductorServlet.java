package pe.linea1.servlet;

import pe.linea1.dao.SolicitudCambioTurnoDAO;
import pe.linea1.model.SolicitudCambioTurno;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/conductor/solicitudesCambio")
public class SolicitudesPendientesConductorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int idConductor = Integer.parseInt(request.getSession().getAttribute("idConductor").toString());
        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();
        List<SolicitudCambioTurno> solicitudes = dao.listarSolicitudesPorConductor(idConductor);

        request.setAttribute("solicitudes", solicitudes);
        request.getRequestDispatcher("solicitudes_cambio_conductor.jsp").forward(request, response);
    }
}
