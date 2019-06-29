//
//  sbreload.m
//  sbreload
//
//  Created by Tanay Findley on 6/28/19.
//  Copyright © 2019 Slice Team. All rights reserved.
//

#include <stdio.h>
#include <sys/param.h>
#include <strings.h>
#include <signal.h>

#define PROC_ALL_PIDS        1
#define PROC_PIDPATHINFO_MAXSIZE    (4*MAXPATHLEN)

extern int proc_listpids(uint32_t type, uint32_t typeinfo, void *buffer, int buffersize);
extern int proc_pidpath(int pid, void * buffer, uint32_t  buffersize);

pid_t pidOfProcess(const char *name) {
    int numberOfProcesses = proc_listpids(PROC_ALL_PIDS, 0, NULL, 0);
    pid_t pids[numberOfProcesses];
    bzero(pids, sizeof(pids));
    proc_listpids(PROC_ALL_PIDS, 0, pids, (int)sizeof(pids));
    for (int i = 0; i < numberOfProcesses; ++i) {
        if (pids[i] == 0) {
            continue;
        }
        char pathBuffer[PROC_PIDPATHINFO_MAXSIZE];
        bzero(pathBuffer, PROC_PIDPATHINFO_MAXSIZE);
        proc_pidpath(pids[i], pathBuffer, sizeof(pathBuffer));
        if (strlen(pathBuffer) > 0 && strcmp(pathBuffer, name) == 0) {
            return pids[i];
        }
    }
    return 0;
}

int main()
{
    kill(pidOfProcess("/System/Library/CoreServices/SpringBoard.app/SpringBoard"), SIGTERM);
}
