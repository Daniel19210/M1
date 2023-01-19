import java.util.*;
import java.rmi.server .*;
import java.net .*;
import java.rmi .*;

class ImplAccount extends UnicastRemoteObject implements Account {
    private int balance;
    private final int id;

    public ImplAccount(int balance, int id) throws RemoteException
    {
        super();
        this.balance = balance;
        this.id = id;
    }

    public int getBalance() throws RemoteException { return this.balance; }
    public int getId() throws RemoteException { return this.id; }

    public void addBalance(int balance) throws RemoteException
    {
        if(balance < 0) return;
        this.balance += balance;
    }
    public void subBalance(int balance) throws RemoteException
    {
        if(balance < 0) return;
        if(balance > this.balance) return;
        this.balance -= balance;
    }

    public String toStrings() throws RemoteException{
        return "" + this.balance;
    }
}

class ImplObjectFactory extends UnicastRemoteObject implements ObjectFactory {
    Map<Integer, Account> listAccounts;

    public ImplObjectFactory() throws RemoteException
    {
        super();
        listAccounts = new HashMap<Integer, Account>();
    }

    public int getNewId() throws RemoteException
    {
        int id;
        while (listAccounts.containsKey(id = (int)(Math.random()*10000))) ;
        return id;
    }

    public void addAccount(Account account) throws RemoteException
    {
        listAccounts.put(account.getId(), account);
    }

    public Account getAccount(int idAccount) throws RemoteException
    {
        if(!listAccounts.containsKey(idAccount)) return null;
        return listAccounts.get(idAccount);
    }

    public String toStrings() throws RemoteException
    {
        String res = "";
        for (Map.Entry me : listAccounts.entrySet())
            res += "clé: " + me.getKey() + " | valeur: " + ((Account)me.getValue()).toStrings() + "\n";
        return res;
    }
}
