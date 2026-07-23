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
import java.time.LocalDate;
import java.time.ZoneId;
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

        // ✅ CORRECCIÓN: Usar zona horaria de Lima
        String hoy = Date.valueOf(LocalDate.now(ZoneId.of("America/Lima"))).toString();
        request.setAttribute("hoy", hoy);

        String fecha = request.getParameter("fecha");
        String cursoId = request.getParameter("curso_id");
        String carreraId = request.getParameter("carrera_id");
        String ciclo = request.getParameter("ciclo");

        request.setAttribute("fechaSeleccionada", fecha);
        request.setAttribute("cursoSeleccionado", cursoId);
        request.setAttribute("carreraSeleccionada", carreraId);
        request.setAttribute("cicloSeleccionado", ciclo);

        if (carreraId != null && !carreraId.isEmpty() && !"null".equals(carreraId) && 
            ciclo != null && !ciclo.isEmpty() && !"null".equals(ciclo)) {

            try {
                int carreraIdInt = Integer.parseInt(carreraId);
                int cicloInt = Integer.parseInt(ciclo);

                List<Alumno> alumnos = alumnoDAO.listarPorCarreraYCiclo(carreraIdInt, cicloInt);
                request.setAttribute("alumnos", alumnos);

                if (fecha != null && !fecha.isEmpty() && !"null".equals(fecha) && 
                    cursoId != null && !cursoId.isEmpty() && !"null".equals(cursoId)) {

                    int cursoIdInt = Integer.parseInt(cursoId);
                    Date fechaDate = Date.valueOf(fecha);

                    List<Asistencia> asistencias = asistenciaDAO.listarPorCursoYFecha(cursoIdInt, fechaDate);
                    request.setAttribute("asistencias", asistencias);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al parsear carrera_id o ciclo: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("asistencia.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ===== DEBUG COMPLETO =====
        System.out.println("========== DOPOST DEBUG ==========");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String name = paramNames.nextElement();
            String[] values = request.getParameterValues(name);
            System.out.println("  " + name + " = " + java.util.Arrays.toString(values));
        }
        System.out.println("===================================");
        // ===== FIN DEBUG =====

        String action = request.getParameter("action");

        if ("guardar".equals(action)) {
            String fechaStr = request.getParameter("fecha");
            String cursoIdStr = request.getParameter("curso_id");
            String docenteIdStr = request.getParameter("docente_id");
            String carreraIdStr = request.getParameter("carrera_id");
            String cicloStr = request.getParameter("ciclo");

            System.out.println("===== GUARDAR ASISTENCIA =====");
            System.out.println("fecha: " + fechaStr);
            System.out.println("curso_id: " + cursoIdStr);
            System.out.println("docente_id: " + docenteIdStr);
            System.out.println("carrera_id: " + carreraIdStr);
            System.out.println("ciclo: " + cicloStr);

            if (fechaStr == null || fechaStr.isEmpty() || 
                cursoIdStr == null || cursoIdStr.isEmpty() || 
                docenteIdStr == null || docenteIdStr.isEmpty()) {

                request.setAttribute("mensajeError", "Faltan datos obligatorios para guardar la asistencia");
                doGet(request, response);
                return;
            }

            Date fecha = Date.valueOf(fechaStr);
            int cursoId = Integer.parseInt(cursoIdStr);
            int docenteId = Integer.parseInt(docenteIdStr);

            String[] alumnoIds = request.getParameterValues("alumno_id");
            System.out.println("alumnos recibidos: " + (alumnoIds != null ? alumnoIds.length : 0));

            int guardados = 0;
            int actualizados = 0;

            if (alumnoIds != null && alumnoIds.length > 0) {
                for (String alumnoIdStr : alumnoIds) {
                    int alumnoId = Integer.parseInt(alumnoIdStr);
                    String estado = request.getParameter("estado_" + alumnoId);
                    String observacion = request.getParameter("observacion_" + alumnoId);

                    System.out.println("Alumno " + alumnoId + " -> estado: '" + estado + "'");

                    if (estado == null || estado.isEmpty()) {
                        estado = "A";
                    }

                    boolean ok;
                    if (asistenciaDAO.existeAsistencia(alumnoId, cursoId, fecha)) {
                        ok = asistenciaDAO.actualizar(alumnoId, cursoId, fecha, estado, observacion);
                        if (ok) actualizados++;
                        System.out.println("  Actualizar: " + ok);
                    } else {
                        Asistencia a = new Asistencia();
                        a.setAlumnoId(alumnoId);
                        a.setCursoId(cursoId);
                        a.setDocenteId(docenteId);
                        a.setFecha(fecha);
                        a.setEstado(estado);
                        a.setObservacion(observacion);
                        ok = asistenciaDAO.registrar(a);
                        if (ok) guardados++;
                        System.out.println("  Registrar: " + ok);
                    }
                }

                request.setAttribute("mensajeExito", 
                    "Asistencia guardada: " + guardados + " nuevos, " + actualizados + " actualizados");
            } else {
                request.setAttribute("mensajeError", "No se seleccionaron alumnos");
            }

            // Recargar los datos para mostrar la página actualizada
            List<Carrera> carreras = carreraDAO.listarTodas();
            List<Curso> cursos = cursoDAO.listarTodos();
            List<Docente> docentes = docenteDAO.listarTodos();
            request.setAttribute("carreras", carreras);
            request.setAttribute("cursos", cursos);
            request.setAttribute("docentes", docentes);

            // ✅ CORRECCIÓN: Usar zona horaria de Lima
            String hoy = Date.valueOf(LocalDate.now(ZoneId.of("America/Lima"))).toString();
            request.setAttribute("hoy", hoy);
            request.setAttribute("fechaSeleccionada", fechaStr);
            request.setAttribute("cursoSeleccionado", cursoIdStr);
            request.setAttribute("carreraSeleccionada", carreraIdStr);
            request.setAttribute("cicloSeleccionado", cicloStr);

            if (carreraIdStr != null && !carreraIdStr.isEmpty() && !"null".equals(carreraIdStr) && 
                cicloStr != null && !cicloStr.isEmpty() && !"null".equals(cicloStr)) {

                try {
                    int carreraIdInt = Integer.parseInt(carreraIdStr);
                    int cicloInt = Integer.parseInt(cicloStr);
                    List<Alumno> alumnos = alumnoDAO.listarPorCarreraYCiclo(carreraIdInt, cicloInt);
                    request.setAttribute("alumnos", alumnos);

                    List<Asistencia> asistencias = asistenciaDAO.listarPorCursoYFecha(cursoId, fecha);
                    request.setAttribute("asistencias", asistencias);
                } catch (NumberFormatException e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }

            request.getRequestDispatcher("asistencia.jsp").forward(request, response);
            return;
        }

        doGet(request, response);
    }
}