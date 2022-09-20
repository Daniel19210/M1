import java.rmi.server.*;
import java.util.*;
import java.rmi.*;

class CompteImpl extends UnicastRemoteObject implements Compte {
    public class Operation {
        String operation;
        float montant;

        public Operation(String op, float mt) {
            this.operation = op;
            this.montant = mt;
        }
    }

    float solde;
    ArrayList<Operation> historique;

    public CompteImpl(float solde) throws RemoteException {
        super();
        this.solde = solde;
        historique = new ArrayList<Operation>();
    }

    public void depot(float montant) throws RemoteException {
        if (montant > 0) {
            this.solde += montant;
            this.historique.add(new Operation("dépot", montant));
        } else
            throw new RemoteException("Impossible de faire un dépot négatif");
    }

    public void retrait(float montant) throws RemoteException {
        if (montant > 0) {
            if (this.solde - montant > 0) {
                this.solde -= montant;
                this.historique.add(new Operation("retrait", montant));
            } else
                return;
        } else
            return;
    }

    public String afficherSolde() {
        return String.valueOf(this.solde);
    }
}

class CompteFactoryImpl extends UnicastRemoteObject implements CompteFactory {
    Map<Integer, CompteImpl> listCompte;

    public CompteFactoryImpl() throws RemoteException {
        super();
        listCompte = new HashMap<Integer, CompteImpl>();
    }

    public void createCompte() throws RemoteException {
        int id = 0;
        while (listCompte.containsKey(id += 1))
            ;
        listCompte.put(id, new CompteImpl(100));
    }

    public Compte getCompte(int id) throws RemoteException {
        return this.listCompte.get(id);
    }

    public void afficherCompte() throws RemoteException {
        for (Map.Entry<Integer, CompteImpl> compte : listCompte.entrySet())
            System.out.println("Solde: " + compte.getValue().afficherSolde() + "\tId: " + compte.getKey());
    }

    public void afficherCompte(Integer id) throws RemoteException {
        System.out.println("Solde: " + this.listCompte.get(id).afficherSolde() + "\tId: " + id);
    }
}