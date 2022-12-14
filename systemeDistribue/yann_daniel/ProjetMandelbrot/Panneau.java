import javax.swing.JPanel;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;

public class Panneau extends JPanel{

    ArrayList<Point> points = new ArrayList<Point>();

    public Panneau(){

        this.setBackground(Color.white);
        this.points.add(new Point(20, 300));

    }
    
    public void paintComponent(Graphics g){
        g.setColor(Color.black);
        for(Point p:points){
            g.drawLine(p.getX(), p.getY(), p.getX(), p.getY());
        }
    }
}