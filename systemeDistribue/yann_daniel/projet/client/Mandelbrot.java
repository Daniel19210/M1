
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Mandelbrot extends Remote{

    public void addTask(Point p) throws RemoteException;
    public void addResult(Task t) throws RemoteException;
    public Task getTask() throws RemoteException;
}