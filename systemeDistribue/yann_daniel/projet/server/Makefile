all:
#kill -9 $$(pidof rmiregistry)
	javac *.java
	rmiregistry &
	java Server


kill:
	kill -9 $$(pidof rmiregistry)

clean:
	rm *.class
	
