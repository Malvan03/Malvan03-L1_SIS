package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;
import pe.linea1.model.Turno;
import pe.linea1.model.Usuario;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;

public class AgregarTurnoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Turno t = new Turno();
            t.setIdConductor(usuario.getIdUsuario());
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

            new TurnoDAO().insertar(t);
            response.sendRedirect("VerTurnosServlet");
        } catch (Exception e) {
            request.setAttribute("error", "Error al agregar turno: " + e.getMessage());
            request.getRequestDispatcher("agregar_turno.jsp").forward(request, response);
        }
    }
}
