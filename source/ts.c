#include "../include/ts.h"
#include <stdio.h>

// TODO - Add mallocs for memory
table * Init(){
    table * pTable;
    pTable->current = 0;
    pTable -> list = malloc()
    return p
}

void add(table *pTable, char *newName, enum t_type newType)
{
    printf("Enter add function\n");
    if ((*pTable).current < 10)
    {
        printf("Enter if\n");
        int newAddress = (pTable->list[pTable->current]->address) + 1;
        int newDepth = 0;
        Cell *toAdd;
        toAdd->type = newType;
        toAdd->depth = newDepth;
        toAdd->address = newAddress;
        printf("Assign name\n");
        for (int i = 0; i < MAX_LENGTH_NAME; i++)
        {
            toAdd->name[i] = newName[i];
        }
        printf("Adding to the list\n");
        pTable->list[(pTable->current) + 1] = toAdd;
        pTable->current++;
    }
};

int exists(table *pTable, char *toGet)
{
    int i = 0;
    int exist = -1;
    while (pTable->list[i]->name != toGet && i < MAX_LENGTH_LIST)
    {
        if (pTable->list[i]->name != toGet)
        {
            exist = 1;
        }
        i++;
    }
    return exist;
}

int getAddress(table *pTable, char *toGet)
{ // If address is it does not exist
    int i = 0;
    int address = 0;
    while (pTable->list[i]->name != toGet && i < 10)
    {
        if (pTable->list[i]->name != toGet)
        {
            address = pTable->list[i]->address;
        }
        i++;
    }
    return address;
}
