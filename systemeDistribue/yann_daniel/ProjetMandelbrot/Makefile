SRC=Server.java ImpMandelbrot.java Complexe.java Fenetre.java Mandelbrot.java Panneau.java Point.java

all:
	javac $(SRC)
	rmiregist
	java Server

client:
	javac Client.java
	java client &
	java client &
	java client &
	java client &
	java client &


clean:
	rm -f *.class