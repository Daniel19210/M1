c:
	mpicc -o pingpong pingpong.c
	mpirun -hostfile cluster.txt -np 70 ./pingpong

a:
	mpicc -o anneaux anneaux.c
	mpirun -hostfile cluster.txt -np 70 ./anneaux
