package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.net.URI;

public class Conexion {
    
    public static Connection getConnection() {
        Connection conn = null;
        
        // Verificar si estamos en Render (tiene DATABASE_URL)
        String databaseUrl = System.getenv("DATABASE_URL");
        
        if (databaseUrl != null) {
            // Estamos en Render - usar PostgreSQL
            conn = getPostgresConnection(databaseUrl);
        } else {
            // Estamos en local - usar MySQL (XAMPP)
            conn = getLocalConnection();
        }
        
        return conn;
    }
    
    private static Connection getPostgresConnection(String databaseUrl) {
        Connection conn = null;
        try {
            // Convertir postgresql:// a jdbc:postgresql://
            String jdbcUrl = databaseUrl.replace("postgresql://", "jdbc:postgresql://");
            
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(jdbcUrl);
            System.out.println("Conectado a PostgreSQL en Railway");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: Driver PostgreSQL no encontrado - " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error de conexión PostgreSQL: " + e.getMessage());
        }
        return conn;
    }
    
    private static Connection getLocalConnection() {
        Connection conn = null;
        String URL = "jdbc:mysql://localhost:3306/instituto_cajas?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String USER = "root";
        String PASSWORD = "";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conectado a MySQL local");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: Driver MySQL no encontrado - " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error de conexión MySQL: " + e.getMessage());
        }
        return conn;
    }
}