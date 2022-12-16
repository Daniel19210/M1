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
                    System.out.println("Calcul du point " + t.getPoint_a_traiter());
                    if(t.getPoint_a_traiter().getX() == 50){
                        Thread.sleep(10);
                    }

                    t.run();
                    
                    bag.addResult(t);
                }else{
                    System.out.println("fin");
                    return;
                }

            }

        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}