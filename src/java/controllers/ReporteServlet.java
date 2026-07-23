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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        List<Alumno> todosAlumnos = alumnoDAO.listarTodos();

        request.setAttribute("totalAlumnos", todosAlumnos.size());
        request.setAttribute("totalCarreras", carreras.size());
        request.setAttribute("totalCursos", cursos.size());
        request.setAttribute("totalDocentes", docentes.size());

        request.setAttribute("carreras", carreras);
        request.setAttribute("cursos", cursos);
        request.setAttribute("docentes", docentes);
        request.setAttribute("listaAlumnos", todosAlumnos);

        if ("asistencia".equals(action)) {
            // ============================================
            // REPORTE POR ASISTENCIA - CON PERÍODOS
            // ============================================
            String periodo = request.getParameter("periodo");
            String fechaInicio = request.getParameter("fecha_inicio");
            String fechaFin = request.getParameter("fecha_fin");
            String carreraId = request.getParameter("carrera_id");
            String ciclo = request.getParameter("ciclo");

            // ✅ CORRECCIÓN: Usar zona horaria de Lima (Perú)
            LocalDate hoy = LocalDate.now(ZoneId.of("America/Lima"));
            LocalDate inicio = null;
            LocalDate fin = hoy;

            if (periodo == null || periodo.isEmpty() || "todo".equals(periodo)) {
                inicio = hoy.minusYears(10); // Todo el tiempo (últimos 10 años)
                fin = hoy;
            } else if ("hoy".equals(periodo)) {
                inicio = hoy;
                fin = hoy;
            } else if ("semana".equals(periodo)) {
                inicio = hoy.minusDays(7);
                fin = hoy;
            } else if ("mes".equals(periodo)) {
                inicio = hoy.minusDays(30);
                fin = hoy;
            } else if ("personalizado".equals(periodo)) {
                if (fechaInicio != null && !fechaInicio.isEmpty()) {
                    inicio = LocalDate.parse(fechaInicio);
                }
                if (fechaFin != null && !fechaFin.isEmpty()) {
                    fin = LocalDate.parse(fechaFin);
                }
            }

            // Si no hay período explícito, usar fechas del request
            if (fechaInicio != null && !fechaInicio.isEmpty() && inicio == null) {
                inicio = LocalDate.parse(fechaInicio);
            }
            if (fechaFin != null && !fechaFin.isEmpty()) {
                fin = LocalDate.parse(fechaFin);
            }
            if (inicio == null) {
                inicio = hoy.minusYears(10);
            }

            request.setAttribute("periodo", periodo != null ? periodo : "todo");
            request.setAttribute("fechaInicio", inicio.toString());
            request.setAttribute("fechaFin", fin.toString());
            request.setAttribute("carreraId", carreraId);
            request.setAttribute("cicloSeleccionado", ciclo);

            int totalPresentes = 0;
            int totalTardanzas = 0;
            int totalAusentes = 0;

            if (carreraId != null && !carreraId.isEmpty() && !"null".equals(carreraId) && 
                ciclo != null && !ciclo.isEmpty() && !"null".equals(ciclo)) {

                try {
                    int carreraIdInt = Integer.parseInt(carreraId);
                    int cicloInt = Integer.parseInt(ciclo);

                    List<Alumno> alumnos = alumnoDAO.listarPorCarreraYCiclo(carreraIdInt, cicloInt);
                    request.setAttribute("alumnosReporte", alumnos);

                    Map<Integer, Map<String, Integer>> conteoAsistencias = new HashMap<>();
                    Date fInicio = Date.valueOf(inicio);
                    Date fFin = Date.valueOf(fin);

                    for (Alumno alumno : alumnos) {
                        List<Asistencia> asistencias = asistenciaDAO.listarPorAlumno(alumno.getId());

                        // Filtrar por fecha
                        asistencias.removeIf(a -> a.getFecha().before(fInicio) || a.getFecha().after(fFin));

                        int presentes = 0, tardanzas = 0, ausentes = 0;
                        for (Asistencia a : asistencias) {
                            String estado = a.getEstado();
                            if ("P".equals(estado)) presentes++;
                            else if ("T".equals(estado)) tardanzas++;
                            else if ("A".equals(estado)) ausentes++;
                        }

                        Map<String, Integer> conteo = new HashMap<>();
                        conteo.put("P", presentes);
                        conteo.put("T", tardanzas);
                        conteo.put("A", ausentes);
                        conteo.put("total", asistencias.size());
                        conteoAsistencias.put(alumno.getId(), conteo);

                        totalPresentes += presentes;
                        totalTardanzas += tardanzas;
                        totalAusentes += ausentes;
                    }

                    request.setAttribute("conteoAsistencias", conteoAsistencias);
                    request.setAttribute("totalPresentes", totalPresentes);
                    request.setAttribute("totalTardanzas", totalTardanzas);
                    request.setAttribute("totalAusentes", totalAusentes);
                } catch (NumberFormatException e) {
                    System.out.println("Error al parsear carrera_id o ciclo: " + e.getMessage());
                }
            }

        } else if ("alumno".equals(action)) {
            // ============================================
            // REPORTE POR ALUMNO
            // ============================================
            String alumnoId = request.getParameter("alumno_id");

            if (alumnoId != null && !alumnoId.isEmpty()) {
                int id = Integer.parseInt(alumnoId);
                Alumno alumno = alumnoDAO.obtenerPorId(id);
                List<Asistencia> asistencias = asistenciaDAO.listarPorAlumno(id);

                int presentes = 0, tardanzas = 0, ausentes = 0;
                for (Asistencia a : asistencias) {
                    String estado = a.getEstado();
                    if ("P".equals(estado)) presentes++;
                    else if ("T".equals(estado)) tardanzas++;
                    else if ("A".equals(estado)) ausentes++;
                }

                Map<String, Integer> resumen = new HashMap<>();
                resumen.put("P", presentes);
                resumen.put("T", tardanzas);
                resumen.put("A", ausentes);
                resumen.put("total", asistencias.size());

                request.setAttribute("alumnoSeleccionado", alumno);
                request.setAttribute("asistencias", asistencias);
                request.setAttribute("resumenAlumno", resumen);
                request.setAttribute("alumnoId", id);
            }
        }

        request.getRequestDispatcher("reportes.jsp").forward(request, response);
    }
}