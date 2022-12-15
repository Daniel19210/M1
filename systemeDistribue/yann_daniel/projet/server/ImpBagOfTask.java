import java.util.*;

import java.rmi.server .*;
import java.net .*;
import java.rmi .*;

public class ImpBagOfTask extends UnicastRemoteObject implements BagOfTask {
    private Queue<Mandelbrot> listTask;
    private int numberCurrent;

    public ImpBagOfTask() throws RemoteException {
        listTask = new LinkedList<Mandelbrot>();
        numberCurrent = 2;
    }

    public void addResult(Mandelbrot m) throws RemoteException { listTask.add(m); }

    public Mandelbrot getTask() throws RemoteException {
        return (Mandelbrot)(new ImpMandelbrot(numberCurrent++));
    }

    public String toString() {
        String s = "";
        for (Mandelbrot t : listTask)
            if (((ImpMandelbrot)t).traitementPoint())
                s += "" + ((ImplTask)t).getNumber() + " ";
        return s;
    }
}

