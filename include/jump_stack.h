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

void addWhile(int lineNumber);
void addIf(int lineNumber);

int popWhile();
int popIf();

#endif
