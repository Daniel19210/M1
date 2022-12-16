import java.util.ArrayList;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.RemoteException;


public class ImpMandelbrot extends UnicastRemoteObject implements Mandelbrot{

    public ArrayList<Point> data_a_traiter;
    public ArrayList<Task> taches_complete;

    public ImpMandelbrot() throws RemoteException{

        super();

        data_a_traiter = new ArrayList<Point>();
        taches_complete = new ArrayList<Task>();
    }

    public void addTask(Point p) throws RemoteException{

        data_a_traiter.add(p);
    }

    public Task getTask() throws RemoteException{
        
        if(data_a_traiter.size() != 0){
            return (Task) new ImpTask(data_a_traiter.remove(0));
        }
        return null;
    }

    public void addResult(Task t) throws RemoteException{
        taches_complete.add(t);
    }

}