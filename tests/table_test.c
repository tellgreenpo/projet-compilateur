#include <stdio.h>
#include "../include/ts.h"


// display the list
void printList()
{
    Node *ptr = head;
    printf("\n[ ");

    // start from the beginning
    while (ptr != NULL)
    {
        printf("(%s,%d) ", ptr->name, ptr->address);
        ptr = ptr->next;
    }

    printf(" ]\n");
}

int main(int argc, char *argv[])
{
    printf("Testing adding...\n");
    insertFirst("a", size, INT, 0);
    printList();
    return 0;
}
