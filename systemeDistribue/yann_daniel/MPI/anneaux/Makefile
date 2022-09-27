a:
	mpicc -o anneaux.binary anneaux.c
	mpirun -hostfile cluster.txt -np 70 ./anneaux.binary

clean:
	rm *.binary