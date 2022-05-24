#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H
#define MAX_SIZE 20

enum ASM_CODES
{
    ADD = '1',
    MUL = '2',
    SOU = '3',
    DIV = '4',
    COP = '5',
    AFC = '6',
    JMP = '7',
    JMF = '8',
    INF = '9',
    SUP = 'A',
    EQU = 'B',
    PRI = 'C',
    LOA = 'D',
    STR = 'E'
};

/*typedef struct Cell
{
    int lineNumber;
    char asmLine[MAX_SIZE];
    int jumpToLine;
    Cell *next;
} Cell;*/

// Adds ASM readable instruction to output file
int add_ASM_file(enum ASM_CODES code, int result, int operand1, int operand2);

// Addition operation and calls add_ASM_file
void add(int result, int operand1, int operand2);

// Substraction operation and calls add_ASM_file
void substract(int result, int operand1, int operand2);

// Multiplication operation and calls add_ASM_file
void multiply(int result, int operand1, int operand2);

// Division operation and calls add_ASM_file
void divide(int result, int operand1, int operand2);

// Copy operation and calls add_ASM_file
void copy(int result, int operand);

// Affectation operation and calls add_ASM_file
void affectation(int result, int value);

// Load operation and calls add_ASM_file
void load(int result, int value);

// Store operation and calls add_ASM_file
void store(int result, int value);

// Jump if true operation and calls add_ASM_file
void jump(int instructionNumber);

// Jump if false operation and calls add_ASM_file
void jump_false(int instructionNumber);

// Inferior comparison  operation and calls add_ASM_file
void inferior(int result, int operand1, int operand2);

// Superior comparison operation and calls add_ASM_file
void superior(int result, int operand1, int operand2);

// Equal comparison operation and calls add_ASM_file
void is_equal(int result, int operand1, int operand2);

// print operation and calls add_ASM_file
void print(int result);

#endif
