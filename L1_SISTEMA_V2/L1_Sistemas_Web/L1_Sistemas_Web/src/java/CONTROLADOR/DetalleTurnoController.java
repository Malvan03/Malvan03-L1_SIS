package CONTROLADOR;

import DAO.AsignacionDAO;
import MODELO.Asignacion;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class DetalleTurnoController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTurno = Integer.parseInt(request.getParameter("id_turno"));
        int idConductor = (Integer) request.getSession().getAttribute("id_conductor");

        AsignacionDAO dao = new AsignacionDAO();
        List<Asignacion> lista = dao.getTurnosPorConductor(idConductor);
        Asignacion encontrado = null;

        for (Asignacion a : lista) {
            if (a.getIdTurno() == idTurno) {
                encontrado = a;
                break;
            }
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (encontrado != null) {
            Gson gson = new Gson();
            out.print(gson.toJson(encontrado));
        } else {
            out.print("{}");
        }
    }
}
