package compute;
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface BagOfTasks extends Remote {
     public void addTask() throws RemoteException;
     public void addResult(Task t) throws RemoteException;
     public Task getTask() throws RemoteException;
     public void showTasks() throws RemoteException;
}
