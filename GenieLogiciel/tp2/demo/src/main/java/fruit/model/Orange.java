package fruit.model;

public class Orange implements Fruit {
    private Double prix;
    private String origine;
    private Boolean isSeedless;

    public Orange(Double prix, String origine) {
        this.prix = prix;
        this.origine = origine;
    }

    public Double getPrix() {
        return this.prix;
    }

    public void setPrix(Double prix) {
        this.prix = prix;
    }

    public void setOrigine(String origine) {
        this.origine = origine;
    }

    public String getOrigine() {
        return this.origine;
    }

    public Boolean isSeedless() {
        return this.isSeedless;
    }

    public Boolean equals(Fruit o) {
        return o.getClass() == this.getClass() &&
                o.getPrix() == this.prix &&
                o.getOrigine() == this.origine &&
                o.isSeedless() == this.isSeedless;
    }

    public String toString() {
        String res = "Orange à " + this.prix + " provenant de " + this.origine;
        return this.isSeedless == true ? res + " qui a des pépins." : res + " qui n'a pas de pépins";
    }
}
