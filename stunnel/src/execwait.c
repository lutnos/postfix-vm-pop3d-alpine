#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int
main(int argc, char **argv)
{
    int childStatus;
    pid_t pid;
    int status;
    pid = fork();

    if (pid == 0) {
        execl("/usr/bin/stunnel", "/usr/bin/stunnel", (char *)0);
    }
    else if (pid < 0) {
        perror("Couldn't start process");
        exit(EXIT_FAILURE);
    }
    else {
        pid_t ws = waitpid( pid, &childStatus, WNOHANG);
        if (ws == -1) {
            perror("waitpid failed");
            exit(EXIT_FAILURE);
        }

                        for (;;) {
                            sleep(1000000);
                        }
                       exit(EXIT_FAILURE); /* Should never reach here */


        if( WIFEXITED(childStatus))
        {
            status = WEXITSTATUS(childStatus);
            if( status == 0 ) {
                for (;;) {
                    sleep(1000000);
                }
               exit(EXIT_FAILURE); /* Should never reach here */
            } else {
               perror("status non-zero");
               exit(EXIT_FAILURE);
            }
        }
        else if (WIFSIGNALED(childStatus))
        {
            perror("signalled");
            exit(EXIT_FAILURE);
        }
        else if (WIFSTOPPED(childStatus))
        {
            perror("stopped");
            exit(EXIT_FAILURE);
        }
        else
        {
            perror("unexpected child status");
            exit(EXIT_FAILURE);
       }
    }
    exit(EXIT_FAILURE);  /* Should never reach here */
}