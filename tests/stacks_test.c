#include <stdio.h>
#include "../include/jump_stack.h"
#include "../include/instructions.h"

extern Cell *asm_table;
extern Node *jumpStack;
extern Node *whileStack;

// Testing add
int main(int argc, char *argv[]){
    add(1,1,1,1);
    substract(2,2,2,2);
    add_ASM_file();

    add_while(99);
    add_JMF(200);
    add_while(88);
    printf("Expected: 88\n");
    printf("Result: %i",pop_while());
    printf("Expected: 99\n");
    printf("Result: %i",pop_while());
    printf("Expected: 200\n");
    printf("Result: %i",pop_JMF());
}
