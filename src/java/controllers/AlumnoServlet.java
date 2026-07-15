package controllers;

import dao.AlumnoDAO;
import dao.CarreraDAO;
import modelos.Alumno;
import modelos.Carrera;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AlumnoServlet", urlPatterns = {"/alumnos"})
public class AlumnoServlet extends HttpServlet {

    private AlumnoDAO alumnoDAO = new AlumnoDAO();
    private CarreraDAO carreraDAO = new CarreraDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Alumno alumno = alumnoDAO.obtenerPorId(id);
            List<Carrera> carreras = carreraDAO.listarTodas();
            request.setAttribute("alumno", alumno);
            request.setAttribute("carreras", carreras);
            request.getRequestDispatcher("alumnos.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            alumnoDAO.eliminar(id);
            response.sendRedirect("alumnos");
        } else {
            List<Alumno> alumnos = alumnoDAO.listarTodos();
            List<Carrera> carreras = carreraDAO.listarTodas();
            request.setAttribute("alumnos", alumnos);
            request.setAttribute("carreras", carreras);
            request.getRequestDispatcher("alumnos.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String codigo = request.getParameter("codigo");
        String dni = request.getParameter("dni");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        int carreraId = Integer.parseInt(request.getParameter("carrera_id"));
        int ciclo = Integer.parseInt(request.getParameter("ciclo"));
        
        Alumno alumno = new Alumno();
        alumno.setCodigo(codigo);
        alumno.setDni(dni);
        alumno.setNombres(nombres);
        alumno.setApellidos(apellidos);
        alumno.setEmail(email);
        alumno.setTelefono(telefono);
        alumno.setCarreraId(carreraId);
        alumno.setCiclo(ciclo);
        
        if (idStr != null && !idStr.isEmpty()) {
            alumno.setId(Integer.parseInt(idStr));
            alumnoDAO.actualizar(alumno);
        } else {
            alumnoDAO.insertar(alumno);
        }
        
        response.sendRedirect("alumnos");
    }
}