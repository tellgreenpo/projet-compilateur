#include "../include/instructions.h"
#include <stdio.h>
#include <stdlib.h>

Cell *asm_table = NULL;
Cell *asm_table_last = NULL;

// TODO -- Gestion automatique ligne (variable globale)

int add_ASM_file()
{
    FILE *readableFile = fopen("asm_readable.txt", "w");
    FILE *codeFile = fopen("asm_code.txt", "w");
    Cell *aux = asm_table;
    while (aux != NULL)
    {
        switch (aux->code)
        {
        case ADD:
            fprintf(codeFile, "%i %i %i %i\n", ADD, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "ADD", aux->result, aux->operand1, aux->operand2);
            break;
        case SOU:
            fprintf(codeFile, "%i %i %i %i\n", SOU, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "SOU", aux->result, aux->operand1, aux->operand2);
            break;
        case MUL:
            fprintf(codeFile, "%i %i %i %i\n", MUL, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "MUL", aux->result, aux->operand1, aux->operand2);
            break;
        case DIV:
            fprintf(codeFile, "%i %i %i %i\n", DIV, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "DIV", aux->result, aux->operand1, aux->operand2);
            break;
        case COP:
            fprintf(codeFile, "%i %i %i\n", COP, aux->result, aux->operand1);
            fprintf(readableFile, "%s %i %i\n", "COP", aux->result, aux->operand1);
            break;
        case AFC:
            fprintf(codeFile, "%i %i %i\n", AFC, aux->result, aux->operand1);
            fprintf(readableFile, "%s %i %i\n", "AFC", aux->result, aux->operand1);
            break;
        case LOA:
            fprintf(codeFile, "%i %i %i\n", LOA, aux->result, aux->operand1);
            fprintf(readableFile, "%s %i %i\n", "LOA", aux->result, aux->operand1);
            break;
        case STR:
            fprintf(codeFile, "%i %i %i\n", STR, aux->result, aux->operand1);
            fprintf(readableFile, "%s %i %i\n", "STR", aux->result, aux->operand1);
            break;
        case JMP:
            fprintf(codeFile, "%i %i\n", JMP, aux->result);
            fprintf(readableFile, "%s %i\n", "JMP", aux->result);
            break;
        case JMF:
            fprintf(codeFile, "%i %i %i\n", JMF, aux->result, aux->operand1);
            fprintf(readableFile, "%s %i %i\n", "JMF", aux->result, aux->operand1);
            break;
        case INF:
            fprintf(codeFile, "%i %i %i %i\n", INF, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "INF", aux->result, aux->operand1, aux->operand2);
            break;
        case SUP:
            fprintf(codeFile, "%i %i %i %i\n", SUP, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "SUP", aux->result, aux->operand1, aux->operand2);
            break;
        case EQU:
            fprintf(codeFile, "%i %i %i %i\n", EQU, aux->result, aux->operand1, aux->operand2);
            fprintf(readableFile, "%s %i %i %i\n", "EQU", aux->result, aux->operand1, aux->operand2);
            break;
        case PRI:
            fprintf(codeFile, "%i %i\n", PRI, aux->result);
            fprintf(readableFile, "%s %i\n", "PRI", aux->result);
            break;
        default:
            break;
        }
        aux = aux->next;
    }
    fclose(readableFile);
    fclose(codeFile);
    return 0;
}

int update_JMF(int jmfLine, int jumpDestination)
{
    bool found = false;
    Cell * aux = malloc(sizeof(Cell));
    aux = asm_table;
    while ((aux != NULL) && !found)
    {

        if (aux->lineNumber == jmfLine)
        {
            found = true;
            aux->operand1 = jumpDestination;
        }
        aux = aux->next;
    }
    return (int)found;
}

void add(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = ADD;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }

}

void substract(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = SOU;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void multiply(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = MUL;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void divide(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = DIV;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void copy(int result, int operand, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = COP;
    new->result = result;
    new->operand1 = operand;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void affectation(int result, int value, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = AFC;
    new->result = result;
    new->operand1 = value;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void load(int result, int value, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = LOA;
    new->result = result;
    new->operand1 = value;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void store(int result, int value, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = STR;
    new->result = result;
    new->operand1 = value;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void jump(int instructionLine, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = JMP;
    new->result = instructionLine;
    new->operand1 = -1;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void jump_false(int regis, int instructionLine, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = JMF;
    new->result = regis;
    new->operand1 = instructionLine;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void inferior(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = INF;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void superior(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = SUP;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void is_equal(int result, int operand1, int operand2, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = EQU;
    new->result = result;
    new->operand1 = operand1;
    new->operand2 = operand2;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}

void print(int result, int lineNumber)
{
    Cell *new = malloc(sizeof(Cell));
    new->code = PRI;
    new->result = result;
    new->operand1 = -1;
    new->operand2 = -1;
    new->lineNumber = lineNumber;

    if(asm_table == NULL){
        new->next = asm_table;
        asm_table = new;
        asm_table_last = new;
    }else{
        new->next = NULL;
        asm_table_last->next = new;
        asm_table_last = new;
    }
}
