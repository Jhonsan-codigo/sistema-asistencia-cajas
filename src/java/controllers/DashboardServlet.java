package controllers;

import dao.AlumnoDAO;
import dao.AsistenciaDAO;
import dao.CarreraDAO;
import dao.CursoDAO;
import dao.DocenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private AlumnoDAO alumnoDAO = new AlumnoDAO();
    private CarreraDAO carreraDAO = new CarreraDAO();
    private CursoDAO cursoDAO = new CursoDAO();
    private DocenteDAO docenteDAO = new DocenteDAO();
    private AsistenciaDAO asistenciaDAO = new AsistenciaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("totalAlumnos", alumnoDAO.listarTodos().size());
        request.setAttribute("totalCarreras", carreraDAO.listarTodas().size());
        request.setAttribute("totalCursos", cursoDAO.listarTodos().size());
        request.setAttribute("totalDocentes", docenteDAO.listarTodos().size());
        
        // ✅ AÑADIR: Lista real de carreras desde la BD
        request.setAttribute("carreras", carreraDAO.listarTodas());
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}