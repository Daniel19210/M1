import java.util.ArrayList;

public class Mandelbrot{

    private static int limite = 50;

    public Mandelbrot(){

    }

    public static boolean traitementPoint(Complexe c){
        Complexe z = new Complexe(0, 0);
        
        for(int i=0; i<limite ; i++){
            if(z.module() > 2){
                return false;
            }
            z = z.multiply(z);
            z = z.add(c);
        }
        return true;
    }
}