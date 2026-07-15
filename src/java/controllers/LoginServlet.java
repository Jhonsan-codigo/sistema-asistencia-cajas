package controllers;

import database.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        
        if (usuario == null || usuario.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingresa usuario y contraseña");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        UsuarioAutenticado user = autenticar(usuario.trim(), password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", user.getUsername());
            session.setAttribute("rol", user.getRol());
            session.setAttribute("nombreCompleto", user.getNombreCompleto());
            session.setAttribute("docenteId", user.getDocenteId());
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.setAttribute("usuario", usuario);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private UsuarioAutenticado autenticar(String username, String password) {
        String sql = "SELECT u.id, u.username, u.password, u.rol, u.docente_id, " +
                     "d.nombres, d.apellidos " +
                     "FROM usuarios u " +
                     "LEFT JOIN docentes d ON u.docente_id = d.id " +
                     "WHERE u.username = ? AND u.password = ?";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                UsuarioAutenticado user = new UsuarioAutenticado();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRol(rs.getString("rol"));
                user.setDocenteId(rs.getInt("docente_id"));
                
                String nombres = rs.getString("nombres");
                String apellidos = rs.getString("apellidos");
                if (nombres != null && apellidos != null) {
                    user.setNombreCompleto(nombres + " " + apellidos);
                } else {
                    user.setNombreCompleto(username);
                }
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error en autenticación: " + e.getMessage());
        }
        return null;
    }
    
    private static class UsuarioAutenticado {
        private int id;
        private String username;
        private String rol;
        private String nombreCompleto;
        private int docenteId;
        
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getRol() { return rol; }
        public void setRol(String rol) { this.rol = rol; }
        public String getNombreCompleto() { return nombreCompleto; }
        public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }
        public int getDocenteId() { return docenteId; }
        public void setDocenteId(int docenteId) { this.docenteId = docenteId; }
    }
}