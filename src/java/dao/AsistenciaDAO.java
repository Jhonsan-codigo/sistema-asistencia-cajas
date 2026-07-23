package dao;

import database.Conexion;
import modelos.Asistencia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaDAO {

    public List<Asistencia> listarPorCursoYFecha(int cursoId, Date fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, CONCAT(al.apellidos, ', ', al.nombres) as nombre_alumno, " +
                     "c.nombre as nombre_curso, CONCAT(d.apellidos, ', ', d.nombres) as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.curso_id = ? AND a.fecha = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cursoId);
            pstmt.setDate(2, fecha);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Asistencia a = new Asistencia();
                a.setId(rs.getInt("id"));
                a.setAlumnoId(rs.getInt("alumno_id"));
                a.setCursoId(rs.getInt("curso_id"));
                a.setDocenteId(rs.getInt("docente_id"));
                a.setFecha(rs.getDate("fecha"));
                a.setEstado(rs.getString("estado"));
                a.setObservacion(rs.getString("observacion"));
                a.setNombreAlumno(rs.getString("nombre_alumno"));
                a.setNombreCurso(rs.getString("nombre_curso"));
                a.setNombreDocente(rs.getString("nombre_docente"));
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public List<Asistencia> listarPorAlumno(int alumnoId) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, c.nombre as nombre_curso, " +
                     "CONCAT(d.apellidos, ', ', d.nombres) as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.alumno_id = ? ORDER BY a.fecha DESC";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Asistencia a = new Asistencia();
                a.setId(rs.getInt("id"));
                a.setAlumnoId(rs.getInt("alumno_id"));
                a.setCursoId(rs.getInt("curso_id"));
                a.setDocenteId(rs.getInt("docente_id"));
                a.setFecha(rs.getDate("fecha"));
                a.setEstado(rs.getString("estado"));
                a.setObservacion(rs.getString("observacion"));
                a.setNombreCurso(rs.getString("nombre_curso"));
                a.setNombreDocente(rs.getString("nombre_docente"));
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias por alumno: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public boolean existeAsistencia(int alumnoId, int cursoId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE alumno_id = ? AND curso_id = ? AND fecha = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            pstmt.setInt(2, cursoId);
            pstmt.setDate(3, fecha);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean registrar(Asistencia a) {
        String sql = "INSERT INTO asistencias (alumno_id, curso_id, docente_id, fecha, estado, observacion) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, a.getAlumnoId());
            pstmt.setInt(2, a.getCursoId());
            pstmt.setInt(3, a.getDocenteId());
            pstmt.setDate(4, a.getFecha());
            pstmt.setString(5, a.getEstado());
            pstmt.setString(6, a.getObservacion());
            boolean resultado = pstmt.executeUpdate() > 0;
            if (resultado) {
                System.out.println("Asistencia registrada: alumno=" + a.getAlumnoId() + ", curso=" + a.getCursoId() + ", fecha=" + a.getFecha());
            }
            return resultado;
        } catch (SQLException e) {
            System.out.println("Error al registrar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean actualizar(int alumnoId, int cursoId, Date fecha, String estado, String observacion) {
        String sql = "UPDATE asistencias SET estado = ?, observacion = ? WHERE alumno_id = ? AND curso_id = ? AND fecha = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setString(2, observacion);
            pstmt.setInt(3, alumnoId);
            pstmt.setInt(4, cursoId);
            pstmt.setDate(5, fecha);
            boolean resultado = pstmt.executeUpdate() > 0;
            if (resultado) {
                System.out.println("Asistencia actualizada: alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha);
            }
            return resultado;
        } catch (SQLException e) {
            System.out.println("Error al actualizar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM asistencias WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}