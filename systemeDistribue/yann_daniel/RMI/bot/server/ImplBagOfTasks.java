package server;

import java.rmi.*;
import java.rmi.server.*;
import java.util.*;

import compute.*;

public class ImplBagOfTasks extends UnicastRemoteObject implements BagOfTasks {
    private Queue<Integer> data;
    private ArrayList<Task> completedTasks;

    public ImplBagOfTasks() throws RemoteException {
        super();
        this.completedTasks = new ArrayList<Task>();
        this.data = new LinkedList<Integer>();
    }

    public void addTask() throws RemoteException { this.data.add((int) Math.random() * 100); }

    public Task getTask() throws RemoteException { return (Task) new ImplTask(data.remove()); }

    public void addResult(Task t) throws RemoteException { this.completedTasks.add(t); }

    public void showTasks() {
        for (Task t : this.completedTasks)
            System.out.println("Task: " + t.showTask());
    }
}
