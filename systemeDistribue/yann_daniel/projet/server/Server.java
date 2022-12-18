import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.util.Arrays;
import java.util.ArrayList;

public class Server{

    public static Fenetre fenetre;
    public static ImpMandelbrot bag;

    public Server() {}
    public static void main(String args[]){
        ArrayList<String> arrArgs = new ArrayList<>(Arrays.asList(args));
        if(arrArgs.size() == 3){
            Constantes.width = Integer.parseInt(args[0]);
            Constantes.height = Integer.parseInt(args[1]);
            Constantes.limite = Integer.parseInt(args[2]);
        }else if(arrArgs.size() == 7){
            Constantes.widthComplexe = new Complexe(Double.parseDouble(args[3]),Double.parseDouble(args[4]));
            Constantes.heightComplexe = new Complexe(Double.parseDouble(args[5]),Double.parseDouble(args[6]));
            Constantes.calculCoordPlan();
        }else if (arrArgs.size() == 0){
            System.out.println("Pas de paramètre donné en entrée");
        } else {
            System.out.println("Le nombre de paramètre est incorrect. Le programme accepte 3 ou 7 arguments en paramètres");
            return;
        }
        
        System.out.println("Résolution de la fenetre: " + Constantes.width + "x" + Constantes.height + "\nLimite de calcul: "+ Constantes.limite);
        System.out.print("Les intervalles complexe sont: (" + Constantes.widthComplexe.getA() + ";" + Constantes.widthComplexe.getB() + ") sur l'axe des réels");
        System.out.println(" et (" + Constantes.heightComplexe.getA() + ";" + Constantes.heightComplexe.getB() + ") sur l'axe des imaginaires");
        
        fenetre = new Fenetre(Constantes.width, Constantes.height);
        
        try{
            //INITITAISATION DE LA FENETRE
            bag = new ImpMandelbrot();
            for(int i=0; i<=Constantes.width; i++){
                for(int j=0; j<=Constantes.height; j++){
                    Point p = new Point(i,j);
                    bag.addTask(p);
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
        //calculComplexite();
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