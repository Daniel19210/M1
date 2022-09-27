c:
	mpicc -o pingpong.binary pingpong.c
	mpirun -hostfile cluster.txt -np 70 ./pingpong.binary

clean:
	rm *.;binary
