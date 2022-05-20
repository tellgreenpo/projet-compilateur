#include "../include/instructions.h"
#include <stdio.h>
#include <stdlib.h>
#define str(x) #x
#define xstr(x) str(x)

int add_ASM_file(enum ASM_CODES code,int result,int operand1, int operand2)
{
    FILE *readableFile = fopen("asm_readable.txt","w+");
    FILE *codeFile = fopen("asm_code.txt","w+");

    fprintf(codeFile,"%c %i %i %i\n",code,result,operand1,operand2);
    fprintf(readableFile,"%s %i %i %i\n",xstr(code),result,operand1,operand2);

    fclose(readableFile);
    fclose(codeFile);
}

// TODO - Modify the functions to add them
void add(int result,int operand1,int operand2)
{
    add_ASM_file(ADD,result,operand1,operand2);
}

void susbtract(int result,int operand1,int operand2)
{
    add_ASM_file(SOU,result,operand1,operand2);
}

void add(int result,int operand1,int operand2)
{
    add_ASM_file(ADD,result,operand1,operand2);
}

void add(int result,int operand1,int operand2)
{
    add_ASM_file(ADD,result,operand1,operand2);
}

void add(int result,int operand1,int operand2)
{
    add_ASM_file(ADD,result,operand1,operand2);
}

void add(int result,int operand1,int operand2)
{
    add_ASM_file(ADD,result,operand1,operand2);
}
