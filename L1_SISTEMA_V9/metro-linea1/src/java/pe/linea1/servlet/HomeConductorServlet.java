package pe.linea1.servlet;

import pe.linea1.model.Usuario;
import pe.linea1.model.Notificacion;
import pe.linea1.dao.NotificacionDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class HomeConductorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Control de sesión y usuario logueado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!"CONDUCTOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.jsp?error=tipo");
            return;
        }

        // Nombre y foto en sesión para el header
        session.setAttribute("nombre", usuario.getNombres() + " " +
                (usuario.getApellidoPaterno() != null ? usuario.getApellidoPaterno() : "") + " " +
                (usuario.getApellidoMaterno() != null ? usuario.getApellidoMaterno() : ""));
        session.setAttribute("foto", (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty())
                ? usuario.getFotoPerfil()
                : "default_avatar.png");

        // Fecha de hoy (para <fmt:formatDate value="${now}"/> en el JSP)
        request.setAttribute("now", new Date());

        // Notificaciones (las últimas 4)
        NotificacionDAO notiDao = new NotificacionDAO();
        List<Notificacion> notificaciones = notiDao.listarUltimasPorUsuario(usuario.getIdUsuario(), 4);
        int notiCount = notiDao.contarNoLeidas(usuario.getIdUsuario());
        request.setAttribute("notificaciones", notificaciones);
        request.setAttribute("notiCount", notiCount);

        request.getRequestDispatcher("home_conductor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que muestra el panel de conductor";
    }
}
