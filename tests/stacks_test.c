#include <stdio.h>
#include "../include/jump_stack.h"
#include "../include/instructions.h"

extern Cell *asm_table;
extern Node *jumpStack;
extern Node *whileStack;

// Testing add
int main(int argc, char *argv[]){
    add(1,1,1,0);
    // substract(2,2,2,1);
    add_ASM_file();

    add_while(99);
    add_while(99);
    add_while(99);
    pop_while();
    pop_while();
    pop_while();
    pop_while();

}
