package sd.akka.actor;

import java.util.Random;

import akka.actor.AbstractActor;
import akka.actor.ActorRef;
import akka.actor.Props;

public class TelActor extends AbstractActor {
    public ActorRef acteurFils;

    private TelActor(int n) {
        if (n == 0)
            this.acteurFils = null;
        else
            this.acteurFils = getContext().actorOf(props(n - 1));
    }

    @Override
    public Receive createReceive() {
        return receiveBuilder()
                .match(ChangeString.class, message -> changeString(message))
                .build();
    }

    private void changeString(final ChangeString message) {
        String modifiedString = message.execute();
        //if (this.acteurFils == null)
            System.out.println(modifiedString);
            //this.tell(new TelActor.ChangeString(modifiedString), this.acteurFils);
    }

    public static Props props(int n) {
        return Props.create(TelActor.class, n);
    }

    public interface Message {
    }

    public static class ChangeString implements Message {
        String nom;

        public ChangeString(String n) {
            this.nom = n;
        }

        public String execute() {
            char a[] = this.nom.toCharArray();
            Random rand = new Random();
            a[rand.nextInt(a.length)] = (char) ('a' + rand.nextInt(26));
            this.nom = String.valueOf(a);
            return this.nom;
        }
    }
}
