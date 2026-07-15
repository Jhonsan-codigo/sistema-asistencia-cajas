package controllers;

import dao.AlumnoDAO;
import dao.AsistenciaDAO;
import dao.CarreraDAO;
import dao.CursoDAO;
import dao.DocenteDAO;
import modelos.Alumno;
import modelos.Asistencia;
import modelos.Carrera;
import modelos.Curso;
import modelos.Docente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReporteServlet", urlPatterns = {"/reportes"})
public class ReporteServlet extends HttpServlet {

    private AsistenciaDAO asistenciaDAO = new AsistenciaDAO();
    private AlumnoDAO alumnoDAO = new AlumnoDAO();
    private CarreraDAO carreraDAO = new CarreraDAO();
    private CursoDAO cursoDAO = new CursoDAO();
    private DocenteDAO docenteDAO = new DocenteDAO();

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String action = request.getParameter("action");
    List<Carrera> carreras = carreraDAO.listarTodas();
    List<Curso> cursos = cursoDAO.listarTodos();
    List<Docente> docentes = docenteDAO.listarTodos();
    
    // Añadir totales para el resumen general
    request.setAttribute("totalAlumnos", alumnoDAO.listarTodos().size());
    request.setAttribute("totalCarreras", carreras.size());
    request.setAttribute("totalCursos", cursos.size());
    request.setAttribute("totalDocentes", docentes.size());
    
    request.setAttribute("carreras", carreras);
    request.setAttribute("cursos", cursos);
    request.setAttribute("docentes", docentes);
    
    if ("asistencia".equals(action)) {
        // ... código existente ...
    } else if ("alumno".equals(action)) {
        // ... código existente ...
    }
    
    request.getRequestDispatcher("reportes.jsp").forward(request, response);
}
}