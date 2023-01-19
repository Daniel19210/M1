import java.rmi.*;

public class Client {
    public static void main(String[] args) {
        try {
            CompteFactory cf = (CompteFactory) Naming.lookup("OF");
            while(true){
                cf.afficherCompte(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}