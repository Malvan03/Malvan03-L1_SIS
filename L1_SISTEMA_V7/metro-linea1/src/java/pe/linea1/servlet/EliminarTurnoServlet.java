package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EliminarTurnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idTurno = Integer.parseInt(request.getParameter("idTurno"));
            new TurnoDAO().eliminar(idTurno);
            response.sendRedirect("VerTurnosServlet");
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar turno: " + e.getMessage());
            request.getRequestDispatcher("ver_mis_turnos.jsp").forward(request, response);
        }
    }
}
