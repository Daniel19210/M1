/*SERVER CLASS*/
import java.io.*;
import java.net.*;

public class server {

  public static void main(String args[]) throws IOException {
    // Initialisation des variables
    int portServeur = Integer.parseInt(args[0]);
    int portClient = 20000;
    int taillePaquet = 10;
    byte b[] = new byte[taillePaquet];
    DatagramSocket dsoc = new DatagramSocket(portServeur);
    FileOutputStream f = new FileOutputStream(args[1]);

    while (true) {
      DatagramPacket dp = new DatagramPacket(b, b.length);
      dsoc.receive(dp);

      // Affichage des informations sur le paquet
      System.out.println("Numéro du paquet : " + dp.getData()[0]);
      System.out.println("Taille du paquet = "+ dp.getLength());
      System.out.println("Contenu du paquet: " + new String(b));
      f.write(dp.getData(), 1, dp.getLength() - 1); // Ecriture dans le fichier

      // Renvoi de l'acquittement
      String ack = "Paquet n°" + (dp.getData()[0] + " reçu.\n"); 
      dsoc.send(new DatagramPacket(ack.getBytes(), ack.getBytes().length, InetAddress.getLocalHost(), portClient));
    }
  }
}
