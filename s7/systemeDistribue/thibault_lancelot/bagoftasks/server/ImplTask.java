
package bagoftasks.server;

import bagoftasks.proto.*;

import java.util.*;
import java.rmi.server .*;
import java.net .*;
import java.rmi .*;
import java.io.*;

public class ImplTask implements Serializable, Task {
    private boolean primeNumber;
    private int number;

    public ImplTask(int number) {
        this.primeNumber = false;
        this.number = number;
    }

    public boolean getPrimeNumber() { return this.primeNumber; }
    public int getNumber() { return this.number; }

    public void run() {
        for (int t=2; t<=(int)Math.floor(Math.sqrt(number)); t++)
            if (number%t==0)
                return;
        primeNumber = true;
    }
}
