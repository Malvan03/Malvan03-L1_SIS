package CONTROLADOR;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class CerrarSesionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // evita error si no hay sesión
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
