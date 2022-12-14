import javax.swing.JFrame;
import javax.swing.JPanel;

import java.awt.BorderLayout;

public class Fenetre extends JFrame{

    private JPanel container = new JPanel();
    private Panneau panel = new Panneau();

    public Fenetre(){

        this.setTitle("Mandelbroot");
        this.setSize(600,400);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        container.setLayout(new BorderLayout());
        container.add(panel, BorderLayout.CENTER);

        this.setContentPane(container);

        this.setVisible(true);
    }
}