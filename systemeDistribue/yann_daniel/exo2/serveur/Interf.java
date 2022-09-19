import java.rmi.*;

interface Compte extends Remote {
    public void depot(float montant) throws RemoteException;

    public void retrait(float montant) throws RemoteException;

    public String afficherSolde() throws RemoteException;
}

interface CompteFactory extends Remote {
    public void createCompte() throws RemoteException;

    public Compte getCompte(int id) throws RemoteException;

    public void afficherCompte() throws RemoteException;
}