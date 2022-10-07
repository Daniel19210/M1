package fruit.model;

import java.util.ArrayList;
import java.util.Observable;

import fruit.model.Fruit;

public class Panier extends Observable{
    private Integer contMax;
    private ArrayList<Fruit> fruits;

    public Panier(int max){
        this.contMax = max;
        fruits = new ArrayList<>();
    }

    public Integer getContMax() {
        return this.contMax;
    }

    public void setContMax(Integer contMax) {
        this.contMax = contMax;
    }

    public ArrayList<Fruit> getFruits() {
        return this.fruits;
    }

    public void setFruits(ArrayList<Fruit> fruits) {
        this.fruits = fruits;
    }

    public Boolean estVide(){
        return this.getFruits().size() == 0;
    }

    public Boolean estPlein(){
        return this.getFruits().size() == this.contMax;
    }

    public void ajoute(){
        setChanged();
        notifyObservers(this);
    }

    public void ajoute(Fruit f){
        this.getFruits().add(f);
        ajoute();
    }

    public void retire(){
        this.fruits.remove(this.fruits.size()-1);
        setChanged();
        notifyObservers(this);
    }

    public String toString(){
        String res = "Un panier de " + this.fruits.size() + "fruits: ";
        for (Fruit f : this.getFruits()){
            res += f.toString() + "\n";
        }
        return res;
    }

    public Boolean equals(Panier o){
        return this.getClass() == o.getClass() &&
                this.getFruits().equals(o.getFruits()) &&
                this.getContMax() == o.getContMax();
    }
}
