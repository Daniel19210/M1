package compute;
import java.io.Serializable;

public interface Task extends Serializable {
    public void run();
    public String showTask();
}
