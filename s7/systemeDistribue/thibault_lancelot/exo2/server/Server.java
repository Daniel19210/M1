import java.rmi.*;

public class Server{
    public static void main(String[] args) {
        try {
            ImplObjectFactory iof = new ImplObjectFactory();
            for (int l = 0; l < 100; l++)
                iof.addAccount(
                    new ImplAccount(
                        iof.getNewId(), (int)(Math.random()*1000)+100
                ));

            Naming.bind("of", iof);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
