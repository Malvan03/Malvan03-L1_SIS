package pe.linea1.servlet;

import pe.linea1.dao.SolicitudCambioTurnoDAO;
import pe.linea1.model.SolicitudCambioTurno;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.Date;

@WebServlet("/conductor/gestionarCambio")
public class GestionarCambioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int idConductorSolicitante = Integer.parseInt(request.getParameter("idConductorSolicitante"));
        int idTurnoOriginal = Integer.parseInt(request.getParameter("idTurnoOriginal"));
        int idConductorDestino = Integer.parseInt(request.getParameter("idConductorDestino"));
        int idTurnoNuevo = Integer.parseInt(request.getParameter("idTurnoNuevo"));
        String mensaje = request.getParameter("mensaje");

        // Aquí irían tus validaciones (horas sueño, etc) → resultado TRUE/FALSE
        boolean validacionHorasSueno = true;
        boolean validacionCoincidencia = true;
        boolean validacionSaldoTiempo = true;

        SolicitudCambioTurno solicitud = new SolicitudCambioTurno();
        solicitud.setFechaCambio(new Date());
        solicitud.setIdConductorSolicitante(idConductorSolicitante);
        solicitud.setIdTurnoOriginal(idTurnoOriginal);
        solicitud.setIdConductorDestino(idConductorDestino);
        solicitud.setIdTurnoNuevo(idTurnoNuevo);
        solicitud.setMensaje(mensaje);
        solicitud.setValidacionHorasSueno(validacionHorasSueno);
        solicitud.setValidacionCoincidencia(validacionCoincidencia);
        solicitud.setValidacionSaldoTiempo(validacionSaldoTiempo);

        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();
        boolean exito = dao.crearSolicitud(solicitud);

        if (exito) {
            // Aquí puedes disparar una notificación a idConductorDestino
            response.sendRedirect("solicitudes_cambio_conductor.jsp?exito=1");
        } else {
            request.setAttribute("error", "No se pudo crear la solicitud.");
            request.getRequestDispatcher("gestionar_cambio.jsp").forward(request, response);
        }
    }
}
