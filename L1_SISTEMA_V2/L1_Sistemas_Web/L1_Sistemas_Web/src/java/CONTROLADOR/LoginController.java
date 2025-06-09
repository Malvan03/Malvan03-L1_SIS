package CONTROLADOR;

import DAO.Conexion;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Asegúrate que tu tabla Usuarios tenga el campo id_conductor
        String sql = "SELECT id_conductor, rol FROM Usuarios WHERE usuario = ? AND contrasena_hash = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario);
            ps.setString(2, contrasena); // Si usas hash, aplica aquí
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String rol = rs.getString("rol");
                int idConductor = rs.getInt("id_conductor"); // puede ser null si ADMIN

                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("rol", rol);

                // Solo guardar id_conductor si el rol es CONDUCTOR
                if ("CONDUCTOR".equals(rol)) {
                    session.setAttribute("id_conductor", idConductor);  // Guardamos el id_conductor
                    response.sendRedirect("home_conductor.jsp");
                } else {
                    response.sendRedirect("home_admin.jsp");
                }

            } else {
                request.setAttribute("error", "Credenciales incorrectas");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error en la base de datos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
