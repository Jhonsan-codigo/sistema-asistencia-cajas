package controllers;

import dao.CarreraDAO;
import dao.CursoDAO;
import modelos.Carrera;
import modelos.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CursoServlet", urlPatterns = {"/cursos"})
public class CursoServlet extends HttpServlet {

    private CursoDAO cursoDAO = new CursoDAO();
    private CarreraDAO carreraDAO = new CarreraDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Curso curso = cursoDAO.obtenerPorId(id);
            List<Carrera> carreras = carreraDAO.listarTodas();
            request.setAttribute("curso", curso);
            request.setAttribute("carreras", carreras);
            request.getRequestDispatcher("cursos.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cursoDAO.eliminar(id);
            response.sendRedirect("cursos");
        } else {
            List<Curso> cursos = cursoDAO.listarTodos();
            List<Carrera> carreras = carreraDAO.listarTodas();
            request.setAttribute("cursos", cursos);
            request.setAttribute("carreras", carreras);
            request.getRequestDispatcher("cursos.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        int carreraId = Integer.parseInt(request.getParameter("carrera_id"));
        int ciclo = Integer.parseInt(request.getParameter("ciclo"));
        
        Curso curso = new Curso();
        curso.setCodigo(codigo);
        curso.setNombre(nombre);
        curso.setCarreraId(carreraId);
        curso.setCiclo(ciclo);
        
        if (idStr != null && !idStr.isEmpty()) {
            curso.setId(Integer.parseInt(idStr));
            cursoDAO.actualizar(curso);
        } else {
            cursoDAO.insertar(curso);
        }
        
        response.sendRedirect("cursos");
    }
}