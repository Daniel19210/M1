import java.rmi.Naming;
//import java.rmi.registry.LocateRegistry;
//import java.rmi.registry.Registry;
public class Client{

    private Client() {}

    public static void main(String[] args){

        try{
            //On recupere la liste des données à traiter
            Mandelbrot bag = (Mandelbrot) Naming.lookup("rmi://localhost:1099/Mandelbrot");
            System.out.println("Lancement du client");
            while(true){

                //on recupere une tache
                Task t = bag.getTask();

                //Si il y a une tache a executer on la traite sinon, on attend
                if(t != null){
                    //System.out.println("Calcul du point: " + t.getPoint_a_traiter());
                    t.run();
                    bag.addResult(t);
                }else{
                    Thread.sleep(1000);
                }
            }
        }catch(java.rmi.ConnectException c){
            System.out.println("Le serveur a mis fin à la connection, fin du programme");
        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}