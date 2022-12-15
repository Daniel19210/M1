import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;

public class Server{

    public Server() {}


    public static void main(String args[]){
        Fenetre fenetre = new Fenetre(Constantes.width, Constantes.height);
        
        try{
            ImpMandelbrot bag = new ImpMandelbrot();

            for(int i=0; i<=Constantes.width; i++){
                for(int j=0; j<=Constantes.height; j++){
                    bag.addTask(new Point(i, j));
                }
            }

            Registry reg = LocateRegistry.getRegistry();

            reg.bind("Mandelbrot", bag);
            System.out.println("Le Serveur est prêt...");

            if(bag.data_a_traiter.isEmpty()){
                for(Task t: bag.taches_complete){
                    ImpTask t1 = (ImpTask)t;
                    if(t1.appartient_mandelbrot){
                        fenetre.getPanelDessin().listePointMandelbrot.add(t1.point_a_traiter);
                    }
                }
                fenetre.getPanelDessin().repaint();
            }

        }catch(Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
        }
    }
}