import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Task extends Remote{

    public void run() throws RemoteException;
}