#include "mpi.h"
#include <stdio.h>

int main(int argc, char* argv[]){
	int numtasks, rank, len, rc;
	char hostname[MPI_MAX_PROCESSOR_NAME];

	//initialize MPI
	MPI_Init(&argc, &argv);

	printf("HELLO WORLD !\n");

	MPI_Finalize();
}
