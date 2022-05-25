#include <stdio.h>
#include "../include/jump_stack.h"
#include "../include/instructions.h"

extern Cell *asm_table;
extern Node *jumpStack;
extern Node *whileStack;


void to_file_test(){
    add(1,1,1,0);
    add(2,2,2,1);
    add(3,3,3,2);
    add(4,4,4,3);
    add(5,5,5,4);
    add(6,6,6,5);
    add(1,1,1,6);
    add(1,1,1,7);
    add_ASM_file();
}

void jmp_test(){
    affectation(10,99,0);
    affectation(9,98,1);
    inferior(1,10,9,2);
    printf("Add while\n");
    add_while(2);
    jump_false(1,-1,3);
    printf("Add jmf\n");
    add_JMF(3);
    add(42,42,42,4);
    add(42,42,42,5);
    add(42,42,42,6);
    add(42,42,42,7);
    add(42,42,42,8);
    add(42,42,42,9);
    int i = pop_while();
    printf("pop while: %i\n",i);
    jump(i,10);
    copy(7,7,11);
    int j = pop_JMF();
    printf("pop jmf: %i\n",j);
    update_JMF(j,11);

    add_ASM_file();

}
// Testing add
int main(int argc, char *argv[]){

    jmp_test();

}
