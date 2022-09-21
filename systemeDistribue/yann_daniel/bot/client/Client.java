package client;
import java.rmi.*;

import compute.*;

public class Client {
    public static void main(String[] args) {
        try {
            String name = "sac";
            BagOfTasks bag = (BagOfTasks) Naming.lookup(name);
            Task t = bag.getTask();
            t.run();
            System.out.println("Client exécute la tache: " + t.showTask());
            bag.addResult(t);
            System.out.println("Les taches complétées");
            bag.showTasks();
        } catch (Exception e) {
            System.err.println("Bag of tasks exception: " + e.getMessage() + "\n");
            e.printStackTrace();
        }
    }
}

