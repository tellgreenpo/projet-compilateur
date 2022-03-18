#include <stdio.h>
#include "../include/ts.h"

extern int size;
extern Node *head;
extern Node *current;

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
    insertFirst("a", size, INTEGER, 0);
    printList();
    insertFirst("b", size, INTEGER, 2);
    printList();
    printf("Testing deleting a...\n");
    delete("a");
    printList();
    printf("Testing getAdress for b...\n");
    printf("B address: %i\n",getAddress("b"));
    printf("Testing getDepth for b...\n");
    printf("B depth: %i\n",getDepth("b"));
    printf("Testing exists for b...\n");
    printf("B : %i\n",exists("b"));
    printf("Testing exists for a...\n");
    printf("A : %i\n",exists("a"));

    return 0;

}
