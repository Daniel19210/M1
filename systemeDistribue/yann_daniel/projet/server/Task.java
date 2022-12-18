import java.rmi.RemoteException;
import java.rmi.Remote;

public interface Task extends Remote{

    public void run() throws RemoteException;
    public Point getPoint_a_traiter() throws RemoteException;
    public int getDivergence() throws RemoteException;
}