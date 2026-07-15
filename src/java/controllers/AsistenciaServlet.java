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
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AsistenciaServlet", urlPatterns = {"/asistencia"})
public class AsistenciaServlet extends HttpServlet {

    private AsistenciaDAO asistenciaDAO = new AsistenciaDAO();
    private AlumnoDAO alumnoDAO = new AlumnoDAO();
    private CursoDAO cursoDAO = new CursoDAO();
    private CarreraDAO carreraDAO = new CarreraDAO();
    private DocenteDAO docenteDAO = new DocenteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Carrera> carreras = carreraDAO.listarTodas();
        List<Curso> cursos = cursoDAO.listarTodos();
        List<Docente> docentes = docenteDAO.listarTodos();
        
        request.setAttribute("carreras", carreras);
        request.setAttribute("cursos", cursos);
        request.setAttribute("docentes", docentes);
        
        String fecha = request.getParameter("fecha");
        String cursoId = request.getParameter("curso_id");
        String carreraId = request.getParameter("carrera_id");
        String ciclo = request.getParameter("ciclo");
        
        String hoy = new java.sql.Date(System.currentTimeMillis()).toString();
        request.setAttribute("hoy", hoy);
        
        if (fecha != null && cursoId != null && !cursoId.isEmpty()) {
            List<Asistencia> asistencias = asistenciaDAO.listarPorCursoYFecha(
                Integer.parseInt(cursoId), Date.valueOf(fecha));
            request.setAttribute("asistencias", asistencias);
            request.setAttribute("fechaSeleccionada", fecha);
            request.setAttribute("cursoSeleccionado", Integer.parseInt(cursoId));
        }
        
        request.getRequestDispatcher("asistencia.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("guardar".equals(action)) {
            String fechaStr = request.getParameter("fecha");
            int cursoId = Integer.parseInt(request.getParameter("curso_id"));
            int docenteId = Integer.parseInt(request.getParameter("docente_id"));
            Date fecha = Date.valueOf(fechaStr);
            
            String[] alumnoIds = request.getParameterValues("alumno_id");
            if (alumnoIds != null) {
                for (String alumnoIdStr : alumnoIds) {
                    int alumnoId = Integer.parseInt(alumnoIdStr);
                    String estado = request.getParameter("estado_" + alumnoId);
                    String observacion = request.getParameter("observacion_" + alumnoId);
                    
                    if (!asistenciaDAO.existeAsistencia(alumnoId, cursoId, fecha)) {
                        Asistencia a = new Asistencia();
                        a.setAlumnoId(alumnoId);
                        a.setCursoId(cursoId);
                        a.setDocenteId(docenteId);
                        a.setFecha(fecha);
                        a.setEstado(estado != null ? estado : "ausente");
                        a.setObservacion(observacion);
                        asistenciaDAO.registrar(a);
                    }
                }
                request.setAttribute("mensajeExito", "Asistencia registrada correctamente");
            }
            
            List<Carrera> carreras = carreraDAO.listarTodas();
            List<Curso> cursos = cursoDAO.listarTodos();
            List<Docente> docentes = docenteDAO.listarTodos();
            request.setAttribute("carreras", carreras);
            request.setAttribute("cursos", cursos);
            request.setAttribute("docentes", docentes);
            request.setAttribute("fechaSeleccionada", fechaStr);
            request.setAttribute("cursoSeleccionado", cursoId);
            
            request.getRequestDispatcher("asistencia.jsp").forward(request, response);
        } else {
            doGet(request, response);
        }
    }
}