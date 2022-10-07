package fruit.view;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import fruit.controller.Controlleur;;

public class VueGraphiqueSimple extends JFrame {
    private JButton inc;
    private JButton dec;
    private JLabel affiche;

    public VueGraphiqueSimple() {
        inc.setName("Plus");
        dec.setName("Moins");
        affiche.setName("affichage");
    }

    public JLabel getAffiche() {
        return this.affiche;
    }

    public void setAffiche(JLabel affiche) {
        this.affiche = affiche;
    }

    public JButton getInc() {
        return this.inc;
    }

    public JButton getDec() {
        return this.dec;
    }

    public void update() {
        this.pack();
        this.setVisible(true);
    }

    public void ajoutControlleur(Controlleur c) {
        getInc().addActionListener(c);
        getDec().addActionListener(c);
    }
}
