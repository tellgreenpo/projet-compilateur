#include "../include/instructions.h"
#include <stdio.h>
#include <stdlib.h>
#define str(x) #x
#define xstr(x) str(x)

// TODO - Change file to implement asm table

// FIXME - Change to printing asm table
int add_ASM_file(enum ASM_CODES code, int result, int operand1, int operand2)
{
    FILE *readableFile = fopen("asm_readable.txt", "a");
    FILE *codeFile = fopen("asm_code.txt", "a");

    fprintf(codeFile, "%c %i %i %i\n", code, result, operand1, operand2);

    switch (code)
    {
    case ADD:
        fprintf(readableFile, "ADD %i %i %i\n", result, operand1, operand2);
        break;
    case MUL:
        fprintf(readableFile, "MUL %i %i %i\n", result, operand1, operand2);
        break;
    case SOU:
        fprintf(readableFile, "SOU %i %i %i\n", result, operand1, operand2);
        break;
    case DIV:
        fprintf(readableFile, "DIV %i %i %i\n", result, operand1, operand2);
        break;
    case COP:
        fprintf(readableFile, "COP %i %i %i\n", result, operand1, operand2);
        break;
    case AFC:
        fprintf(readableFile, "AFC %i %i %i\n", result, operand1, operand2);
        break;
    case JMP:
        fprintf(readableFile, "JMP %i %i %i\n", result, operand1, operand2);
        break;
    case JMF:
        fprintf(readableFile, "JMF %i %i %i\n", result, operand1, operand2);
        break;
    case INF:
        fprintf(readableFile, "INF %i %i %i\n", result, operand1, operand2);
        break;
    case SUP:
        fprintf(readableFile, "SUP %i %i %i\n", result, operand1, operand2);
        break;
    case EQU:
        fprintf(readableFile, "EQU %i %i %i\n", result, operand1, operand2);
        break;
    case PRI:
        fprintf(readableFile, "PRI %i %i %i\n", result, operand1, operand2);
        break;
    case LOA:
        fprintf(readableFile, "LOA %i %i %i\n", result, operand1, operand2);
        break;
    case STR:
        fprintf(readableFile, "STR %i %i %i\n", result, operand1, operand2);
        break;

    default:
        break;
    }

    fclose(readableFile);
    fclose(codeFile);
    return 0;
}

void add(int result, int operand1, int operand2)
{
    add_ASM_file(ADD, result, operand1, operand2);
}

void susbtract(int result, int operand1, int operand2)
{
    add_ASM_file(SOU, result, operand1, operand2);
}

void multiply(int result, int operand1, int operand2)
{
    add_ASM_file(MUL, result, operand1, operand2);
}

void divide(int result, int operand1, int operand2)
{
    add_ASM_file(DIV, result, operand1, operand2);
}

void copy(int result, int operand)
{
    add_ASM_file(COP, result, operand, 0);
}

void affectation(int result, int value)
{
    add_ASM_file(AFC, result, value, 0);
}

void load(int result, int value)
{
    add_ASM_file(LOA, result, value, 0);
}

void store(int result, int value)
{
    add_ASM_file(STR, result, value, 0);
}

void jump(int instructionNumber)
{
    add_ASM_file(JMP, instructionNumber, 0, 0);
}

void jump_false(int instructionNumber)
{
    add_ASM_file(JMF, instructionNumber, 0, 0);
}

void inferior(int result, int operand1, int operand2)
{
    add_ASM_file(INF, result, operand1, operand2);
}

void superior(int result, int operand1, int operand2)
{
    add_ASM_file(SUP, result, operand1, operand2);
}

void is_equal(int result, int operand1, int operand2)
{
    add_ASM_file(EQU, result, operand1, operand2);
}

void print(int result)
{
    add_ASM_file(PRI, result, 0, 0);
}
