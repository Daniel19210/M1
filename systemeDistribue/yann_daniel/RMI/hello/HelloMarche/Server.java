import java.rmi.RemoteException; 
import java.rmi.registry.Registry; 
import java.rmi.registry.LocateRegistry; 
import java.rmi.server.UnicastRemoteObject; 

public class Server extends ImpClasse { 

   public Server() {} 
   
   public static void main(String args[]) { 
      try { 
         // crée l'objet distant
         ImpClasse obj = new ImpClasse(); 

         // ici, nous exportons l'objet distant vers le stub
         Hello stub = (Hello) UnicastRemoteObject.exportObject(obj, 0);  

         // Liaison de l'objet distant (stub) dans le Registre
         Registry reg = LocateRegistry.getRegistry(); 

         reg.bind("Hello", stub);  
         System.out.println("Le Serveur est prêt..."); 
      } catch (Exception e) { 
         System.err.println(e.toString()); 
         e.printStackTrace(); 
      } 
   } 
}