package pe.linea1.servlet;

import pe.linea1.dao.SolicitudCambioTurnoDAO;
import pe.linea1.model.SolicitudCambioTurno;
import pe.linea1.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class HistorialCambiosConductorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null || !"CONDUCTOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }
        int idConductor = usuario.getIdConductor();
        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();

        // Solo trae los cambios donde ya fueron aceptados o rechazados
        List<SolicitudCambioTurno> historial = dao.listarHistorialPorConductor(idConductor);

        request.setAttribute("historial", historial);
        request.getRequestDispatcher("historial_cambios_conductor.jsp").forward(request, response);
    }
}
