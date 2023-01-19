import java.rmi .*;

interface Account extends Remote {
    public int getBalance() throws RemoteException;
    public int getId() throws RemoteException;
    public void addBalance(int balance) throws RemoteException;
    public void subBalance(int balance) throws RemoteException;
    public String toStrings() throws RemoteException;
}

interface ObjectFactory extends Remote {
    public Account getAccount(int idAccount) throws RemoteException;
    public int getNewId() throws RemoteException;
    public void addAccount(Account account) throws RemoteException;
    public String toStrings() throws RemoteException;
}
