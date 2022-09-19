import java.rmi.*;

public class Client {
    public static void main(String[] args) {
        try {
            CompteFactory cf = (CompteFactory) Naming.lookup("OF");
            cf.afficherCompte();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}