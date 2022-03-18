#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#ifndef TS_H
#define TS_H
#define MAX_LENGTH_NAME 20
#define MAX_LENGTH_LIST 10

enum t_type
{
    INTEGER,
    VOID
};

typedef struct Node
{
    char name[MAX_LENGTH_NAME];
    int address;
    enum t_type type;
    int depth;
    struct Node *next;
} Node;

// Inserts node
void insertFirst(char newName[MAX_LENGTH_NAME], int newAddress, enum t_type newType, int newDepth);
// returns -1 if not found, 1 if the variable is found
int exists(char toGet[MAX_LENGTH_NAME]);
// Deletes and returns a node, returns NULL if it does not exist
Node *delete (char toGet[MAX_LENGTH_NAME]);
// Deletes variables from a given scope
// Argument : Scope to delete
void deleteScope(int scopeToDelete);
// Returns the address of a variable, returns -1 if it does not exist
// Argument : The name
int getAddress(char toGet[MAX_LENGTH_NAME]);
// Returns the depth of a variable, returns -1 if it does not exist
// Argument : The name
int getDepth(char toGet[MAX_LENGTH_NAME]);
#endif
