package pe.linea1.servlet;

import pe.linea1.dao.ConductorDAO;
import pe.linea1.model.Conductor;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

//@WebServlet("/EditarConductorServlet")
public class EditarConductorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Conductor conductor = new ConductorDAO().obtenerPorId(id);
            request.setAttribute("conductor", conductor);
            request.getRequestDispatcher("editar_conductor.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            Conductor conductor = new Conductor();
            conductor.setIdConductor(Integer.parseInt(request.getParameter("idConductor")));
            conductor.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            conductor.setModalidad(request.getParameter("modalidad"));
            conductor.setBase(request.getParameter("base"));

            // Conversión CORRECTA de String a Date
            String fechaIngresoStr = request.getParameter("fechaIngreso");
            java.util.Date fechaIngreso = null;
            if (fechaIngresoStr != null && !fechaIngresoStr.isEmpty()) {
                try {
                    fechaIngreso = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(fechaIngresoStr);
                } catch (Exception e) {
                    fechaIngreso = null;
                }
            }
            conductor.setFechaIngreso(fechaIngreso);

            conductor.setHabilitado(Boolean.parseBoolean(request.getParameter("habilitado")));
            conductor.setEstadoPersonal(request.getParameter("estadoPersonal"));
            conductor.setObservaciones(request.getParameter("observaciones"));

            new ConductorDAO().actualizar(conductor);

            response.sendRedirect("GestionConductoresServlet");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}