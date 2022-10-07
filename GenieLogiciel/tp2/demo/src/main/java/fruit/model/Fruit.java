package fruit.model;

public interface Fruit {
    Boolean isSeedless();

    Double getPrix();

    String getOrigine();

    Boolean equals(Fruit f);

    String toString();
}
