#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#define NBPASSAGEANNEAUX 10000
#define TRUE 1
#define FALSE 0


int main(int argc, char* argv[]){
	int numtasks, rank, len;
	char hostname[MPI_MAX_PROCESSOR_NAME];
	MPI_Status status;

	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	MPI_Get_processor_name(hostname, &len);

	int number = 0;
	int arret = -1;
	int stop = FALSE;
	while (!stop){

		if (rank == 0){
			if (number / numtasks < NBPASSAGEANNEAUX){
				number++;
				MPI_Send(&number, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
				MPI_Recv(&number, 1, MPI_INT, numtasks-1, 0, MPI_COMM_WORLD, &status);
			}
			else {
				stop = TRUE;
				MPI_Send(&arret, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
				printf("Valeur finale de number = %d\n", number);
			}
		}
		else if (rank != 0){
			MPI_Recv(&number, 1, MPI_INT, rank-1==-1 ? numtasks-1 : rank-1, 0, MPI_COMM_WORLD, &status);
			number == -1 ? stop = TRUE : number++;
			MPI_Send(&number, 1, MPI_INT, (rank+1)%numtasks, 0, MPI_COMM_WORLD);
		}
	}
	MPI_Finalize();
}
