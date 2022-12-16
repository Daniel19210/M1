import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client{

    private Client() {}

    public static void main(String[] args){

        try{

            while(true){
                Registry reg = LocateRegistry.getRegistry(null);

                Mandelbrot bag = (Mandelbrot) reg.lookup("Mandelbrot");
                
                Task t = bag.getTask();

                if(t != null){

                    t.run();

                    bag.addResult(t);
                }else{
                    Thread.sleep(500);
                    System.out.println("Pause");
                }

            }

        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}