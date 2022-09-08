s:
	javac serv/CompteFactoryImpl.java
	#rmic ImpServeurHello
	rmiregistry &
	java ImpServeurHello

c:
	javac ../client/ClientHello.java
	java ../client/ClientHello

clean:
	rm client/*.class serveur/*.class *.class
