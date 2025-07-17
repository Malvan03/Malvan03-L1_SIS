package pe.linea1.servlet;

import pe.linea1.dao.TurnoDAO;
import pe.linea1.model.Turno;
import pe.linea1.model.Usuario;
import pe.linea1.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/verTurnos")
public class VerTurnosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int idUsuario = usuario.getIdUsuario();

        // Obtener idConductor correspondiente al usuario
        int idConductor = -1;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id_conductor FROM CONDUCTOR WHERE id_usuario = ?")) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idConductor = rs.getInt("id_conductor");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Turno> listaTurnos;
        if (idConductor != -1) {
            TurnoDAO dao = new TurnoDAO();
            try {
                listaTurnos = dao.listarPorConductor(idConductor);
            } catch (Exception e) {
                listaTurnos = Collections.emptyList();
            }
        } else {
            listaTurnos = Collections.emptyList();
        }

        request.setAttribute("misTurnos", listaTurnos);
        request.getRequestDispatcher("ver_mis_turnos.jsp").forward(request, response);
    }
}