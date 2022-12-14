import java.util.ArrayList;

public class Mandelbroot{

    ArrayList<Point> pointAtraiter = new ArrayList<Point>();
    ArrayList<Point> pointDejaTraiter = new ArrayList<Point>();

    public Mandelbroot(){
        for(int i=-100; i<101; i++){
            for(int j=-100; j<101; j++){
                
                pointAtraiter.add(new Point(i, j));
            }
        }
    }
}