package pe.linea1.servlet;

import pe.linea1.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;

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

        // Pasa el nombre y la foto a la sesión (para el header, si quieres usar JSTL/EL)
        session.setAttribute("nombre", usuario.getNombres() + " " +
                                      (usuario.getApellidoPaterno() != null ? usuario.getApellidoPaterno() : "") + " " +
                                      (usuario.getApellidoMaterno() != null ? usuario.getApellidoMaterno() : ""));
        session.setAttribute("foto", (usuario.getFotoPerfil() != null && !usuario.getFotoPerfil().isEmpty())
                                        ? usuario.getFotoPerfil()
                                        : "default_avatar.png");

        // Pasa la fecha de hoy (para <fmt:formatDate value="${now}"/> en el JSP)
        request.setAttribute("now", new Date());

        // Puedes pasar notificaciones si tienes
        // request.setAttribute("notificaciones", listaNotificaciones);
        // request.setAttribute("notiCount", listaNotificaciones != null ? listaNotificaciones.size() : 0);

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
