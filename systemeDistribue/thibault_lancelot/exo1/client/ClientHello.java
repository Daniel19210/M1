import java.rmi.*;
import java.rmi.registry.*;

public class ClientHello {
    public static void main(String arg[]) {
        try {
            // Registry registry = LocateRegistry.getRegistry("172.31.18.57",1099);
            ObjFact h = (ObjFact) Naming.lookup("objfact");
            // String messageRecu = h.ditBonjour();

            Interface c = h.getComptId(2);
            c.depot();
            System.out.println(c.getSolde());
        } catch (Exception e) {
            System.err.println("Erreur :" + e);
        }
    }
}
