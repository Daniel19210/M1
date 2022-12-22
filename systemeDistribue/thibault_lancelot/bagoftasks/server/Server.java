package bagoftasks.server;

import java.rmi.*;

public class Server {
    public static void main(String[] args) {
        try {
            ImplBagOfTasks ibt = new ImplBagOfTasks();
            Naming.bind("ibt", ibt);
            try {
                int time = 5;
                int time_temp = 0;
                while (true) {
                    System.out.println( ""+(time_temp++*time)+"s : \t"+ibt);
                    Thread.sleep(time*1000);
                }
            } catch(Exception e) {
                e.printStackTrace();
            }


        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}