#include <stdbool.h>
#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H
#define MAX_SIZE 20

enum ASM_CODES
{
    ADD = 1,
    MUL = 2,
    SOU = 3,
    DIV = 4,
    COP = 5,
    AFC = 6,
    JMP = 7,
    JMF = 8,
    INF = 9,
    SUP = 10,
    EQU = 11,
    PRI = 12,
    LOA = 13,
    STR = 14
};

typedef struct Cell
{
    int lineNumber;
    enum ASM_CODES code;
    int result;
    int operand1;
    int operand2;
    struct Cell *next;
} Cell;

// Adds ASM readable instruction to output file
int add_ASM_file();

// Updates the jumps in the instruction table
int update_JMF(int jmfLine, int jumpDestination);

// Addition operation and calls add_ASM_file
void add(int result, int operand1, int operand2, int lineNumber);

// Substraction operation and calls add_ASM_file
void substract(int result, int operand1, int operand2, int lineNumber);

// Multiplication operation and calls add_ASM_file
void multiply(int result, int operand1, int operand2, int lineNumber);

// Division operation and calls add_ASM_file
void divide(int result, int operand1, int operand2, int lineNumber);

// Copy operation and calls add_ASM_file
void copy(int result, int operand, int lineNumber);

// Affectation operation and calls add_ASM_file
void affectation(int result, int value, int lineNumber);

// Load operation and calls add_ASM_file
void load(int result, int value, int lineNumber);

// Store operation and calls add_ASM_file
void store(int result, int value, int lineNumber);

// Jump if true operation and calls add_ASM_file
void jump(int instructionLine, int lineNumber);

// Jump if false operation and calls add_ASM_file
void jump_false(int regis, int instructionLine, int lineNumber);

// Inferior comparison  operation and calls add_ASM_file
void inferior(int result, int operand1, int operand2, int lineNumber);

// Superior comparison operation and calls add_ASM_file
void superior(int result, int operand1, int operand2, int lineNumber);

// Equal comparison operation and calls add_ASM_file
void is_equal(int result, int operand1, int operand2, int lineNumber);

// print operation and calls add_ASM_file
void print(int result, int lineNumber);

#endif
