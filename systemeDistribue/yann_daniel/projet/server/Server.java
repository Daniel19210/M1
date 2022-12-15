import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;


public class Server{

    public Server() {}

    public static void main(String args[]){
        float width = 600;
        float height = 400;
        Fenetre fenetre = new Fenetre((int) width, (int) height);
        
        try{
            ImpMandelbrot obj = new ImpMandelbrot(fenetre, width, height);


            Mandelbrot stub = (Mandelbrot) UnicastRemoteObject.exportObject(obj, 0);

            Registry reg = LocateRegistry.getRegistry();

            reg.bind("Mandelbrot", stub);
            System.out.println("Le Serveur est prêt...");
        }catch(Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
        }
    }
}