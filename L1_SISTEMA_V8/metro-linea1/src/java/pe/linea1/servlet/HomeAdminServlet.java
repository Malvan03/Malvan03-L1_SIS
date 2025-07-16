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

        // El rol debe ser exactamente como lo manejas en tu modelo, probablemente "ADMINISTRADOR"
        if (!"ADMINISTRADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("home_conductor.jsp");
            return;
        }

        // Nombre completo y foto para el header (ponlo en session para que todos los JSP lo puedan leer)
        session.setAttribute("nombre", usuario.getNombres() + " " +
            (usuario.getApellidoPaterno() != null ? usuario.getApellidoPaterno() : "") + " " +
            (usuario.getApellidoMaterno() != null ? usuario.getApellidoMaterno() : "")
        );
        session.setAttribute("foto",
            (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty())
                ? usuario.getFotoPerfil()
                : "default_avatar.png"
        );

        // Notificaciones no leídas
        NotificacionDAO notiDao = new NotificacionDAO();
        List<Notificacion> notificaciones = notiDao.getNotificacionesNoLeidas(usuario.getIdUsuario());
        request.setAttribute("notificaciones", notificaciones);
        request.setAttribute("notiCount", notificaciones != null ? notificaciones.size() : 0);

        // Fecha actual (para JSTL <fmt:formatDate>)
        request.setAttribute("now", new java.util.Date());

        request.getRequestDispatcher("home_admin.jsp").forward(request, response);
    }
}
