package sd.akka.actor;

import java.util.Random;

import akka.actor.AbstractActor;
import akka.actor.Props;

public class TelActor extends AbstractActor {
    private TelActor() {
    }

    @Override
    public Receive createReceive() {
        return receiveBuilder()
                .match(ChangeString.class, message -> changeString(message))
                .build();
    }

    private void changeString(final ChangeString message) {
        System.out.println(message.execute());
    }

    public static Props props() {
        return Props.create(TelActor.class);
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
