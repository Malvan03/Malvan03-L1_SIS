package pe.linea1.servlet;

import pe.linea1.dao.UsuarioDAO;
import pe.linea1.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class PerfilServlet extends HttpServlet {

    private String getFileName(Part part) {
        return Paths.get(part.getSubmittedFileName()).getFileName().toString();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("editar_perfil.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String accion = req.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();
        boolean exito = false;
        String mensaje = "";

        try {
            if ("actualizarPerfil".equals(accion)) {
                // Actualizar datos de perfil
                String correo = req.getParameter("correo");
                String telefono = req.getParameter("telefono");
                String emergencia = req.getParameter("emergencia");
                String nacimiento = req.getParameter("nacimiento");

                usuario.setCorreo(correo);
                usuario.setTelefono(telefono);
                usuario.setContactoEmergencia(emergencia);
                if (nacimiento != null && !nacimiento.isEmpty()) {
                    usuario.setFechaNacimiento(java.sql.Date.valueOf(nacimiento));
                }
                dao.actualizar(usuario);

                session.setAttribute("usuario", usuario);
                exito = true;
                mensaje = "Perfil actualizado correctamente.";
            }

            if ("cambiarContrasena".equals(accion)) {
                String actual = req.getParameter("actual");
                String nueva = req.getParameter("nueva");
                String repetir = req.getParameter("repetir");

                Usuario uBD = dao.buscarPorDni(usuario.getDni());
                if (!BCrypt.checkpw(actual, uBD.getContrasenaHash())) {
                    mensaje = "La contraseña actual es incorrecta.";
                } else if (!nueva.equals(repetir)) {
                    mensaje = "Las contraseñas nuevas no coinciden.";
                } else if (nueva.length() < 6) {
                    mensaje = "La nueva contraseña debe tener al menos 6 caracteres.";
                } else {
                    String hash = BCrypt.hashpw(nueva, BCrypt.gensalt());
                    dao.actualizarPassword(usuario.getId(), hash);
                    usuario.setContrasenaHash(hash);
                    session.setAttribute("usuario", usuario);
                    exito = true;
                    mensaje = "Contraseña cambiada correctamente.";
                }
            }

            if ("actualizarFoto".equals(accion)) {
                Part fotoPart = req.getPart("nuevaFoto");
                if (fotoPart != null && fotoPart.getSize() > 0) {
                    String ext = getFileName(fotoPart).contains(".") ?
                            getFileName(fotoPart).substring(getFileName(fotoPart).lastIndexOf('.')) : ".png";
                    String nombreArchivo = "foto_" + usuario.getDni() + "_" + System.currentTimeMillis() + ext;

                    String imagesPath = getServletContext().getRealPath("/images/");
                    File imagesDir = new File(imagesPath);
                    if (!imagesDir.exists()) imagesDir.mkdirs();

                    String rutaFinal = imagesPath + File.separator + nombreArchivo;
                    fotoPart.write(rutaFinal);

                    usuario.setFotoPerfil(nombreArchivo);
                    dao.actualizarFoto(usuario.getId(), nombreArchivo);
                    session.setAttribute("usuario", usuario);
                    exito = true;
                    mensaje = "Foto actualizada correctamente.";
                } else {
                    mensaje = "Selecciona un archivo de imagen válido.";
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            mensaje = "Ocurrió un error: " + ex.getMessage();
        }

        req.setAttribute("mensaje", mensaje);
        req.setAttribute("exito", exito);
        req.getRequestDispatcher("editar_perfil.jsp").forward(req, resp);
    }
}
