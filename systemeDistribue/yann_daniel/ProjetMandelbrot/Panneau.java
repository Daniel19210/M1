import javax.swing.JPanel;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;

public class Panneau extends JPanel{

    ArrayList<Point> points = new ArrayList<Point>();

    public Panneau(){

        this.setBackground(Color.white);
        this.points.add(new Point());

    }
    
    public void paintComponent(Graphics g){
        g.setColor(Color.red);
        for(Point p:points){
            g.fillOval(p.getX(), p.getY(), 20, 20);
        }
    }
}