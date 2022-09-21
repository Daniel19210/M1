
//javac -cp . bagoftasks/proto/*.java
//javac -cp . bagoftasks/client/*.java
//javac -cp . bagoftasks/server/*.java

//manifest.txt -> Main-Class: bagoftasks/server/Server
//jar -cvfm server.jar manifest.txt bagoftasks/

//manifest.txt -> Main-Class: bagoftasks/client/Client
//jar -cvfm server.jar manifest.txt bagoftasks/


package bagoftasks.client;

import java.rmi.*;
import bagoftasks.proto.*;

public class Client{
    public static void main(String[] args) {
        try {
            BagOfTasks ibt = (BagOfTasks)Naming.lookup("ibt");
            Task t = ibt.getTask();
            t.run();
            ibt.addResult(t);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
