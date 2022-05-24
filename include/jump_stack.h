#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#ifndef JUMP_STACK_H
#define JUMP_STACK_H

typedef struct Node
{
    int lineNumber;
    struct Node *next;
} Node;

void add_while(int lineNumber);
void add_JMF(int lineNumber);

int pop_while();
int pop_JMF();

#endif
