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

void multiply(int result,int operand1,int operand2)
{
    add_ASM_file(MUL,result,operand1,operand2);
}

void divide(int result,int operand1,int operand2)
{
    add_ASM_file(DIV,result,operand1,operand2);
}

void copy(int result,int operand)
{
    add_ASM_file(COP,result,operand,0);
}

void affectation(int result,int value)
{
    add_ASM_file(AFC,result,value,0);
}

void jump(int instructionNumber)
{
    add_ASM_file(JMP,instructionNumber,0,0);
}

void jump_false(int instructionNumber)
{
    add_ASM_file(JMF,instructionNumber,0,0);
}

void inferior(int result,int operand1,int operand2)
{
    add_ASM_file(INF,result,operand1,operand2);
}

void superior(int result,int operand1,int operand2)
{
    add_ASM_file(SUP,result,operand1,operand2);
}

void is_equal(int result,int operand1,int operand2)
{
    add_ASM_file(EQU,result,operand1,operand2);
}

void print(int result)
{
    add_ASM_file(PRI,result,0,0);
}
