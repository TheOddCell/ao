#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <program> <argv0> [args...]\n", argv[0]);
        return 1;
    }

    // argv[1] = program to exec
    // argv[2] = argv[0] for the exec'ed program
    // argv[3...] = arguments for the exec'ed program
    char **new_argv = &argv[2]; // argv[2] becomes argv[0] for exec

    execvp(argv[1], new_argv);
    perror("execvp failed");
    return 1;
}
