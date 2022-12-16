import java.rmi.RemoteException;
import java.rmi.Remote;

public interface Task extends Remote{

    public void run() throws RemoteException;
    public boolean getAppartient_mandelbrot() throws RemoteException;
    public Point getPoint_a_traiter() throws RemoteException;
}