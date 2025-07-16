package pe.linea1.servlet;

import pe.linea1.dao.ConductorDAO;
import pe.linea1.dao.UsuarioDAO;
import pe.linea1.model.Conductor;
import pe.linea1.model.Usuario;
import pe.linea1.util.PasswordUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AgregarConductorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            // 1. Obtener datos del formulario
            String dni = request.getParameter("dni");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String contactoEmergencia = request.getParameter("contactoEmergencia");
            String fechaNacimientoStr = request.getParameter("fechaNacimiento");
            String fechaIngresoStr = request.getParameter("fechaIngreso");
            String modalidad = request.getParameter("modalidad");
            String base = request.getParameter("base");
            String observaciones = request.getParameter("observaciones");

            // 2. Parsear fechas
            java.util.Date fechaNacimiento = null, fechaIngreso = null;
            try {
                if (fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty()) {
                    fechaNacimiento = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimientoStr);
                }
                if (fechaIngresoStr != null && !fechaIngresoStr.isEmpty()) {
                    fechaIngreso = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(fechaIngresoStr);
                }
            } catch (Exception e) {}

            // 3. Crear el usuario y poner hash de clave
            Usuario usuario = new Usuario();
            usuario.setDni(dni);
            usuario.setNombres(nombres);
            usuario.setApellidos(apellidos);
            usuario.setCorreo(correo);
            usuario.setTelefono(telefono);
            usuario.setContactoEmergencia(contactoEmergencia);
            usuario.setFechaNacimiento(fechaNacimiento);
            usuario.setRol("CONDUCTOR");
            usuario.setEstado("ACTIVO");
            usuario.setContrasenaHash(PasswordUtils.hashPassword("12345678")); // Clave por defecto

            // 4. Insertar usuario y obtener su ID
            int idUsuario = new UsuarioDAO().insertar(usuario);

            // 5. Crear y registrar el conductor
            Conductor conductor = new Conductor();
            conductor.setIdUsuario(idUsuario);
            conductor.setDni(dni);
            conductor.setNombres(nombres);
            conductor.setApellidos(apellidos);
            conductor.setCorreo(correo);
            conductor.setTelefono(telefono);
            conductor.setModalidad(modalidad);
            conductor.setBase(base);
            conductor.setFechaIngreso(fechaIngreso);
            conductor.setHabilitado(true); // Por defecto
            conductor.setEstadoPersonal("ACTIVO");
            conductor.setObservaciones(observaciones);

            new ConductorDAO().insertar(conductor);

            // 6. Redireccionar con éxito
            response.sendRedirect("GestionConductoresServlet");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error al agregar conductor: " + ex.getMessage());
            request.getRequestDispatcher("agregar_conductor.jsp").forward(request, response);
        }
    }
}
