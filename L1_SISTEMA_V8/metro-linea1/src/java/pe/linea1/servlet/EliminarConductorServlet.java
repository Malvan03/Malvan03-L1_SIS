package pe.linea1.servlet;

import pe.linea1.dao.ConductorDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EliminarConductorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            new ConductorDAO().inhabilitar(id); // método que solo cambia estado a INACTIVO/CESADO
            response.sendRedirect("GestionConductoresServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("GestionConductoresServlet");
        }
    }
}