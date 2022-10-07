package fruit.controller;

import java.awt.event.*;
import fruit.model.Panier;

public class Controlleur implements ActionListener{
    private Panier p;

    public Controlleur(){
        this.p = new Panier(0);
    }

    public void setPanier(Panier p){
        this.p = p;
    }
    
    public void actionPerformed(ActionEvent e){
        e.getSource().getName().equals("Plus") ? p.ajoute() : p.retire();
    }
}
