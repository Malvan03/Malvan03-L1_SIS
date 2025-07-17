package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;
import pe.linea1.model.Turno;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;

public class EditarTurnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Acepta el parámetro 'id' desde el botón de editar
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("No se proporcionó el ID del turno.");
            }
            int idTurno = Integer.parseInt(idParam);
            Turno turno = new TurnoDAO().obtenerPorId(idTurno);
            if (turno == null) {
                throw new Exception("No se encontró el turno con ID: " + idTurno);
            }
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
            // idSemana puede ser null
            String idSemanaParam = request.getParameter("idSemana");
            t.setIdSemana((idSemanaParam == null || idSemanaParam.isEmpty()) ? null : Integer.parseInt(idSemanaParam));
            t.setDiaSemana(request.getParameter("diaSemana"));
            t.setHoraInicio(request.getParameter("horaInicio"));
            t.setHoraFin(request.getParameter("horaFin"));
            t.setCarreras(Integer.parseInt(request.getParameter("carreras")));
            t.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fecha")));
            // saldoTiempo puede ser null
            String saldoTiempoParam = request.getParameter("saldoTiempo");
            t.setSaldoTiempo((saldoTiempoParam == null || saldoTiempoParam.isEmpty()) ? null : Integer.parseInt(saldoTiempoParam));
            // tiempoLaborado puede ser null
            String tiempoLaboradoParam = request.getParameter("tiempoLaborado");
            t.setTiempoLaborado((tiempoLaboradoParam == null || tiempoLaboradoParam.isEmpty()) ? null : Integer.parseInt(tiempoLaboradoParam));
            // turnoAnterior puede ser null
            String turnoAnteriorParam = request.getParameter("turnoAnterior");
            t.setTurnoAnterior((turnoAnteriorParam == null || turnoAnteriorParam.isEmpty()) ? null : Integer.parseInt(turnoAnteriorParam));
            t.setObservaciones(request.getParameter("observaciones"));

            new TurnoDAO().actualizar(t);
            response.sendRedirect("VerTurnosServlet");
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar turno: " + e.getMessage());
            request.getRequestDispatcher("editar_turno.jsp").forward(request, response);
        }
    }
}