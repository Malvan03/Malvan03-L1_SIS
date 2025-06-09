package CONTROLADOR;

import DAO.AsignacionDAO;
import MODELO.Asignacion;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class MisTurnosController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer idConductor = (Integer) session.getAttribute("id_conductor");

        if (idConductor == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        AsignacionDAO dao = new AsignacionDAO();
        List<Asignacion> turnos = dao.getTurnosPorConductor(idConductor);

        request.setAttribute("misTurnos", turnos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("mis_turnos.jsp");
        dispatcher.forward(request, response);
    }
}
