package dao;

import database.Conexion;
import modelos.Docente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocenteDAO {
    
    public List<Docente> listarTodos() {
        List<Docente> lista = new ArrayList<>();
        String sql = "SELECT * FROM docentes ORDER BY apellidos, nombres";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Docente d = new Docente();
                d.setId(rs.getInt("id"));
                d.setDni(rs.getString("dni"));
                d.setNombres(rs.getString("nombres"));
                d.setApellidos(rs.getString("apellidos"));
                d.setEmail(rs.getString("email"));
                d.setTelefono(rs.getString("telefono"));
                d.setEspecialidad(rs.getString("especialidad"));
                lista.add(d);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar docentes: " + e.getMessage());
        }
        return lista;
    }
    
    public Docente obtenerPorId(int id) {
        String sql = "SELECT * FROM docentes WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Docente d = new Docente();
                d.setId(rs.getInt("id"));
                d.setDni(rs.getString("dni"));
                d.setNombres(rs.getString("nombres"));
                d.setApellidos(rs.getString("apellidos"));
                d.setEmail(rs.getString("email"));
                d.setTelefono(rs.getString("telefono"));
                d.setEspecialidad(rs.getString("especialidad"));
                return d;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener docente: " + e.getMessage());
        }
        return null;
    }
    
    public boolean insertar(Docente d) {
        String sql = "INSERT INTO docentes (dni, nombres, apellidos, email, telefono, especialidad) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, d.getDni());
            pstmt.setString(2, d.getNombres());
            pstmt.setString(3, d.getApellidos());
            pstmt.setString(4, d.getEmail());
            pstmt.setString(5, d.getTelefono());
            pstmt.setString(6, d.getEspecialidad());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar docente: " + e.getMessage());
        }
        return false;
    }
    
    public boolean actualizar(Docente d) {
        String sql = "UPDATE docentes SET dni=?, nombres=?, apellidos=?, email=?, telefono=?, especialidad=? WHERE id=?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, d.getDni());
            pstmt.setString(2, d.getNombres());
            pstmt.setString(3, d.getApellidos());
            pstmt.setString(4, d.getEmail());
            pstmt.setString(5, d.getTelefono());
            pstmt.setString(6, d.getEspecialidad());
            pstmt.setInt(7, d.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar docente: " + e.getMessage());
        }
        return false;
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM docentes WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar docente: " + e.getMessage());
        }
        return false;
    }
}