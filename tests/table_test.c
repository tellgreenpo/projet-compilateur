#include <stdio.h>
#include "../include/ts.h"

extern size;
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
    printf("Testing getAdress b...\n");
    printf("%i\n",getAddress("b"));
    printf("Testing getDepth b...\n");
    printf("%i\n",getDepth("b"));
    printf("Testing exists a...\n");
    printf("%i\n",exists("b"));
    printf("%i\n",size);

    return 0;

}
