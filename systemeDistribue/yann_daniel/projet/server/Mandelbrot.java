
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Mandelbrot extends Remote{

    boolean traitementPoint(int tache) throws RemoteException;
    int getNbTache() throws RemoteException;
    void paint() throws RemoteException;
}