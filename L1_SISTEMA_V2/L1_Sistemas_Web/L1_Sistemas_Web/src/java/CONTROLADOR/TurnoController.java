package CONTROLADOR;

import DAO.TurnoDAO;
import MODELO.Turno;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TurnoController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TurnoDAO dao = new TurnoDAO();
        List<Turno> lista = dao.listarTurnos();
        request.setAttribute("turnos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }
}
