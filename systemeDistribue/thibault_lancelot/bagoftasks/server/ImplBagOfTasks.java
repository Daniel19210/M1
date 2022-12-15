
package bagoftasks.server;

import bagoftasks.proto.*;

import java.util.*;

import java.rmi.server .*;
import java.net .*;
import java.rmi .*

public class ImplBagOfTasks extends UnicastRemoteObject implements BagOfTasks {
    private Queue<Task> listTask;
    private int numberCurrent;

    public ImplBagOfTasks() throws RemoteException {
        listTask = new LinkedList<Task>();
        numberCurrent = 2;
    }

    public void addResult(Task t) throws RemoteException { listTask.add(t); }

    public Task getTask() throws RemoteException {
        return (Task)(new ImplTask(numberCurrent++));
    }

    public String toString() {
        String s = "";
        for (Task t : listTask)
            if (((ImplTask)t).getPrimeNumber())
                s += "" + ((ImplTask)t).getNumber() + " ";
        return s;
    }
}
