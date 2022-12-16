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
            System.out.println(bag.data_a_traiter.size());
            for(int i=0; i<=Constantes.width; i++){
                for(int j=0; j<=Constantes.height; j++){
                    bag.addTask(new Point(i,j));
                }
            }

            Registry reg = LocateRegistry.getRegistry();

            reg.bind("Mandelbrot", bag);
            System.out.println("Le Serveur est prêt...");

            while(bag.data_a_traiter.size() != 0){
                Thread.sleep(100);
            };
            
        
            System.out.println("dessin");
            Thread.sleep(10);
            for(Task t: bag.taches_complete){
                System.out.println("tache: appartient " + t.getAppartient_mandelbrot() + " point " + t.getPoint_a_traiter());
                if(t.getAppartient_mandelbrot()){
                    fenetre.getPanelDessin().listePointMandelbrot.add(t.getPoint_a_traiter());
                }
            }
            fenetre.getPanelDessin().repaint();
            System.out.println("fin dessin");

        }catch(Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
        }
    }
}