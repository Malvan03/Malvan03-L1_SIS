package pe.linea1.servlet;

import pe.linea1.dao.NotificacionDAO;
import pe.linea1.model.Notificacion;
import pe.linea1.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class NotificacionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Usa el método correcto, revisa tu modelo
        int idUsuario;
        try {
            // Si tu modelo es así, usa uno u otro:
            // idUsuario = usuario.getIdUsuario(); // Descomenta si tienes getIdUsuario()
            idUsuario = usuario.getId();           // O este si tienes getId()
        } catch (Exception e) {
            // Si hay error, mejor regresa a login
            response.sendRedirect("login.jsp");
            return;
        }

        NotificacionDAO dao = new NotificacionDAO();
        String accion = request.getParameter("accion");
        if ("leer".equals(accion)) {
            int idNoti = Integer.parseInt(request.getParameter("id"));
            dao.marcarComoLeida(idNoti);
            response.sendRedirect("NotificacionServlet"); // Debe coincidir con tu mapping
            return;
        }

        List<Notificacion> lista = dao.listarPorUsuario(idUsuario);
        int noLeidas = dao.contarNoLeidas(idUsuario);

        request.setAttribute("notificaciones", lista);
        request.setAttribute("noLeidas", noLeidas);

        request.getRequestDispatcher("notificaciones.jsp").forward(request, response);
    }
}
