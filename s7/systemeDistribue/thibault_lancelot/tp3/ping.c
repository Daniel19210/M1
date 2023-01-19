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

    int t=5;
    if (rank==0) {
        char buff[20] = "ping";
        MPI_Send(buff, 20, MPI_CHAR, 1, 0, MPI_COMM_WORLD);
        while (t-->0) {
            MPI_Recv(buff, 20, MPI_CHAR, 1, 0, MPI_COMM_WORLD, NULL);
            printf("%d %s\n",t,buff);
            buff[1]='o';
            MPI_Send(buff, 20, MPI_CHAR, 1, 0, MPI_COMM_WORLD);
        }
    }
    else if (rank==1) {
        char buff[20] = "";
        while(t-->0) {
            MPI_Recv(buff, 20, MPI_CHAR, 0, 0, MPI_COMM_WORLD, NULL);
            printf("%d %s\n",t,buff);
            buff[1]='i';
            MPI_Send(buff, 20, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
        }
        MPI_Recv(buff, 20, MPI_CHAR, 0, 0, MPI_COMM_WORLD, NULL);
        printf("stop\n");
    }



     // done with MPI
    MPI_Finalize ();
}

        //printf("send\t%d\t%s\t%s\n",rank,hostname,buff);
