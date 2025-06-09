package CONTROLADOR;

import DAO.SolicitudDAO;
import MODELO.Solicitud;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class EstadoSolicitudesController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer idConductor = (Integer) session.getAttribute("id_conductor");

        if (idConductor == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        SolicitudDAO dao = new SolicitudDAO();
        List<Solicitud> lista = dao.getPorConductor(idConductor);

        request.setAttribute("solicitudes", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("estado_solicitudes.jsp");
        dispatcher.forward(request, response);
    }
}
