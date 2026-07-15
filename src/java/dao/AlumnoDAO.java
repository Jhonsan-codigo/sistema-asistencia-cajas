package dao;

import database.Conexion;
import modelos.Alumno;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlumnoDAO {
    
    public List<Alumno> listarTodos() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT a.*, c.nombre as nombre_carrera FROM alumnos a JOIN carreras c ON a.carrera_id = c.id ORDER BY a.apellidos, a.nombres";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Alumno a = new Alumno();
                a.setId(rs.getInt("id"));
                a.setCodigo(rs.getString("codigo"));
                a.setDni(rs.getString("dni"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setEmail(rs.getString("email"));
                a.setTelefono(rs.getString("telefono"));
                a.setCarreraId(rs.getInt("carrera_id"));
                a.setCiclo(rs.getInt("ciclo"));
                a.setNombreCarrera(rs.getString("nombre_carrera"));
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar alumnos: " + e.getMessage());
        }
        return lista;
    }
    
    public List<Alumno> listarPorCarreraYCiclo(int carreraId, int ciclo) {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT a.*, c.nombre as nombre_carrera FROM alumnos a JOIN carreras c ON a.carrera_id = c.id WHERE a.carrera_id = ? AND a.ciclo = ? ORDER BY a.apellidos, a.nombres";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, carreraId);
            pstmt.setInt(2, ciclo);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Alumno a = new Alumno();
                a.setId(rs.getInt("id"));
                a.setCodigo(rs.getString("codigo"));
                a.setDni(rs.getString("dni"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setEmail(rs.getString("email"));
                a.setTelefono(rs.getString("telefono"));
                a.setCarreraId(rs.getInt("carrera_id"));
                a.setCiclo(rs.getInt("ciclo"));
                a.setNombreCarrera(rs.getString("nombre_carrera"));
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar alumnos por carrera y ciclo: " + e.getMessage());
        }
        return lista;
    }
    
    public Alumno obtenerPorId(int id) {
        String sql = "SELECT a.*, c.nombre as nombre_carrera FROM alumnos a JOIN carreras c ON a.carrera_id = c.id WHERE a.id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Alumno a = new Alumno();
                a.setId(rs.getInt("id"));
                a.setCodigo(rs.getString("codigo"));
                a.setDni(rs.getString("dni"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setEmail(rs.getString("email"));
                a.setTelefono(rs.getString("telefono"));
                a.setCarreraId(rs.getInt("carrera_id"));
                a.setCiclo(rs.getInt("ciclo"));
                a.setNombreCarrera(rs.getString("nombre_carrera"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener alumno: " + e.getMessage());
        }
        return null;
    }
    
    public Alumno obtenerPorDNI(String dni) {
        String sql = "SELECT a.*, c.nombre as nombre_carrera FROM alumnos a JOIN carreras c ON a.carrera_id = c.id WHERE a.dni = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dni);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Alumno a = new Alumno();
                a.setId(rs.getInt("id"));
                a.setCodigo(rs.getString("codigo"));
                a.setDni(rs.getString("dni"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                a.setEmail(rs.getString("email"));
                a.setTelefono(rs.getString("telefono"));
                a.setCarreraId(rs.getInt("carrera_id"));
                a.setCiclo(rs.getInt("ciclo"));
                a.setNombreCarrera(rs.getString("nombre_carrera"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener alumno por DNI: " + e.getMessage());
        }
        return null;
    }
    
    public boolean insertar(Alumno a) {
        String sql = "INSERT INTO alumnos (codigo, dni, nombres, apellidos, email, telefono, carrera_id, ciclo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, a.getCodigo());
            pstmt.setString(2, a.getDni());
            pstmt.setString(3, a.getNombres());
            pstmt.setString(4, a.getApellidos());
            pstmt.setString(5, a.getEmail());
            pstmt.setString(6, a.getTelefono());
            pstmt.setInt(7, a.getCarreraId());
            pstmt.setInt(8, a.getCiclo());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar alumno: " + e.getMessage());
        }
        return false;
    }
    
    public boolean actualizar(Alumno a) {
        String sql = "UPDATE alumnos SET codigo=?, dni=?, nombres=?, apellidos=?, email=?, telefono=?, carrera_id=?, ciclo=? WHERE id=?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, a.getCodigo());
            pstmt.setString(2, a.getDni());
            pstmt.setString(3, a.getNombres());
            pstmt.setString(4, a.getApellidos());
            pstmt.setString(5, a.getEmail());
            pstmt.setString(6, a.getTelefono());
            pstmt.setInt(7, a.getCarreraId());
            pstmt.setInt(8, a.getCiclo());
            pstmt.setInt(9, a.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar alumno: " + e.getMessage());
        }
        return false;
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM alumnos WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar alumno: " + e.getMessage());
        }
        return false;
    }
}