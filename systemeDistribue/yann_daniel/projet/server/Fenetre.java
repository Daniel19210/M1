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

        this.setTitle("Mandelbrot");
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

                    //on modifie les coordonnées de l'intervalle complexe lors d'un zoom
                    Constantes.widthComplexe = c1;
                    Constantes.heightComplexe = c2;

                    //On modifie l'intervalle d'affichage de l'image dans le plan complexe
                    Constantes.calculCoordPlan();

                    try{
                        Server.draw();
                    }catch(Exception exe){exe.printStackTrace();}
                    //index.zoom();
                }
                else if(e.getButton() == 3){
                    //index.resetFenetre();
                    Constantes.widthComplexe.setA(-2);
                    Constantes.widthComplexe.setB(1);
                    Constantes.heightComplexe.setA(1);
                    Constantes.heightComplexe.setB(-1);

                    Constantes.calculCoordPlan();

                    try{
                        Server.draw();
                    }catch(Exception exe){exe.printStackTrace();}
                }
            }
        });

        container.setLayout(new BorderLayout());
        container.add(panel, BorderLayout.CENTER);

        this.setContentPane(container);

        this.setVisible(true);
    }

    public Panneau getPanelDessin(){return this.panel;}

    //on converti un point en son équivalent complexe dans l'intervalle donnée
    public Complexe convert(Point p){

        return new Complexe((double)(p.getX()*((double)Constantes.intervalleFenetreWidth/(double)Constantes.width) + Constantes.decalImageX),
            (double)(p.getY()*((double)Constantes.intervalleFenetreHeight/(double)Constantes.height) + Constantes.decalImageY));
    }
}