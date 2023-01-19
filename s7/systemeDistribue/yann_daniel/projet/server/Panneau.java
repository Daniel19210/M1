import javax.swing.JPanel;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;

public class Panneau extends JPanel{

    public ArrayList<Point> listePointMandelbrot = new ArrayList<Point>();

    public Panneau(){

        this.setBackground(Color.white);
    }
    
    //Methode de dessin de awt dessine les points appartenant a l'ensemble de Mandelbrot
    public void paintComponent(Graphics g){
        g.clearRect(0,0,Constantes.width,Constantes.height);
        for(Point p : listePointMandelbrot){
            g.setColor(p.getColor());
            g.drawLine(p.getX(), p.getY(), p.getX(), p.getY());
        }
    }
}