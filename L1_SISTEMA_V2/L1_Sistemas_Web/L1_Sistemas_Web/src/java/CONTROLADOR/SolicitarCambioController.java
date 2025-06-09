package CONTROLADOR;

import DAO.SolicitudDAO;
import MODELO.Solicitud;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

public class SolicitarCambioController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer idConductor = (Integer) session.getAttribute("id_conductor");

        if (idConductor == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Solicitud s = new Solicitud();
            s.setFechaTurno(Date.valueOf(request.getParameter("fecha_turno")));
            s.setIdSolicitante(idConductor);
            s.setIdAsignacionOriginal(Integer.parseInt(request.getParameter("id_asignacion_original")));
            s.setIdAsignacionSolicitada(Integer.parseInt(request.getParameter("id_asignacion_solicitada")));
            s.setObservacion(request.getParameter("observacion"));
            s.setEstadoReceptor("PENDIENTE");
            s.setEstadoAdmin("PENDIENTE");

            SolicitudDAO dao = new SolicitudDAO();
            dao.insertar(s);

            response.sendRedirect("estado_solicitudes.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Error al enviar la solicitud: " + e.getMessage());
            request.getRequestDispatcher("solicitar_cambio.jsp").forward(request, response);
        }
    }
}
