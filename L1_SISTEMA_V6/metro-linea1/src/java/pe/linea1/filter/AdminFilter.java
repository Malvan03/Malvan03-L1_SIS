package pe.linea1.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import pe.linea1.model.Usuario;

@WebFilter({
    "/GestionConductoresServlet",
    "/ProgramacionTurnosServlet",
    "/SolicitudCambioAdminServlet",
    "/AuditoriaServlet",
    "/ReportesServlet",
    "/homeAdmin"
})
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        // Acepta "ADMIN" o "ADMINISTRADOR" como rol válido
        if (usuario == null || 
            !( "ADMIN".equalsIgnoreCase(usuario.getRol()) || "ADMINISTRADOR".equalsIgnoreCase(usuario.getRol()) ) ) {
            response.sendRedirect("login.jsp");
        } else {
            chain.doFilter(req, res);
        }
    }
}
