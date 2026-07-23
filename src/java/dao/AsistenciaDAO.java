package dao;

import database.Conexion;          // ✅ CORREGIDO: era config.Conexion
import modelos.Asistencia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaDAO {

    // ==================== REGISTRAR ====================
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

    // ==================== LISTAR TODAS ====================
    public List<Asistencia> listarTodas() {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "ORDER BY a.fecha DESC, a.id DESC";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(mapearAsistencia(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR CURSO Y FECHA ====================
    public List<Asistencia> listarPorCursoYFecha(int cursoId, Date fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.curso_id = ? AND a.fecha::text = ?::text " +
                     "ORDER BY al.nombre";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cursoId);
            pstmt.setString(2, fecha.toString());
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearAsistencia(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias por curso y fecha: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR ALUMNO ====================
    public List<Asistencia> listarPorAlumno(int alumnoId) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.alumno_id = ? ORDER BY a.fecha DESC";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearAsistencia(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias por alumno: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR FECHA ====================
    public List<Asistencia> listarPorFecha(Date fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.fecha::text = ?::text ORDER BY al.nombre";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, fecha.toString());
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearAsistencia(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias por fecha: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR RANGO DE FECHAS ====================
    public List<Asistencia> listarPorRangoFechas(Date fechaInicio, Date fechaFin) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.fecha BETWEEN ? AND ? ORDER BY a.fecha DESC, al.nombre";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, fechaInicio);
            pstmt.setDate(2, fechaFin);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearAsistencia(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar asistencias por rango: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== OBTENER POR ID ====================
    public Asistencia obtenerPorId(int id) {
        String sql = "SELECT a.*, al.nombre as nombre_alumno, c.nombre as nombre_curso, d.nombre as nombre_docente " +
                     "FROM asistencias a " +
                     "JOIN alumnos al ON a.alumno_id = al.id " +
                     "JOIN cursos c ON a.curso_id = c.id " +
                     "JOIN docentes d ON a.docente_id = d.id " +
                     "WHERE a.id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapearAsistencia(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // ==================== EXISTE ASISTENCIA ====================
    public boolean existeAsistencia(int alumnoId, int cursoId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE alumno_id = ? AND curso_id = ? AND fecha::text = ?::text";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            pstmt.setInt(2, cursoId);
            pstmt.setString(3, fecha.toString());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("existeAsistencia: alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha + " -> count=" + count);
                return count > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ==================== ACTUALIZAR ====================
    public boolean actualizar(int alumnoId, int cursoId, Date fecha, String estado, String observacion) {
        String sql = "UPDATE asistencias SET estado = ?, observacion = ? WHERE alumno_id = ? AND curso_id = ? AND fecha::text = ?::text";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setString(2, observacion);
            pstmt.setInt(3, alumnoId);
            pstmt.setInt(4, cursoId);
            pstmt.setString(5, fecha.toString());
            boolean resultado = pstmt.executeUpdate() > 0;
            if (resultado) {
                System.out.println("Asistencia actualizada: alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha);
            } else {
                System.out.println("Asistencia NO actualizada (no encontrada): alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha);
            }
            return resultado;
        } catch (SQLException e) {
            System.out.println("Error al actualizar asistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ==================== ELIMINAR ====================
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

    // ==================== CONTAR POR ESTADO Y FECHA ====================
    public int contarPorEstadoYFecha(String estado, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE estado = ? AND fecha::text = ?::text";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setString(2, fecha.toString());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error al contar asistencias: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== CONTAR POR ESTADO, CURSO Y FECHA ====================
    public int contarPorEstadoCursoYFecha(String estado, int cursoId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE estado = ? AND curso_id = ? AND fecha::text = ?::text";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setInt(2, cursoId);
            pstmt.setString(3, fecha.toString());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error al contar asistencias: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== MAPEAR RESULTSET ====================
    private Asistencia mapearAsistencia(ResultSet rs) throws SQLException {
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
        return a;
    }
}