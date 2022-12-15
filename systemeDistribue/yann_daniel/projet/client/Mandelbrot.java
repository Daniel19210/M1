import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Mandelbrot extends Remote{

    boolean traitementPoint() throws RemoteException;

}