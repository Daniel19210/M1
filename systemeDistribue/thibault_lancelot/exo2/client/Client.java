import java.rmi.*;

public class Client{
    public static void main(String[] args)
    {
        try {
            ObjectFactory iof = (ObjectFactory)Naming.lookup("of");
            System.out.println(iof.toStrings());
        } catch(Exception e) {
            e.printStackTrace();
        }

    }
}
