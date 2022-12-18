import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;

public class Server{

    public static Fenetre fenetre;
    public static ImpMandelbrot bag;

    public Server() {}


    public static void main(String args[]){
        fenetre = new Fenetre(Constantes.width, Constantes.height);
        
        try{
            //INITITAISATION DE LA FENETRE
            bag = new ImpMandelbrot();
            for(int i=0; i<=Constantes.width; i++){
                for(int j=0; j<=Constantes.height; j++){
                    bag.addTask(new Point(i,j));
                }
            }
            fenetre.getPanelDessin().listePointMandelbrot = bag.data_a_traiter;

            //Envois des données au registre
            Naming.rebind("Mandelbrot", bag);

            draw();

        }catch(Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
        }
    }
    
    //Mise à jour de l'image dessiner par le serveur
    public static void draw() throws Exception{

        //Reset des données pour que le client traite les points.
        bag.taches_complete.clear();
        bag.nbTaskGiven = -1;
        System.out.println("Serveur prêt!");
        System.out.println("Les points sont a traiter !");

        //Le serveur attends que les clients aient traités tout les points
        while(bag.data_a_traiter.size() > bag.nbTaskGiven){
            Thread.sleep(1000);
        };
    
        //Début du dessin
        System.out.println("dessin");
        // Il n'y a plus de points à traiter mais il y a peut-être encore un point en cours de traitement, d'où l'attente
        Thread.sleep(10);
        fenetre.getPanelDessin().repaint();
        System.out.println("fin dessin");
        calculComplexite();
    }

    public static void calculComplexite() throws RemoteException, IOException{
        ArrayList<Integer> div = new ArrayList<Integer>();
        for(int i = 0; i < 100; i++){
            div.add(0);
        }
        for(Task t: bag.taches_complete){
            div.set(t.getDivergence(), div.get(t.getDivergence())+1);
        }
        Integer j = 0;
        // écrire dans un .csv
        File csv = new File("complexite.csv");
        FileWriter fw = new FileWriter(csv);
        for(Integer i : div){
            StringBuilder line = new StringBuilder();
            line.append("\"");
            line.append(j);
            line.append("\"");
            line.append(";");
            line.append("\"");
            line.append(i);
            line.append("\"");
            line.append(";");
            line.append("\n");
            //System.out.println("nb de points avec une divergence de " + j + " est de " + i);
            j++;
            fw.write(line.toString());
        }
        fw.close();
    }
}