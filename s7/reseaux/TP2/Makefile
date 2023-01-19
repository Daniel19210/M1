# Pour lancer le code, lancer 2 terminaux. Lancer la commande 'make' dans l'un puis 'make client' dans l'autre
PORT=50000
TAILLEPAQUET=10

serveur:
	javac server.java
	javac client.java
	java server $(PORT) reception.txt

client:
	java client $(PORT) $(TAILLEPAQUET)

clean:
	rm *.class reception.txt
