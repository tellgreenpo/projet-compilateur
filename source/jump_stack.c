#include "../include/jump_stack.h"
#include <stdio.h>
#include <stdlib.h>

NodeStack *jumpStack = NULL;
NodeStack *whileStack = NULL;

void add_while(int lineNumber)
{
    // create a link
    NodeStack *link = (NodeStack *)malloc(sizeof(NodeStack));

    link->lineNumber = lineNumber;

    // point it to old first nodeStack
    link->next = whileStack;

    // point first to new first nodeStack
    whileStack = link;
}

void add_JMF(int lineNumber)
{
    // create a link
    NodeStack *link = (NodeStack *)malloc(sizeof(NodeStack));

    link->lineNumber = lineNumber;

    // point it to old first nodeStack
    link->next = jumpStack;

    // point first to new first nodeStack
    jumpStack = link;
}


int pop_while()
{
    NodeStack * aux = malloc(sizeof(NodeStack));
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
    NodeStack * aux = malloc(sizeof(NodeStack));
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
