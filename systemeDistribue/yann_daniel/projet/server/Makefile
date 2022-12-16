all:
#kill -9 $$(pidof rmiregistry)
	javac *.java
	./rmi.sh
	java Server


kill:
	kill -9 $$(pidof rmiregistry)

clean:
	rm *.class
	
