package pe.linea1.servlet;

import pe.linea1.dao.UsuarioDAO;
import pe.linea1.model.Usuario;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String dni = req.getParameter("usuario");
        String password = req.getParameter("password");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario user = usuarioDAO.validarUsuario(dni, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("usuario", user);
            if ("ADMINISTRADOR".equalsIgnoreCase(user.getRol())) {
                resp.sendRedirect("home_admin.jsp");
            } else if ("CONDUCTOR".equalsIgnoreCase(user.getRol())) {
                resp.sendRedirect("home_conductor.jsp");
            } else {
                resp.sendRedirect("login.jsp?error=tipo");
            }
        } else {
            // Detectar si usuario está bloqueado temporalmente
            if (usuarioDAO.estaBloqueado(dni)) {
                resp.sendRedirect("login.jsp?error=bloqueado");
            } else {
                resp.sendRedirect("login.jsp?error=datos");
            }
        }
    }
}
