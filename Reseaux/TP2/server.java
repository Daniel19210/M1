/*SERVER CLASS*/
import java.net.*;
import java.io.*;
public class server
{
            public static void main(String args[])throws IOException
            {
                        byte b[]=new byte[66000];
                        DatagramSocket dsoc=new DatagramSocket(Integer.parseInt(args[0]));
                        FileOutputStream f=new FileOutputStream(args[1]);
                        while(true)
                        {
                                    DatagramPacket dp=new DatagramPacket(b,b.length);
                                    dsoc.receive(dp);
                                    System.out.println(new String(b));
                                    f.write(b);
                                    System.out.println(dp.getLength());                             

                        }
            }
}

