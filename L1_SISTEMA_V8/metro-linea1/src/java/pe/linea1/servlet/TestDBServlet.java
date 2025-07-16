package pe.linea1.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Enumeration; // Agregado este import que faltaba
import pe.linea1.model.Usuario;

public class TestDBServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test de Sesión</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
        out.println("h2 { color: #3a5a78; }");
        out.println("p { margin: 10px 0; }");
        out.println("pre { background-color: #f5f5f5; padding: 10px; border-radius: 5px; }");
        out.println("button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }");
        out.println("button:hover { background-color: #45a049; }");
        out.println("a { display: inline-block; margin-top: 20px; color: #3a5a78; text-decoration: none; }");
        out.println("a:hover { text-decoration: underline; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        out.println("<h2>Diagnóstico de Sesión</h2>");
        
        HttpSession session = request.getSession(false);
        
        out.println("<p><strong>ID de sesión:</strong> " + (session != null ? session.getId() : "Sin sesión") + "</p>");
        
        if (session != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            out.println("<p><strong>Usuario en sesión:</strong> " + (usuario != null ? usuario.getNombres() + " " + usuario.getApellidoPaterno() + " (Rol: " + usuario.getRol() + ")" : "No hay usuario en sesión") + "</p>");
            
            out.println("<h3>Todos los atributos de sesión:</h3>");
            out.println("<pre>");
            Enumeration<String> atributos = session.getAttributeNames();
            while (atributos.hasMoreElements()) {
                String nombre = atributos.nextElement();
                out.println(nombre + " = " + session.getAttribute(nombre));
            }
            out.println("</pre>");
        } else {
            out.println("<p><strong>No hay sesión activa</strong></p>");
        }
        
        out.println("<h3>Crear usuario de prueba en sesión:</h3>");
        out.println("<form method='post' action='TestDBServlet'>");
        out.println("<button type='submit'>Crear Usuario de Prueba</button>");
        out.println("</form>");
        
        out.println("<p><a href='GestionConductoresServlet'>Ir a Gestión de Conductores</a></p>");
        
        out.println("<h3>Información de Request:</h3>");
        out.println("<pre>");
        out.println("Método: " + request.getMethod());
        out.println("URL: " + request.getRequestURL());
        out.println("Query String: " + request.getQueryString());
        out.println("</pre>");
        
        out.println("<h3>Encabezados del Request:</h3>");
        out.println("<pre>");
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String headerName = headerNames.nextElement();
            out.println(headerName + ": " + request.getHeader(headerName));
        }
        out.println("</pre>");
        
        out.println("</body>");
        out.println("</html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Crear una sesión si no existe
        HttpSession session = request.getSession();
        
        // Crear un usuario de prueba para la sesión
        Usuario usuarioPrueba = new Usuario();
        usuarioPrueba.setDni("12345678");
        usuarioPrueba.setNombres("Usuario");
        usuarioPrueba.setApellidoPaterno("De");
        usuarioPrueba.setApellidoMaterno("Prueba");
        usuarioPrueba.setRol("ADMINISTRADOR");
        
        // Guardar en sesión
        session.setAttribute("usuario", usuarioPrueba);
        
        // Redirigir al mismo servlet para ver los datos
        response.sendRedirect("TestDBServlet");
    }
}