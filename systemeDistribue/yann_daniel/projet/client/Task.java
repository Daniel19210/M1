import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Task extends Remote{

    public void run() throws RemoteException;
    public Point getPoint_a_traiter() throws RemoteException;
    public int getDivergence() throws RemoteException;
}