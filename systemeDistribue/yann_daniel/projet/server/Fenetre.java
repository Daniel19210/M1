import javax.swing.JFrame;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.event.*;

public class Fenetre extends JFrame{

    private JPanel container = new JPanel();
    private Panneau panel = new Panneau();
    public Point pressed = new Point();
    public Point released = new Point();
    public Complexe c1 = new Complexe();
    public Complexe c2 = new Complexe();

    public Fenetre(int x, int y){

        this.setTitle("Mandelbroot");
        this.setSize(x,y+50);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Gestion clic souris
        panel.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e){
                if(e.getButton()==1){
                    System.out.println("clic souris : " + e.getX() + ";" + e.getY());
                    pressed.setX(e.getX());
                    pressed.setY(e.getY());
                    c1 = convert(pressed);
                }
            }

            @Override
            public void mouseReleased(MouseEvent e){

                if(e.getButton() == 1){
                    System.out.println("clic souris : " + e.getX() + ";" + e.getY());
                    released.setX(e.getX());
                    released.setY(e.getY());
                    c2 = convert(released);

                    Constantes.widthComplexe = c1;
                    Constantes.heightComplexe = c2;

                    try{
                        Server.draw();
                    }catch(Exception exe){exe.printStackTrace();}
                    //index.zoom();
                }
                else if(e.getButton() == 3){
                    //index.resetFenetre();
                }
            }
        });

        container.setLayout(new BorderLayout());
        container.add(panel, BorderLayout.CENTER);

        this.setContentPane(container);

        this.setVisible(true);
    }

    public Panneau getPanelDessin(){return this.panel;}

    public Complexe convert(Point p){

        double intervalleFenetreWidth = (Math.max(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()) - Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()));
        double intervalleFenetreHeight = (Math.max(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()) - Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()));

        double decalImageX = Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA());
        double decalImageY = Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB());

        return new Complexe((double)(p.getX()*((double)intervalleFenetreWidth/(double)Constantes.width) + decalImageX), (double)(p.getY()*((double)intervalleFenetreHeight/(double)Constantes.height) + decalImageY)); 
    }
}