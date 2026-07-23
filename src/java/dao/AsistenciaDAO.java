package dao;

import database.Conexion;
import modelos.Asistencia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaDAO {

    private boolean esPostgreSQL = false;

    public AsistenciaDAO() {
        try (Connection conn = Conexion.getConnection()) {
            DatabaseMetaData metaData = conn.getMetaData();
            String dbName = metaData.getDatabaseProductName();
            esPostgreSQL = dbName.toLowerCase().contains("postgresql");
            System.out.println("BD detectada: " + dbName + " | esPostgreSQL=" + esPostgreSQL);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String fechaWhere(String campo) {
        return esPostgreSQL ? campo + "::text = ?::text" : "DATE(" + campo + ") = ?";
    }

    private void setFechaParam(PreparedStatement pstmt, int index, Date fecha) throws SQLException {
        if (esPostgreSQL) {
            pstmt.setString(index, fecha.toString());
        } else {
            pstmt.setDate(index, fecha);
        }
    }

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
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ==================== LISTAR TODAS ====================
    public List<Asistencia> listarTodas() {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias ORDER BY fecha DESC, id DESC";
        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR CURSO Y FECHA ====================
    public List<Asistencia> listarPorCursoYFecha(int cursoId, Date fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias WHERE curso_id = ? AND " + fechaWhere("fecha") + " ORDER BY alumno_id";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cursoId);
            setFechaParam(pstmt, 2, fecha);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR ALUMNO ====================
    public List<Asistencia> listarPorAlumno(int alumnoId) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias WHERE alumno_id = ? ORDER BY fecha DESC";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR ALUMNO Y RANGO ====================
    public List<Asistencia> listarPorAlumnoYRango(int alumnoId, Date fechaInicio, Date fechaFin) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias WHERE alumno_id = ? AND DATE(fecha) BETWEEN ? AND ? ORDER BY fecha DESC";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            pstmt.setDate(2, fechaInicio);
            pstmt.setDate(3, fechaFin);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR FECHA ====================
    public List<Asistencia> listarPorFecha(Date fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias WHERE " + fechaWhere("fecha") + " ORDER BY alumno_id";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            setFechaParam(pstmt, 1, fecha);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== LISTAR POR RANGO ====================
    public List<Asistencia> listarPorRangoFechas(Date fechaInicio, Date fechaFin) {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencias WHERE DATE(fecha) BETWEEN ? AND ? ORDER BY fecha DESC";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, fechaInicio);
            pstmt.setDate(2, fechaFin);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearBasico(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ==================== OBTENER POR ID ====================
    public Asistencia obtenerPorId(int id) {
        String sql = "SELECT * FROM asistencias WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapearBasico(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ==================== EXISTE ASISTENCIA ====================
    public boolean existeAsistencia(int alumnoId, int cursoId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE alumno_id = ? AND curso_id = ? AND " + fechaWhere("fecha");
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, alumnoId);
            pstmt.setInt(2, cursoId);
            setFechaParam(pstmt, 3, fecha);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("existeAsistencia: alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha + " -> count=" + count);
                return count > 0;
            }
        } catch (SQLException e) {
            System.out.println("ERROR en existeAsistencia: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ==================== ACTUALIZAR ====================
    public boolean actualizar(int alumnoId, int cursoId, Date fecha, String estado, String observacion) {
        String sql = "UPDATE asistencias SET estado = ?, observacion = ? WHERE alumno_id = ? AND curso_id = ? AND " + fechaWhere("fecha");
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setString(2, observacion);
            pstmt.setInt(3, alumnoId);
            pstmt.setInt(4, cursoId);
            setFechaParam(pstmt, 5, fecha);
            boolean ok = pstmt.executeUpdate() > 0;
            System.out.println("actualizar: alumno=" + alumnoId + ", curso=" + cursoId + ", fecha=" + fecha + " -> ok=" + ok);
            return ok;
        } catch (SQLException e) {
            System.out.println("ERROR en actualizar: " + e.getMessage());
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
            e.printStackTrace();
        }
        return false;
    }

    // ==================== CONTAR POR ESTADO Y FECHA ====================
    public int contarPorEstadoYFecha(String estado, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE estado = ? AND " + fechaWhere("fecha");
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            setFechaParam(pstmt, 2, fecha);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== CONTAR POR ESTADO, CURSO Y FECHA ====================
    public int contarPorEstadoCursoYFecha(String estado, int cursoId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE estado = ? AND curso_id = ? AND " + fechaWhere("fecha");
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setInt(2, cursoId);
            setFechaParam(pstmt, 3, fecha);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== MAPEAR BÁSICO ====================
    private Asistencia mapearBasico(ResultSet rs) throws SQLException {
        Asistencia a = new Asistencia();
        a.setId(rs.getInt("id"));
        a.setAlumnoId(rs.getInt("alumno_id"));
        a.setCursoId(rs.getInt("curso_id"));
        a.setDocenteId(rs.getInt("docente_id"));
        a.setFecha(rs.getDate("fecha"));
        a.setEstado(rs.getString("estado"));
        a.setObservacion(rs.getString("observacion"));
        return a;
    }
}