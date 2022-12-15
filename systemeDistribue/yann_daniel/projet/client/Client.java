import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client{

    private Client() {}

    public static void main(String[] args){

        try{

            Registry reg = LocateRegistry.getRegistry(null);

            Mandelbrot bag = (Mandelbrot) reg.lookup("Mandelbrot");

            Task t = bag.getTask();

            t.run();

            bag.addResult(t);

            System.out.println("FINI CLIENT");

        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}