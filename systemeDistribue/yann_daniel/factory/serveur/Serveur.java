import java.rmi.*;

public class Serveur {
    public static void main(String[] args) {
        try {
            CompteFactoryImpl cf = new CompteFactoryImpl();
            for (int i = 0; i < 100; i++){
                cf.createCompte();
            }
            Naming.bind("OF", cf);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

