import java.rmi.registry.*;
import java.io.*;
import java.rmi.*;
public class ClientHello{
public static void main(String arg[]){
    try{
        Registry registry = LocateRegistry.getRegistry("172.31.18.60",1099);
        Hello h=(Hello) registry.lookup("nomdeobjet");

        long start = System.nanoTime();
        String messageRecu=h.ditBonjour();
        long end = System.nanoTime();
        System.out.println(messageRecu);
        long temps = (end - start) / 1000;
        System.out.println("Temps d'exécution de la méthode est :" + temps + "microS");
    }
        catch (Exception e){System.err.println("Erreur :"+e);}
    }
}
