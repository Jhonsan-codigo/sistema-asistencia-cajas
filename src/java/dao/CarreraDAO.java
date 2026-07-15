package dao;

import database.Conexion;
import modelos.Carrera;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarreraDAO {
    
    public List<Carrera> listarTodas() {
        List<Carrera> lista = new ArrayList<>();
        String sql = "SELECT * FROM carreras ORDER BY nombre";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Carrera c = new Carrera();
                c.setId(rs.getInt("id"));
                c.setCodigo(rs.getString("codigo"));
                c.setNombre(rs.getString("nombre"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setDuracionSemestres(rs.getInt("duracion_semestres"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar carreras: " + e.getMessage());
        }
        return lista;
    }
    
    public Carrera obtenerPorId(int id) {
        String sql = "SELECT * FROM carreras WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Carrera c = new Carrera();
                c.setId(rs.getInt("id"));
                c.setCodigo(rs.getString("codigo"));
                c.setNombre(rs.getString("nombre"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setDuracionSemestres(rs.getInt("duracion_semestres"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener carrera: " + e.getMessage());
        }
        return null;
    }
    
    public boolean insertar(Carrera c) {
        String sql = "INSERT INTO carreras (codigo, nombre, descripcion, duracion_semestres) VALUES (?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, c.getCodigo());
            pstmt.setString(2, c.getNombre());
            pstmt.setString(3, c.getDescripcion());
            pstmt.setInt(4, c.getDuracionSemestres());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar carrera: " + e.getMessage());
        }
        return false;
    }
    
    public boolean actualizar(Carrera c) {
        String sql = "UPDATE carreras SET codigo=?, nombre=?, descripcion=?, duracion_semestres=? WHERE id=?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, c.getCodigo());
            pstmt.setString(2, c.getNombre());
            pstmt.setString(3, c.getDescripcion());
            pstmt.setInt(4, c.getDuracionSemestres());
            pstmt.setInt(5, c.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar carrera: " + e.getMessage());
        }
        return false;
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM carreras WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar carrera: " + e.getMessage());
        }
        return false;
    }
}