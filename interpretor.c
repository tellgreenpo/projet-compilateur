#include <stdio.h>
#include <string.h>
#include "include/ts.h"
#define FILE_NAME "asm_code.txt"
#define REGISTER_NUMBER 16

int registers[16];


// TODO- finish parsing for interpretor
int main(int argc, char *argv[])
{
    FILE *codeFile = fopen(FILE_NAME, "r");
    char line[1000]; // variable to read the content
    char *elements;
    int count;
    int intLine[4];
    if (!codeFile)
        return 1;

    while (fgets(line, 1000, codeFile) != NULL) // reading file content
    {
        elements = strtok(line, " ");

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
            printf("this is and add\n");
            break;

        default:
            break;
        }

    }

    fclose(codeFile); // closing file

    return 0;
}
