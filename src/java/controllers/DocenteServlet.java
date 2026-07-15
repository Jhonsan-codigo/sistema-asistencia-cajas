package controllers;

import dao.DocenteDAO;
import modelos.Docente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DocenteServlet", urlPatterns = {"/docentes"})
public class DocenteServlet extends HttpServlet {

    private final DocenteDAO docenteDAO = new DocenteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar sesión
        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            List<Docente> docentes = docenteDAO.listarTodos();
            request.setAttribute("docentes", docentes);
            request.getRequestDispatcher("docentes.jsp").forward(request, response);
        } else {
            switch (action) {
                case "edit" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Docente docente = docenteDAO.obtenerPorId(id);
                    request.setAttribute("docente", docente);
                    request.getRequestDispatcher("docentes.jsp").forward(request, response);
                }
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    docenteDAO.eliminar(id);
                    response.sendRedirect("docentes");
                }
                default -> {
                    List<Docente> docentes = docenteDAO.listarTodos();
                    request.setAttribute("docentes", docentes);
                    request.getRequestDispatcher("docentes.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar sesión
        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String dni = request.getParameter("dni");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String especialidad = request.getParameter("especialidad");
        
        Docente docente = new Docente();
        docente.setDni(dni);
        docente.setNombres(nombres);
        docente.setApellidos(apellidos);
        docente.setEmail(email);
        docente.setTelefono(telefono);
        docente.setEspecialidad(especialidad);
        
        if (idStr != null && !idStr.isEmpty()) {
            docente.setId(Integer.parseInt(idStr));
            docenteDAO.actualizar(docente);
        } else {
            docenteDAO.insertar(docente);
        }
        
        response.sendRedirect("docentes");
    }
}