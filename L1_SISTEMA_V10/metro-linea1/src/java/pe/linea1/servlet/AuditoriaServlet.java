package pe.linea1.servlet;

import pe.linea1.dao.AuditoriaDAO;
import pe.linea1.model.Auditoria;
import pe.linea1.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class AuditoriaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            AuditoriaDAO auditoriaDAO = new AuditoriaDAO();
            // Filtros
            String idUsuario = req.getParameter("idUsuario");
            String tipoAccion = req.getParameter("tipoAccion");
            String fechaInicio = req.getParameter("fechaInicio");
            String fechaFin = req.getParameter("fechaFin");
            String export = req.getParameter("export");

            // Listas para filtros
            List<Usuario> usuarios = auditoriaDAO.listarUsuariosParaFiltro();
            List<String> tiposAccion = auditoriaDAO.listarTiposAccion();

            // Lista de auditorías según filtros
            List<Auditoria> auditorias = auditoriaDAO.buscarAuditoria(idUsuario, tipoAccion, fechaInicio, fechaFin);

            req.setAttribute("usuarios", usuarios);
            req.setAttribute("tiposAccion", tiposAccion);
            req.setAttribute("auditorias", auditorias);

            // Para reconstruir queryString al exportar
            StringBuilder sb = new StringBuilder();
            Enumeration<String> params = req.getParameterNames();
            while (params.hasMoreElements()) {
                String p = params.nextElement();
                if (!"export".equals(p)) sb.append(p).append("=").append(req.getParameter(p)).append("&");
            }
            req.setAttribute("queryString", sb.toString());

            // Lógica de exportación (PDF/Excel) aquí si implementas...
            if ("excel".equals(export)) {
                // Implementa exportación a Excel aquí
                return;
            } else if ("pdf".equals(export)) {
                // Implementa exportación a PDF aquí
                return;
            }

            req.getRequestDispatcher("auditoria.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error al cargar el historial de auditoría.");
            req.getRequestDispatcher("auditoria.jsp").forward(req, resp);
        }
    }
}