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
        // Parsear la URL de Neon/Railway: postgresql://user:pass@host:port/db?params
        // Convertir a formato JDBC válido
        URI uri = new URI(databaseUrl);
        
        String host = uri.getHost();
        int port = uri.getPort();
        if (port == -1) port = 5432; // Puerto por defecto PostgreSQL
        
        String path = uri.getPath();
        if (path.startsWith("/")) path = path.substring(1); // Quitar / inicial
        
        // Obtener user y password de la autoridad
        String userInfo = uri.getUserInfo();
        String user = "";
        String password = "";
        if (userInfo != null) {
            String[] parts = userInfo.split(":");
            user = parts[0];
            if (parts.length > 1) password = parts[1];
        }
        
        // Construir URL JDBC válida
        String jdbcUrl = "jdbc:postgresql://" + host + ":" + port + "/" + path;
        
        // Agregar parámetros de query si existen
        String query = uri.getQuery();
        if (query != null && !query.isEmpty()) {
            jdbcUrl += "?" + query;
        }
        
        Class.forName("org.postgresql.Driver");
        
        // Conectar con user y password separados
        conn = DriverManager.getConnection(jdbcUrl, user, password);
        
        System.out.println("Conectado a PostgreSQL en la nube");
        
    } catch (ClassNotFoundException e) {
        System.out.println("Error: Driver PostgreSQL no encontrado");
        e.printStackTrace();
    } catch (SQLException e) {
        System.out.println("Error de conexión PostgreSQL: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        System.out.println("Error parseando DATABASE_URL: " + e.getMessage());
        e.printStackTrace();
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