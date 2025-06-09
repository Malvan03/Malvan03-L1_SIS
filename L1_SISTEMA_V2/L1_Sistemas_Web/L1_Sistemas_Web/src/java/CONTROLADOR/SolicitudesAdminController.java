package CONTROLADOR;

import DAO.SolicitudDAO;
import MODELO.Solicitud;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class SolicitudesAdminController extends HttpServlet {

    // Método doGet para mostrar todas las solicitudes pendientes
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar si el usuario es administrador
        String rol = (String) request.getSession().getAttribute("rol");
        if (rol == null || !"ADMIN".equals(rol)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Obtener todas las solicitudes pendientes
        SolicitudDAO dao = new SolicitudDAO();
        List<Solicitud> solicitudesPendientes = dao.listarSolicitudesPendientes();

        // Pasar las solicitudes pendientes al JSP
        request.setAttribute("solicitudes", solicitudesPendientes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ver_solicitudes.jsp");
        dispatcher.forward(request, response);
    }

    // Método doPost para aprobar o rechazar una solicitud
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar si el usuario es administrador
        String rol = (String) request.getSession().getAttribute("rol");
        if (rol == null || !"ADMIN".equals(rol)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Obtener la solicitud que se va a actualizar
        int idSolicitud = Integer.parseInt(request.getParameter("id_solicitud"));
        String accion = request.getParameter("accion"); // "SI" para aprobar o "NO" para rechazar

        // Actualizar el estado de la solicitud
        SolicitudDAO dao = new SolicitudDAO();
        dao.actualizarEstadoSolicitud(idSolicitud, accion);

        // Redirigir a la lista de solicitudes
        response.sendRedirect("ver_solicitudes.jsp");
    }
}
