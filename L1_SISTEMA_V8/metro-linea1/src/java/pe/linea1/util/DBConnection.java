package pe.linea1.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;

public class DBConnection {
    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    static {
        try (
            InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")
        ) {
            Properties prop = new Properties();
            if (input == null) {
                throw new RuntimeException("No se encontró el archivo db.properties en el classpath");
            }
            prop.load(input);
            driver = prop.getProperty("db.driver");
            url = prop.getProperty("db.url");
            user = prop.getProperty("db.user");
            password = prop.getProperty("db.password");
            Class.forName(driver);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException("Error al cargar configuración de la base de datos: " + ex.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}