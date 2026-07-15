package dao;

import database.Conexion;
import modelos.Curso;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CursoDAO {
    
    public List<Curso> listarTodos() {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT c.*, car.nombre as nombre_carrera FROM cursos c JOIN carreras car ON c.carrera_id = car.id ORDER BY c.nombre";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Curso c = new Curso();
                c.setId(rs.getInt("id"));
                c.setCodigo(rs.getString("codigo"));
                c.setNombre(rs.getString("nombre"));
                c.setCarreraId(rs.getInt("carrera_id"));
                c.setCiclo(rs.getInt("ciclo"));
                c.setNombreCarrera(rs.getString("nombre_carrera"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar cursos: " + e.getMessage());
        }
        return lista;
    }
    
    public Curso obtenerPorId(int id) {
        String sql = "SELECT c.*, car.nombre as nombre_carrera FROM cursos c JOIN carreras car ON c.carrera_id = car.id WHERE c.id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Curso c = new Curso();
                c.setId(rs.getInt("id"));
                c.setCodigo(rs.getString("codigo"));
                c.setNombre(rs.getString("nombre"));
                c.setCarreraId(rs.getInt("carrera_id"));
                c.setCiclo(rs.getInt("ciclo"));
                c.setNombreCarrera(rs.getString("nombre_carrera"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener curso: " + e.getMessage());
        }
        return null;
    }
    
    public boolean insertar(Curso c) {
        String sql = "INSERT INTO cursos (codigo, nombre, carrera_id, ciclo) VALUES (?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, c.getCodigo());
            pstmt.setString(2, c.getNombre());
            pstmt.setInt(3, c.getCarreraId());
            pstmt.setInt(4, c.getCiclo());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar curso: " + e.getMessage());
        }
        return false;
    }
    
    public boolean actualizar(Curso c) {
        String sql = "UPDATE cursos SET codigo=?, nombre=?, carrera_id=?, ciclo=? WHERE id=?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, c.getCodigo());
            pstmt.setString(2, c.getNombre());
            pstmt.setInt(3, c.getCarreraId());
            pstmt.setInt(4, c.getCiclo());
            pstmt.setInt(5, c.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar curso: " + e.getMessage());
        }
        return false;
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM cursos WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar curso: " + e.getMessage());
        }
        return false;
    }
}