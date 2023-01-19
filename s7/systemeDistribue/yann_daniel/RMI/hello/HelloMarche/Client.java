import java.rmi.registry.LocateRegistry; 
import java.rmi.registry.Registry;  

public class Client { 

   private Client() {} 
   
   public static void main(String[] args) {  
      try {  
         // Récupérer le registre
         Registry reg = LocateRegistry.getRegistry(null); 
    
         // Recherche dans le registre de l'objet distant
         Hello stub = (Hello) reg.lookup("Hello"); 
    
         // Appel de la méthode distante à l'aide de l'objet obtenu
         stub.showMsg(); 
         
      } catch (Exception e) {
         System.err.println(e.toString()); 
         e.printStackTrace(); 
      } 
   } 
}