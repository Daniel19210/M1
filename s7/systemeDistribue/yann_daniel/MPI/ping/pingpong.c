#include "mpi.h"
#include <stdio.h>

int main(int argc, char* argv[]){
	int numtasks, rank, len;
	char hostname[MPI_MAX_PROCESSOR_NAME];
	MPI_Status status;

	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	MPI_Get_processor_name(hostname, &len);

	char ping[5] = "ping";
	char pong[5] = "pong";
	int i;
	for (i = 0; i < 100; i++){
		if(rank == 0){
			MPI_Send(ping, 5, MPI_CHAR, 1, 10, MPI_COMM_WORLD);
			MPI_Recv(pong, 5, MPI_CHAR, 1, 10, MPI_COMM_WORLD, &status);
			printf("ping\n");
		}else if(rank == 1){
			MPI_Recv(ping, 5, MPI_CHAR, 0, 10, MPI_COMM_WORLD, &status);
			MPI_Send(pong, 5, MPI_CHAR, 0, 10, MPI_COMM_WORLD);
			printf("pong\n");
		}
	}

	MPI_Finalize();
}
