#include <stdio.h>
#include "../include/ts.h"

extern int scope;
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
        printf("(%s,%d) ", ptr->name, ptr->depth);
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
    printf("Testing deleteScope...\n");
    insertFirst("c", size, INTEGER, 1);
    insertFirst("d", size, INTEGER, 3);
    insertFirst("e", size, INTEGER, 3);
    insertFirst("f", size, INTEGER, 3);
    insertFirst("g", size, INTEGER, 3);
    insertFirst("h", size, INTEGER, 3);
    printList();
    deleteScope(3);
    printList();
    return 0;

}
