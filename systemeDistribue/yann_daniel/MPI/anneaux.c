#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
	int numtasks, rank, len;
	char hostname[MPI_MAX_PROCESSOR_NAME];
	MPI_Status status;

	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	MPI_Get_processor_name(hostname, &len);

	int* number = calloc(1, sizeof(int));
	int nbMachine = 10;
	int i = 0;
	if (rank == 0){
		MPI_Send(number, 1, MPI_INT, 1, 10, MPI_COMM_WORLD);
		MPI_Recv(number, 1, MPI_INT, nbMachine, 10, MPI_COMM_WORLD, &status);
		*number += 1;
		printf("Incrémentation de rang %d, nombre = %d\n", rank, *number);
	}
	while (i < nbMachine - 1){
		if(rank == i){
			MPI_Recv(number, 1, MPI_INT, rank-1, 10, MPI_COMM_WORLD, &status);
			*number += 1;
			printf("Incrémentation de rang %d, nombre = %d\n", rank, *number);
			MPI_Send(number, 1, MPI_INT, rank+1, 10, MPI_COMM_WORLD);
		}
	}
	if (rank == nbMachine){
		MPI_Recv(number, 1, MPI_INT, rank-1, 10, MPI_COMM_WORLD, &status);
		*number +=1;
		printf("Incrémentation de rang %d, nombre = %d\n", rank, *number);
		MPI_Send(number, 1, MPI_INT, 0, 10, MPI_COMM_WORLD);
	}
	free (number);
	MPI_Finalize();
}
