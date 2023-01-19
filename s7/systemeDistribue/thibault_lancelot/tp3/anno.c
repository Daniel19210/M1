// required MPI include file
#include "mpi.h"
#include <stdio.h>

int main(int argc , char *argv []) {
    int numtasks , rank , len , rc;
    char hostname[MPI_MAX_PROCESSOR_NAME ];

     // initialize MPI
    MPI_Init (&argc ,& argv);
     // get number of tasks
    MPI_Comm_size(MPI_COMM_WORLD ,& numtasks);

     // get my rank
    MPI_Comm_rank(MPI_COMM_WORLD ,& rank);

     // this one is obvious
    MPI_Get_processor_name (hostname , &len);
    //printf ("Number of tasks= %d My rank= %d Running on %s\n", numtasks ,rank ,hostname);

    int mes = 0;

    if (rank==0) {
        MPI_Send(&mes, 20, MPI_CHAR, 1, 0, MPI_COMM_WORLD);
    }

    while (mes<100) {
        MPI_Recv(&mes, 20, MPI_CHAR, rank-1==-1?numtasks-1:rank-1, 0, MPI_COMM_WORLD, NULL);
        mes++;
        MPI_Send(&mes, 20, MPI_CHAR, (rank+1)%numtasks, 0, MPI_COMM_WORLD);
    }

    printf("%d\n",mes);

     // done with MPI
    MPI_Finalize ();
}

        //printf("send\t%d\t%s\t%s\n",rank,hostname,buff);
