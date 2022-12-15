import java.rmi.*;
public interface BagOfTask extends Remote{
    public void addResult(Mandelbrot m) throws RemoteException;
    public Mandelbrot getTask() throws RemoteException;
}
