import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Random;

public class Client{

    private Client() {}

    public static void main(String[] args){

        try{
            Registry reg = LocateRegistry.getRegistry(null);
    
            Mandelbrot bag = (Mandelbrot) reg.lookup("Mandelbrot");
            while(true){

                Task t = bag.getTask();

                if(t != null){
                    //System.out.println("Calcul du point " + t.getPoint_a_traiter());


                    t.run();
                    
                    bag.addResult(t);
                }else{
                    //System.out.println("fin");
                    Thread.sleep(1000);
                }
            }

        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}