import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client{

    private Client() {}

    public static void main(String[] args){

        try{

            Registry reg = LocateRegistry.getRegistry(null);

            Mandelbrot stub = (Mandelbrot) reg.lookup("Mandelbrot");

            System.out.println("Début traitement des points");
            while(stub.traitementPoint()){}
        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}