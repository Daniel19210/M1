
import java.rmi.server.*;
import java.net.*;
import java.rmi.*;
import java.util.*;


public class ImpServeurHello extends UnicastRemoteObject implements Hello {
    public ImpServeurHello () throws RemoteException {
        super ();
    }
    public String ditBonjour () throws RemoteException {
        return "bonjour a tous";
    }
    public static void main(String arg []) {
        try {

            ImplObjFact of = new ImplObjFact();
            for (int t=0; t<10; t++) {
                ImplCompte c = new ImplCompte();
                c.solde = t*100;
                of.compte.add(c);
            }


            ImpServeurHello s=new ImpServeurHello ();
            String nom="objfact";
            Naming.rebind(nom ,of);
            System.out.println("Serveur enregistr");
        }
        catch (Exception e){System.err.println("Erreur :"+e);}
    }
}

class ImplCompte extends UnicastRemoteObject implements Interface {
    public ImplCompte() throws RemoteException {super();}
    public int solde;
    public void depot() throws java.rmi.RemoteException {solde+=100;}
    public void retrait() throws java.rmi.RemoteException {solde-=100;}
    public int getSolde() throws java.rmi.RemoteException {return solde;}
}

class ImplObjFact extends UnicastRemoteObject implements ObjFact{
    public ImplObjFact() throws RemoteException {super();}
    public ArrayList<Interface> compte = new ArrayList<Interface>();
    public Interface getComptId(int id) throws java.rmi.RemoteException {return compte.get(id);}
}
