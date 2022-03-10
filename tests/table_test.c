#include <stdio.h>
#include "../include/ts.h"

void print(table *pTable)
{
    for (int i = 0; i < MAX_LENGTH_LIST; i++)
    {
        //printf("Name : %s\n", pTable->list[pTable->current]->name);
        printf("Adress : %i\n", pTable->list[pTable->current]->address);
        printf("depth : %i\n", pTable->list[pTable->current]->depth);
        printf("\n");
    }
}
int main(int argc, char *argv[])
{
    table *p;
    printf("Checking add function\n");
    add(p, "a\0", INT);
    print(p);
    return 0;
}
