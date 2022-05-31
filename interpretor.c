#include <stdio.h>
#include <string.h>
#include "include/ts.h"
#define FILE_NAME "asm_code.txt"
#define REGISTER_NUMBER 16

int registers[16];
int memory[20];

typedef struct match_return
{
    bool restart;
    int target;
} match_return;

match_return *matching(int lineNumber, char line[1000])
{
    char *elements;
    int count;
    int intLine[4];
    elements = strtok(line, " ");
    match_return *toReturn = malloc(sizeof(match_return));
    toReturn->restart = false;
    toReturn -> target = lineNumber+1;

    if (elements == NULL)
    {
        printf("found nada\n");
    }

    count = 0;
    while (elements)
    {
        intLine[count] = atoi(elements);
        elements = strtok(NULL, " ");
        count++;
    }

    switch (intLine[0])
    {
    case 1:
        registers[intLine[1]] = registers[intLine[2]] + registers[intLine[3]];
        break;
    case 2:
        registers[intLine[1]] = registers[intLine[2]] * registers[intLine[3]];
        break;
    case 3:
        registers[intLine[1]] = registers[intLine[2]] - registers[intLine[3]];
        break;
    case 4:
        registers[intLine[1]] = registers[intLine[2]] / registers[intLine[3]];
        break;
    case 5:
        registers[intLine[1]] = registers[intLine[2]];
        break;
    case 6:
        registers[intLine[1]] = intLine[2];
        break;
    case 7:
        toReturn->target = intLine[1];
        break;
    case 8:
        if (registers[intLine[1]] == 0)
        {
            toReturn->target = intLine[2];
        }
        break;
    case 9:
        if (registers[intLine[2]] < registers[intLine[3]])
        {
            registers[intLine[1]] = 1;
        }
        else
        {
            registers[intLine[1]] = 0;
        }
        break;
    case 10:
        if (registers[intLine[2]] > registers[intLine[3]])
        {
            registers[intLine[1]] = 1;
        }
        else
        {
            registers[intLine[1]] = 0;
        }
        break;
    case 11:
        if (registers[intLine[2]] == registers[intLine[3]])
        {
            registers[intLine[1]] = 1;
        }
        else
        {
            registers[intLine[1]] = 0;
        }
        break;
    case 12:
        printf("%i\n", registers[intLine[1]]);
        break;
    case 13:
        registers[intLine[1]] = memory[intLine[2]];
        break;
    case 14:
        memory[intLine[1]] = registers[intLine[2]];
        break;

    default:
        break;
    }
    if ((toReturn->target) <= lineNumber)
        toReturn->restart = true;
    return toReturn;
}


void print(){
    for (int i=0; i<16; i++){
        printf("R%i : %i\n",i,registers[i]);
    }
    printf("\n");
    for (int i=0; i<20; i++){
        printf("M%i : %i\n",i,memory[i]);
    }
    printf("\n");
}


int main(int argc, char *argv[])
{
    FILE *codeFile = fopen(FILE_NAME, "r");
    char line[1000]; // variable to read the content
    int lineNumber;
    match_return * res = malloc(sizeof(match_return));
    res->target = 0;
    res -> restart = false;
    bool restart = false;
    bool ignore = false;
    bool finished = false;
    if (!codeFile)
        return 1;
    lineNumber = 0;

    while (!finished)
    {
        ignore = (res->target != lineNumber);

        if (fgets(line, 1000, codeFile) == NULL)
        {
            fclose(codeFile); // closing file
            finished = true;
        }
        else if (restart)
        {
            // restart from beginning of the file
            fclose(codeFile);
            codeFile = fopen(FILE_NAME, "r");
            restart = false;
            ignore = true;
            lineNumber = -1;
        }
        else
        {

            if (!ignore)
            {
                res = matching(lineNumber, line);
                if (res->restart )
                {
                    restart = true;
                }
            }
        }
        lineNumber++;
        // print();
    }

    return 0;
}
