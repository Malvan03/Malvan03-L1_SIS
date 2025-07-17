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
        if (accion == null) accion = "pendientes";
        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();

        try {
            switch (accion) {
                case "pendientes":
                    // Solicitudes pendientes
                    List<SolicitudCambioTurno> listaPendientes = dao.listarSolicitudesPendientesAdmin();
                    // Historial (todas menos pendientes)
                    List<SolicitudCambioTurno> listaHistorial = dao.listarSolicitudesHistorialAdmin(null, null, null);
                    request.setAttribute("listaPendientes", listaPendientes);
                    request.setAttribute("listaHistorial", listaHistorial);
                    request.getRequestDispatcher("solicitudes_cambio_admin.jsp").forward(request, response);
                    break;

                case "historial":
                    // Filtros: estado, desde, hasta
                    String estado = request.getParameter("estado");
                    String desde = request.getParameter("desde");
                    String hasta = request.getParameter("hasta");
                    List<SolicitudCambioTurno> historial = dao.listarSolicitudesHistorialAdmin(estado, desde, hasta);
                    request.setAttribute("listaPendientes", dao.listarSolicitudesPendientesAdmin());
                    request.setAttribute("listaHistorial", historial);
                    request.setAttribute("estadoFiltro", estado);
                    request.setAttribute("desdeFiltro", desde);
                    request.setAttribute("hastaFiltro", hasta);
                    request.getRequestDispatcher("solicitudes_cambio_admin.jsp").forward(request, response);
                    break;

                case "ver":
                    int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
                    SolicitudCambioTurno solicitud = dao.obtenerPorIdBasico(idSolicitud);
                    request.setAttribute("solicitud", solicitud);
                    request.getRequestDispatcher("detalle_solicitud_cambio.jsp").forward(request, response);
                    break;

                case "aprobarAdmin":
                case "rechazarAdmin":
                    int idSol = Integer.parseInt(request.getParameter("idSolicitud"));
                    String nuevoEstado = accion.equals("aprobarAdmin") ? "ACEPTADO" : "RECHAZADO";
                    String observaciones = request.getParameter("observaciones") != null ? request.getParameter("observaciones") : "";
                    int idAdmin = usuario.getIdUsuario();
                    dao.actualizarEstado(idSol, "ADMIN", nuevoEstado, idAdmin, observaciones);
                    response.sendRedirect("SolicitudCambioTurnoServlet?accion=pendientes");
                    break;

                default:
                    // Redirección por defecto
                    response.sendRedirect("solicitudes_cambio_admin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Registro de solicitud (usualmente solo conductor)
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        SolicitudCambioTurnoDAO dao = new SolicitudCambioTurnoDAO();
        try {
            SolicitudCambioTurno s = new SolicitudCambioTurno();
            s.setFechaCambio(java.sql.Date.valueOf(request.getParameter("fechaCambio")));
            // Aquí puedes necesitar ajustar si tu Usuario tiene getIdConductor()
            s.setIdConductorSolicitante(usuario.getIdUsuario()); // O tu método real para obtener el ID de conductor
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
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
