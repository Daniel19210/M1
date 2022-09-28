package server;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

import compute.*;

public class ImplTask extends UnicastRemoteObject implements Task {
    private boolean isPrime = false;
    private int number;

    public ImplTask(int number) throws RemoteException { this.number = number; }

    public boolean getResult() { return this.isPrime; }

    public int getNumber() { return this.number; }

    public String showTask() { return isPrime ? this.number + "is a prime" : this.number + "is not a prime"; }

    public void run() {
        for (int t=2; t<=(int)Math.floor(Math.sqrt(number)); t++)
            if (number%t==0)
                return;
        this.isPrime = true;
    }
}
