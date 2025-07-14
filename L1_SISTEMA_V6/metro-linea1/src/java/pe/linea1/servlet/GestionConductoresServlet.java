package pe.linea1.servlet;

import pe.linea1.dao.ConductorDAO;
import pe.linea1.model.Conductor;
import pe.linea1.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class GestionConductoresServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recupera la sesión sin crear una nueva
            HttpSession session = request.getSession(false);

            // Si no hay sesión o usuario, redirige a login
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Usuario usuario = (Usuario) session.getAttribute("usuario");

            // Parámetros de búsqueda
            String dni = request.getParameter("dni");
            String modalidad = request.getParameter("modalidad");
            String estado = request.getParameter("estado");
            String fechaIngresoStr = request.getParameter("fechaIngreso");
            java.sql.Date fechaIngreso = null;

            // Convierte la fecha si existe
            if (fechaIngresoStr != null && !fechaIngresoStr.trim().isEmpty()) {
                try {
                    fechaIngreso = java.sql.Date.valueOf(fechaIngresoStr);
                } catch (Exception e) {
                    System.out.println("Error al parsear fecha: " + e.getMessage());
                }
            }

            // Determina si hay filtros
            boolean hayFiltros = (dni != null && !dni.trim().isEmpty()) ||
                                 (modalidad != null && !modalidad.trim().isEmpty()) ||
                                 (estado != null && !estado.trim().isEmpty()) ||
                                 fechaIngreso != null;

            List<Conductor> lista;

            ConductorDAO conductorDAO = new ConductorDAO();
            try {
                if (hayFiltros) {
                    lista = conductorDAO.buscarConductores(dni, modalidad, estado, fechaIngreso);
                } else {
                    lista = conductorDAO.listarTodos();
                }
            } catch (Exception e) {
                e.printStackTrace();
                lista = new ArrayList<>();
                request.setAttribute("error", "Error en la búsqueda: " + e.getMessage());
            }

            if (lista == null) lista = new ArrayList<>();

            // Setea atributos para mostrar en el JSP
            request.setAttribute("listaConductores", lista);
            request.setAttribute("dni", dni);
            request.setAttribute("modalidad", modalidad);
            request.setAttribute("estado", estado);
            request.setAttribute("fechaIngreso", fechaIngresoStr);

            // Redirecciona a la vista
            request.getRequestDispatcher("gestion_conductores.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error en el servidor: " + ex.getMessage());
            request.setAttribute("listaConductores", new ArrayList<>());
            request.getRequestDispatcher("gestion_conductores.jsp").forward(request, response);
        }
    }
}
