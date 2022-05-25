#include "../include/jump_stack.h"
#include <stdio.h>
#include <stdlib.h>

Node *jumpStack = NULL;
Node *whileStack = NULL;

void add_while(int lineNumber)
{
    // create a link
    Node *link = (Node *)malloc(sizeof(Node));

    link->lineNumber = lineNumber;

    // point it to old first node
    link->next = whileStack;

    // point first to new first node
    whileStack = link;
}

void add_JMF(int lineNumber)
{
    // create a link
    Node *link = (Node *)malloc(sizeof(Node));

    link->lineNumber = lineNumber;

    // point it to old first node
    link->next = jumpStack;

    // point first to new first node
    jumpStack = link;
}


int pop_while()
{
    Node * aux = malloc(sizeof(Node));
    aux = whileStack;

    if (whileStack == NULL)
    {
        printf("Poping nothing in while stack bruv!\n");
        return -1;
    };


    int line = aux->lineNumber;
    whileStack = aux->next;
    free(aux);
    return line;

}

int pop_JMF()
{
    Node * aux = malloc(sizeof(Node));
    aux = jumpStack;

    if (jumpStack == NULL)
    {
        printf("Poping nothing in jump stack bruv!\n");
        return -1;
    };

    int line = aux->lineNumber;
    jumpStack = aux->next;
    free(aux);
    return line;
}
