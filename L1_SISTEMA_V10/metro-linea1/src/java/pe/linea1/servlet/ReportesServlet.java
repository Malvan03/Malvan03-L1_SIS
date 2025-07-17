package pe.linea1.servlet;

import pe.linea1.dao.ConductorDAO;
import pe.linea1.dao.ReportesDAO;
import pe.linea1.model.Conductor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class ReportesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ConductorDAO conductorDAO = new ConductorDAO();
            List<Conductor> conductores = conductorDAO.listarActivos();
            req.setAttribute("conductores", conductores);

            String tipoReporte = req.getParameter("tipoReporte");
            String fechaInicio = req.getParameter("fechaInicio");
            String fechaFin = req.getParameter("fechaFin");
            String idConductor = req.getParameter("idConductor");
            String export = req.getParameter("export");

            // Solo si se filtra o exporta
            if (tipoReporte != null && !tipoReporte.isEmpty()) {
                ReportesDAO dao = new ReportesDAO();
                List<String> cabecera = dao.obtenerCabecera(tipoReporte);
                List<List<String>> datos = dao.generarReporte(tipoReporte, fechaInicio, fechaFin, idConductor);

                req.setAttribute("reporteCabecera", cabecera);
                req.setAttribute("reporteGenerado", datos);

                // Exportar (placeholder, deberás implementar lógica real)
                if ("excel".equals(export)) {
                    // Genera Excel y responde...
                    return;
                } else if ("pdf".equals(export)) {
                    // Genera PDF y responde...
                    return;
                }
            }

            // Para reconstruir la queryString si exporta
            StringBuilder sb = new StringBuilder();
            Enumeration<String> params = req.getParameterNames();
            while(params.hasMoreElements()) {
                String p = params.nextElement();
                if (!p.equals("export")) sb.append(p).append("=").append(req.getParameter(p)).append("&");
            }
            req.setAttribute("queryString", sb.toString());

            req.getRequestDispatcher("reportes_externos.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Ocurrió un error al generar el reporte.");
            req.getRequestDispatcher("reportes_externos.jsp").forward(req, resp);
        }
    }
}