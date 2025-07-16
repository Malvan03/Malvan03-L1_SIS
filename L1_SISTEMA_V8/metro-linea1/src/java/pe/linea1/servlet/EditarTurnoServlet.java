package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;
import pe.linea1.model.Turno;
import pe.linea1.model.Usuario;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;

public class EditarTurnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idTurno = Integer.parseInt(request.getParameter("idTurno"));
            Turno turno = new TurnoDAO().obtenerPorId(idTurno);
            request.setAttribute("turno", turno);
            request.getRequestDispatcher("editar_turno.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar turno: " + e.getMessage());
            request.getRequestDispatcher("ver_mis_turnos.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Turno t = new Turno();
            t.setIdTurno(Integer.parseInt(request.getParameter("idTurno")));
            t.setIdConductor(Integer.parseInt(request.getParameter("idConductor")));
            t.setIdSemana(request.getParameter("idSemana") == null || request.getParameter("idSemana").isEmpty() ? null : Integer.parseInt(request.getParameter("idSemana")));
            t.setDiaSemana(request.getParameter("diaSemana"));
            t.setHoraInicio(request.getParameter("horaInicio"));
            t.setHoraFin(request.getParameter("horaFin"));
            t.setCarreras(Integer.parseInt(request.getParameter("carreras")));
            t.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fecha")));
            t.setSaldoTiempo(Integer.parseInt(request.getParameter("saldoTiempo")));
            t.setTiempoLaborado(Integer.parseInt(request.getParameter("tiempoLaborado")));
            t.setTurnoAnterior(request.getParameter("turnoAnterior") == null || request.getParameter("turnoAnterior").isEmpty() ? null : Integer.parseInt(request.getParameter("turnoAnterior")));
            t.setObservaciones(request.getParameter("observaciones"));

            new TurnoDAO().actualizar(t);
            response.sendRedirect("VerTurnosServlet");
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar turno: " + e.getMessage());
            request.getRequestDispatcher("editar_turno.jsp").forward(request, response);
        }
    }
}
