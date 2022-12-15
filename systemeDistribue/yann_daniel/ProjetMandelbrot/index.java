import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.*;

public class index{

    private static float width, height;
    private static Complexe widthComplexe, heightComplexe;
    private static Fenetre fenetre;

    public static Complexe convert(Point p, Complexe za, Complexe zb){
        return new Complexe((float)(p.getX()*((Math.max(za.getA(), zb.getA()) - Math.min(za.getA(), zb.getA()))/width) + Math.min(za.getA(), zb.getA())), (float)(p.getY()*((Math.max(za.getB(), zb.getB()) - Math.min(za.getB(), zb.getB()))/height) + Math.min(za.getB(), zb.getB()))); 
    }

    public static void main(String[] args){

        width = 600;
        height = 400;
        widthComplexe = new Complexe(-2, 1);
        heightComplexe = new Complexe(1,-1);
        fenetre = new Fenetre((int)width, (int)height); 

        drawMandelbrot();

    }

    public static void zoom(){
        Complexe a = convert(Fenetre.pressed, widthComplexe, heightComplexe);
        Complexe b = convert(Fenetre.released, widthComplexe, heightComplexe);

        widthComplexe = a;
        heightComplexe = b;

        fenetre.getPanelDessin().listePointMandelbrot.clear();

        drawMandelbrot();
    }

    public static void drawMandelbrot(){

        fenetre.getPanelDessin().removeAll();

        for(int i=0; i<=width; i++){
            for(int j=0; j<=height; j++){

                Point pointsImage = new Point(i, j);
                System.out.println(pointsImage.getX() + ";" + pointsImage.getY());
                if(Mandelbrot.traitementPoint(convert(pointsImage, widthComplexe, heightComplexe))){

                    fenetre.getPanelDessin().listePointMandelbrot.add(pointsImage);
                }

            }
        }
        fenetre.getPanelDessin().repaint();
    }
}