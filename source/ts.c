#include "../include/ts.h"
#include <stdio.h>
#include <string.h>

void insertFirst(char newName[MAX_LENGTH_NAME], int newAddress, enum t_type newType, int newDepth)
{
    // create a link
    Node *link = (Node *)malloc(sizeof(Node));

    printf("Assign new name\n");
    strcpy(link->name, newName);
    link->address = newAddress;
    link->type = newType;
    link->depth = newDepth;

    // point it to old first node
    link->next = head;

    // point first to new first node
    head = link;
    size++;
}

bool exists(char toGet[MAX_LENGTH_NAME])
{

    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    // if list is empty
    if (head == NULL)
    {
        return NULL;
    }
    bool found = false;
    // navigate through list
    while ((current->next != NULL) && (!found))
    {
        if (current->name == toGet)
        {
            found = true;
        }
    }
    return found;
}

int getAddress(char toGet[MAX_LENGTH_NAME])
{
    // start from the first link
    Node *current = head;
    Node *previous = NULL;
    int toReturn;

    // if list is empty
    if (head == NULL)
    {
        return NULL;
    }
    bool found = false;
    // navigate through list
    while ((current->next != NULL) && (!found))
    {
        if (current->name == toGet)
        {
            toReturn = current->address;
            found = true;
        }
    }
    return toReturn;
}

int getDepth(char toGet[MAX_LENGTH_NAME])
{
    // start from the first link
    Node *current = head;
    Node *previous = NULL;
    int toReturn;

    // if list is empty
    if (head == NULL)
    {
        return NULL;
    }
    bool found = false;
    // navigate through list
    while ((current->next != NULL) && (!found))
    {
        if (current->name == toGet)
        {
            toReturn = current->depth;
            found = true;
        }
    }
    return toReturn;
}

Node *delete (char toGet[MAX_LENGTH_NAME])
{

    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    // if list is empty
    if (head == NULL)
    {
        return NULL;
    }

    // navigate through list
    while (current->name != toGet)
    {

        // if it is last node
        if (current->next == NULL)
        {
            return NULL;
        }
        else
        {
            // store reference to current link
            previous = current;
            // move to next link
            current = current->next;
        }
    }

    // found a match, update the link
    if (current == head)
    {
        // change first to point to next link
        head = head->next;
    }
    else
    {
        // bypass the current link
        previous->next = current->next;
    }
    size--;
    return current;
}
