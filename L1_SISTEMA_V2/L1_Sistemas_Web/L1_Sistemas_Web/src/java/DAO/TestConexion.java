package DAO;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        Connection con = Conexion.getConexion();
        if (con != null) {
            System.out.println("✅ Conexión exitosa a SQL Server");
        } else {
            System.out.println("❌ Falló la conexión");
        }
    }
}
