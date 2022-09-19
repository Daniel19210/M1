
import java.rmi.*;

public interface Hello extends Remote {
    public String ditBonjour() throws java.rmi.RemoteException;
}

interface Compte extends Remote {
    public void depot() throws java.rmi.RemoteException;
    public void retrait() throws java.rmi.RemoteException;
    public int getSolde() throws java.rmi.RemoteException;
}

interface ObjFact extends Remote {
    public Compte getComptId(int id) throws java.rmi.RemoteException;
}
