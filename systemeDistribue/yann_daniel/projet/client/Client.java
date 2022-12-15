import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client{

    private Client() {}

    public static void main(String[] args){

        try{

            Registry reg = LocateRegistry.getRegistry(null);

            Mandelbrot stub = (Mandelbrot) reg.lookup("Mandelbrot");

            //System.out.prinln(stub.getNbTache());
            while(stub.traitementPoint(stub.getNbTache())){}
            if(stub.getNbTache()==2400){
                stub.paint();
            }
            System.out.println("CLIENT FINI");
        }catch(Exception e){
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }
}