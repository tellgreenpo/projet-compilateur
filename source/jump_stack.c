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
    if (whileStack = NULL)
    {
        printf("Poping nothing in while stack bruv!\n");
        return -1;
    };
    int line = whileStack->lineNumber;
    Node *aux = whileStack;
    whileStack = whileStack->next;
    free(aux);
    return line;
}

int pop_JMF()
{
    if (jumpStack = NULL)
    {
        printf("Poping nothing in jump stack bruv!\n");
        return -1;
    };
    int line = jumpStack->lineNumber;
    Node *aux = jumpStack;
    jumpStack = jumpStack->next;
    free(aux);
    return line;
}
