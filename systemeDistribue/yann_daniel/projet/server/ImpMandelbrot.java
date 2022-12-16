import java.util.ArrayList;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.RemoteException;


public class ImpMandelbrot extends UnicastRemoteObject implements Mandelbrot{

    public ArrayList<Point> data_a_traiter;
    public ArrayList<Task> taches_complete;
    public int nbTaskGiven;

    public ImpMandelbrot() throws RemoteException{

        super();

        data_a_traiter = new ArrayList<Point>();
        taches_complete = new ArrayList<Task>();
        nbTaskGiven = -1;
    }

    public void addTask(Point p) throws RemoteException{

        data_a_traiter.add(p);
    }

    public Task getTask() throws RemoteException{
        nbTaskGiven++;
        return (data_a_traiter.size() > nbTaskGiven) ? (Task) new ImpTask(data_a_traiter.get(nbTaskGiven)) : null;
    }

    public void addResult(Task t) throws RemoteException{
        taches_complete.add(t);
    }

}