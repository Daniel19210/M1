import java.rmi.RemoteException;
import java.rmi.Remote;

public interface Task extends Remote{

    public void run() throws RemoteException;
}