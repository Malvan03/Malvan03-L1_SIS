package pe.linea1.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {

    // Método estático para generar hash usando BCrypt
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Método para validar si una contraseña corresponde a su hash
    public static boolean checkPassword(String plainPassword, String hashed) {
        if (hashed == null) return false;
        return BCrypt.checkpw(plainPassword, hashed);
    }
}
