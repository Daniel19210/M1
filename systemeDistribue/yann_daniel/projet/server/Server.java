import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;

public class Server{

    public static Fenetre fenetre;
    public static ImpMandelbrot bag;
    public static Registry reg;

    public Server() {}


    public static void main(String args[]){
        fenetre = new Fenetre(Constantes.width, Constantes.height);
        
        try{
            bag = new ImpMandelbrot();
            System.out.println(bag.data_a_traiter.size());
            for(int i=0; i<=Constantes.width; i++){
                for(int j=0; j<=Constantes.height; j++){
                    bag.addTask(new Point(i,j));
                }
            }

            reg = LocateRegistry.getRegistry();
            reg.bind("Mandelbrot", bag);

            draw();

        }catch(Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
        }
    }

    public static void draw() throws Exception{

        bag.nbTaskGiven = -1;
        bag.taches_complete.clear();
        fenetre.getPanelDessin().listePointMandelbrot.clear();
        System.out.println("Les points sont a traiter !");

        while(bag.data_a_traiter.size() > bag.nbTaskGiven){
            Thread.sleep(100);
        };
        
    
        System.out.println("dessin");
        Thread.sleep(10);
        for(Task t: bag.taches_complete){
            //System.out.println("tache: appartient " + t.getAppartient_mandelbrot() + " point " + t.getPoint_a_traiter());
                
            //System.out.println(t.getPoint_a_traiter().getColor());
            fenetre.getPanelDessin().listePointMandelbrot.add(t.getPoint_a_traiter());
            
        }
        fenetre.getPanelDessin().repaint();
        System.out.println("fin dessin");
    }
}