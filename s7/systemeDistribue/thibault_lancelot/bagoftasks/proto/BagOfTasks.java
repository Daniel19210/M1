package bagoftasks.proto;

import java.rmi.*;
import bagoftasks.proto.*;

public interface BagOfTasks extends Remote {
    public void addResult(Task t) throws RemoteException;
    public Task getTask() throws RemoteException;
}
