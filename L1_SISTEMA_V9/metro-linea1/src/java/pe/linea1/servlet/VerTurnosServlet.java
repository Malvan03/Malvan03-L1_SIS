package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;
import pe.linea1.model.Turno;
import pe.linea1.model.Usuario;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class VerTurnosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int idConductor = usuario.getIdUsuario(); // Cambia por getIdConductor() si tienes ese campo

        try {
            TurnoDAO dao = new TurnoDAO();
            List<Turno> lista = dao.listarPorConductor(idConductor);
            request.setAttribute("listaTurnos", lista);
            request.getRequestDispatcher("ver_mis_turnos.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al listar turnos: " + e.getMessage());
            request.getRequestDispatcher("ver_mis_turnos.jsp").forward(request, response);
        }
    }
}
