SRC=Server.java ImpMandelbrot.java Complexe.java Fenetre.java Mandelbrot.java Panneau.java Point.java

all:
	javac $(SRC)
	rmiregistry &
	java Server

kill:
	kill -9 $$(pidof rmiregistry)

client:
	javac Client.java
	java Client &
	java Client &
	java Client &
	java Client &


clean:
	rm -f *.class
