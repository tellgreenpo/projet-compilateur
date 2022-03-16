#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#define MAX_LENGTH_NAME 20
#define MAX_LENGTH_LIST 10

int size = 0;

enum t_type
{
    INT,
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

Node *head = NULL;
Node *current = NULL;

// Inserts node
void insertFirst(char newName[MAX_LENGTH_NAME], int newAddress, enum t_type newType, int newDepth);
// returns a boolean if the variable is found
bool exists(char toGet[MAX_LENGTH_NAME]);
// Deletes and returns a node, returns NULL if it does not exist
Node *delete (char toGet[MAX_LENGTH_NAME]);
// Returns the address of a variable, returns NULL if it does not exist
// Argument : The name
int getAddress(char toGet[MAX_LENGTH_NAME]);
// Returns the depth of a variable, returns NULL if it does not exist
// Argument : The name
int getDepth(char toGet[MAX_LENGTH_NAME]);
