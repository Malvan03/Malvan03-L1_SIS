package pe.linea1.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import pe.linea1.dao.NotificacionDAO;
import pe.linea1.model.Notificacion;
import pe.linea1.model.Usuario;

@WebServlet("/homeAdmin")
public class HomeAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!"ADMIN".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("home_conductor.jsp");
            return;
        }
        // Datos de bienvenida usando los getters correctos
        request.setAttribute("nombre", usuario.getNombres() + " " + usuario.getApellidos());
        request.setAttribute("foto", usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty() ? usuario.getFotoPerfil() : "LOGOL1.png");

        // Notificaciones no leídas
        NotificacionDAO notiDao = new NotificacionDAO();
        List<Notificacion> notificaciones = notiDao.getNotificacionesNoLeidas(usuario.getId());
        request.setAttribute("notificaciones", notificaciones);
        request.setAttribute("notiCount", notificaciones.size());

        // Fecha actual
        request.setAttribute("fechaHoy", java.time.LocalDate.now().toString());

        request.getRequestDispatcher("home_admin.jsp").forward(request, response);
    }
}