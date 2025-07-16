package pe.linea1.servlet;

import pe.linea1.dao.*;
import pe.linea1.model.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class ProgramacionTurnosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null || !"ADMINISTRADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Filtros
        String idSemanaStr = request.getParameter("idSemana");
        String idConductorStr = request.getParameter("idConductor");
        Integer idSemana = (idSemanaStr != null && !idSemanaStr.isEmpty()) ? Integer.valueOf(idSemanaStr) : null;
        Integer idConductor = (idConductorStr != null && !idConductorStr.isEmpty()) ? Integer.valueOf(idConductorStr) : null;

        try {
            SemanaDAO semanaDAO = new SemanaDAO();
            ConductorDAO conductorDAO = new ConductorDAO();
            TurnoDAO turnoDAO = new TurnoDAO();

            // Listas para los combos/filtros
            List<Semana> semanas = semanaDAO.listarSemanas();
            // Usa listarActivos() o listarTodos() según tu lógica. Aquí se usa listarActivos.
            List<Conductor> conductores = conductorDAO.listarActivos();

            // Lista de turnos para la tabla, usando la vista TurnoView
            List<TurnoView> listaTurnos = turnoDAO.listarTurnos(idSemana, idConductor);

            request.setAttribute("semanas", semanas);
            request.setAttribute("conductores", conductores);
            request.setAttribute("listaTurnos", listaTurnos);

            request.getRequestDispatcher("programacion_turnos.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar la programación de turnos.");
            request.getRequestDispatcher("programacion_turnos.jsp").forward(request, response);
        }
    }
}