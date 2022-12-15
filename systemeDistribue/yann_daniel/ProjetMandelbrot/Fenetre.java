import javax.swing.JFrame;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.event.*;

public class Fenetre extends JFrame{

    private JPanel container = new JPanel();
    private Panneau panel = new Panneau();
    public static Point pressed = new Point();
    public static Point released = new Point();

    public Fenetre(int x, int y){

        this.setTitle("Mandelbroot");
        this.setSize(x,y);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        panel.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e){
                System.out.println("clic souris : " + e.getX() + ";" + e.getY());
                pressed.setX(e.getX());
                pressed.setY(e.getY());
            }

            @Override
            public void mouseReleased(MouseEvent e){

                System.out.println("clic souris : " + e.getX() + ";" + e.getY());
                released.setX(e.getX());
                released.setY(e.getY());
                index.zoom();
            }
        });

        container.setLayout(new BorderLayout());
        container.add(panel, BorderLayout.CENTER);

        this.setContentPane(container);

        this.setVisible(true);
    }

    public Panneau getPanelDessin(){return this.panel;}
}