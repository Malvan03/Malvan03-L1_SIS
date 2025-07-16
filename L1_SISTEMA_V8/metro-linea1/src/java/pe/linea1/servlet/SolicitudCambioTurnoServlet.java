package pe.linea1.servlet;

import pe.linea1.dao.SolicitudCambioTurnoDAO;
import pe.linea1.model.SolicitudCambioTurno;
import pe.linea1.model.Usuario;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SolicitudCambioTurnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Control de sesión/admin
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null || !"ADMINISTRADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();

        try {
            if ("pendientes".equals(accion)) {
                List<SolicitudCambioTurno> lista = dao.listarSolicitudesPendientesAdmin();
                // (Opcional) Completa aquí los nombres de solicitante y descripción de turnos si lo tienes en tu DAO/modelo.
                request.setAttribute("listaSolicitudes", lista);
                request.getRequestDispatcher("solicitudes_cambio_admin.jsp").forward(request, response);

            } else if ("ver".equals(accion)) {
                int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
                SolicitudCambioTurno solicitud = dao.obtenerPorIdBasico(idSolicitud); // Implementa esto para traer detalles
                request.setAttribute("solicitud", solicitud);
                request.getRequestDispatcher("detalle_solicitud_cambio.jsp").forward(request, response);

            } else if ("aprobarAdmin".equals(accion) || "rechazarAdmin".equals(accion)) {
                int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
                String nuevoEstado = accion.equals("aprobarAdmin") ? "ACEPTADO" : "RECHAZADO";
                String observaciones = request.getParameter("observaciones") != null ? request.getParameter("observaciones") : "";
                int idAdmin = usuario.getIdUsuario();
                dao.actualizarEstado(idSolicitud, "ADMIN", nuevoEstado, idAdmin, observaciones);
                response.sendRedirect("SolicitudCambioTurnoServlet?accion=pendientes");
            }
            // Puedes agregar más acciones como aprobar/rechazar compañero si lo necesitas
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Solo permitimos crear solicitudes desde conductor, pero puedes agregar validación si quieres
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();
        try {
            SolicitudCambioTurno s = new SolicitudCambioTurno();
            s.setFechaCambio(java.sql.Date.valueOf(request.getParameter("fecha_cambio")));
            s.setIdConductorSolicitante(usuario.getIdConductor()); // Usa el objeto usuario
            s.setIdTurnoOriginal(Integer.parseInt(request.getParameter("idTurnoOriginal")));
            s.setIdConductorDestino(Integer.parseInt(request.getParameter("idConductorDestino")));
            s.setIdTurnoNuevo(Integer.parseInt(request.getParameter("idTurnoNuevo")));
            s.setMensaje(request.getParameter("mensaje"));

            boolean exito = dao.crearSolicitud(s);
            if (exito) {
                response.sendRedirect("SolicitudCambioTurnoServlet?accion=pendientes");
            } else {
                request.setAttribute("error", "No se pudo registrar la solicitud.");
                request.getRequestDispatcher("gestionar_cambio.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
