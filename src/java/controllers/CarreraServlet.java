package controllers;

import dao.CarreraDAO;
import modelos.Carrera;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarreraServlet", urlPatterns = {"/carreras"})
public class CarreraServlet extends HttpServlet {

    private CarreraDAO carreraDAO = new CarreraDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Carrera carrera = carreraDAO.obtenerPorId(id);
            request.setAttribute("carrera", carrera);
            request.getRequestDispatcher("carreras.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            carreraDAO.eliminar(id);
            response.sendRedirect("carreras");
        } else {
            List<Carrera> carreras = carreraDAO.listarTodas();
            request.setAttribute("carreras", carreras);
            request.getRequestDispatcher("carreras.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        int duracionSemestres = Integer.parseInt(request.getParameter("duracion_semestres"));
        
        Carrera carrera = new Carrera();
        carrera.setCodigo(codigo);
        carrera.setNombre(nombre);
        carrera.setDescripcion(descripcion);
        carrera.setDuracionSemestres(duracionSemestres);
        
        if (idStr != null && !idStr.isEmpty()) {
            carrera.setId(Integer.parseInt(idStr));
            carreraDAO.actualizar(carrera);
        } else {
            carreraDAO.insertar(carrera);
        }
        
        response.sendRedirect("carreras");
    }
}