package server;
import java.rmi.*;
import compute.*;

public class Serveur {
    public static void main(String[] args) {
        String name = "sac";
        try {
            ImplBagOfTasks bag = new ImplBagOfTasks();
            for (int i = 0; i < 10; i++)
                bag.addTask();
            Naming.bind(name, bag);
            System.out.println("Bag of tasks enregistré");
        } catch (Exception e) {
            System.err.println("Bag of tasks exception: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
