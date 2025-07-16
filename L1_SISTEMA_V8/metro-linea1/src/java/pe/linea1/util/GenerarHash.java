package pe.linea1.util;

import org.mindrot.jbcrypt.BCrypt;

public class GenerarHash {
    public static void main(String[] args) {
        String password = "joel";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println(hash);
    }
}