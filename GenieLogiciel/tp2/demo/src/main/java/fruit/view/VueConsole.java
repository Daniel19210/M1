package fruit.view;

import java.util.Observer;
import java.util.Observable;

public class VueConsole implements Observer{
    private String trace;

    public VueConsole() {
        this.trace = "";
    }

    public String getTrace() {
        return this.trace;
    }

    public void setTrace(String trace) {
        this.trace = trace;
    }

    public void update(Observable o, Object arg){
    }
}
