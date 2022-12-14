import javax.swing.JPanel;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;

public class Panneau extends JPanel{

    public ArrayList<Point> listePointMandelbrot = new ArrayList<Point>();

    public Panneau(){

        this.setBackground(Color.white);
    }
    
    public void paintComponent(Graphics g){
        g.setColor(Color.black);
        for(Point p : listePointMandelbrot){
            g.drawLine(p.getX(), p.getY(), p.getX(), p.getY());
        }
    }
}