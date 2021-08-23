#include <stdio.h>
#include <stdlib.h>

#include "hello-lib.h"
#include "hello-inc.h"

int main(int argc, char** argv) {
        int var = 1;
        printf("Hello world from main!\n");
        printf("Var before increment %d\n", var);

        var = exampleIncrement(var);

        printf("Var after increment %d\n", var);

        printf("Var before decrement %d\n", var);

        var = exampleDecrement(var);

        printf("Var after increment %d\n", var);

        return 0;
}

