/*CLIENT CLASS*/
import java.io.*;
import java.net.*;

public class client {
  
  // Permet d'envoyer un paquet et d'attendre un paquet en retour
  static void sendPaquet(DatagramSocket soc, byte[] pB, int tailleP, int portS, int portC){
    byte reponse[] = new byte[100]; // L'acquittement est de taille fixe
    try {
      soc.send( new DatagramPacket( pB, tailleP, InetAddress.getLocalHost(), portS));
      soc.receive(new DatagramPacket(reponse, 100, InetAddress.getLocalHost(), portC));
      System.out.print("reponse = " + new String(reponse));
    } catch (IllegalArgumentException arg) {
      arg.printStackTrace();
    } catch (IOException io){
      io.printStackTrace();
    }
  }
  public static void main(String args[]) throws Exception {
    // Initialisation des variables
    int portServeur = Integer.parseInt(args[0]);
    int portClient = 20000;
    int taillePaquet = Integer.parseInt(args[1]);
    byte paquetByte[] = new byte[taillePaquet];
    byte numPaquet = 0;
    int indiceByte = 0;
    FileInputStream file = new FileInputStream("message.txt");
    DatagramSocket dsoc = new DatagramSocket(portClient);

    paquetByte[0] = numPaquet++; // Ajout du numéro de paquet
    for (indiceByte = 1; file.available() != 0; indiceByte++) {
      if (indiceByte == taillePaquet){ // Dans le cas où le fichier n'est pas fini mais la taille de paquet est trop petite
        sendPaquet(dsoc, paquetByte, taillePaquet, portServeur, portClient);
        paquetByte = new byte[taillePaquet];
        paquetByte[0] = numPaquet++;
        indiceByte = 1;
      }
      paquetByte[indiceByte] = (byte) file.read();
    }
    file.close();

    sendPaquet(dsoc, paquetByte, taillePaquet, portServeur, portClient);
    dsoc.close();
    System.out.println("Tout les paquets ont été émis et reçu");
  }
}
