import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.*;

public class index{

    private static float width, height;
    private static Complexe widthComplexe, heightComplexe;
    private static Fenetre fenetre;

    //Convertit un pixel (ou point) de l'image en coordonnée complexe pour dessin mandelbrot
    public static Complexe convert(Point p){

        float intervalleFenetreWidth = (Math.max(widthComplexe.getA(), heightComplexe.getA()) - Math.min(widthComplexe.getA(), heightComplexe.getA()));
        float intervalleFenetreHeight = (Math.max(widthComplexe.getB(), heightComplexe.getB()) - Math.min(widthComplexe.getB(), heightComplexe.getB()));

        float decalImageX = Math.min(widthComplexe.getA(), heightComplexe.getA());
        float decalImageY = Math.min(widthComplexe.getB(), heightComplexe.getB());

        return new Complexe((float)(p.getX()*(intervalleFenetreWidth/width) + decalImageX), (float)(p.getY()*(intervalleFenetreHeight/height) + decalImageY)); 
    }

    public static void main(String[] args){

        width = 400;
        height = 200;
        widthComplexe = new Complexe(-2, 1);
        heightComplexe = new Complexe(1,-1);
        fenetre = new Fenetre((int)width, (int)height); 

        drawMandelbrot();

    }

    //Gere le zoom sur interface graphique manelbrot
    public static void zoom(){
        Complexe a = convert(Fenetre.pressed);
        Complexe b = convert(Fenetre.released);

        widthComplexe = a;
        heightComplexe = b;

        fenetre.getPanelDessin().listePointMandelbrot.clear();

        drawMandelbrot();
    }

    //appel la methode pour verifier si un point c appartient à l'ensemble de mandelbrot puis appel la methode de dessin
    public static void drawMandelbrot(){

        fenetre.getPanelDessin().removeAll();

        for(int i=0; i<=width; i++){
            for(int j=0; j<=height; j++){

                Point pointsImage = new Point(i, j);
                int pourcentageAvance = (int)(i/width*100);
                System.out.println(pourcentageAvance + "%");
                if(Mandelbrot.traitementPoint(convert(pointsImage))){

                    fenetre.getPanelDessin().listePointMandelbrot.add(pointsImage);
                }

            }
        }
        fenetre.getPanelDessin().repaint();
    }

    //Dezoom l'image au maximum
    public static void resetFenetre(){
        widthComplexe.setA(-2);
        widthComplexe.setB(1);
        heightComplexe.setA(1);
        heightComplexe.setB(-1);

        fenetre.getPanelDessin().listePointMandelbrot.clear();

        drawMandelbrot();
    }
}