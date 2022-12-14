import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.*;

public class index{

    private static float width, height;
    private static Complexe a, b;

    public static Complexe convert(Point p, Complexe za, Complexe zb){
        return new Complexe((float)(p.getX()*((zb.getA() - za.getA())/width) + Math.min(za.getA(), zb.getA())), (float)(p.getY()*((za.getB() - zb.getB())/height) + Math.min(za.getB(), zb.getB()))); 
    }

    public static void main(String[] args){

        width = 600;
        height = 400;
        a = new Complexe(-2, 1);
        b = new Complexe(1,-1);
        Fenetre fenetre = new Fenetre((int)width, (int)height); 

        for(int i=0; i<=width; i++){
            for(int j=0; j<=height; j++){

                Point pointsImage = new Point(i, j);
                System.out.println(pointsImage.getX() + ";" + pointsImage.getY());
                if(Mandelbrot.traitementPoint(convert(pointsImage, a, b))){

                    fenetre.getPanelDessin().listePointMandelbrot.add(pointsImage);
                }

            }
                    fenetre.getPanelDessin().repaint();
        }
    }

}