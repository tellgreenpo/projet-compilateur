#include "../include/ts.h"
#include <stdio.h>
#include <string.h>

int size = 0;
int scope = 0;
Node *head = NULL;
Node *current = NULL;

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

int exists(char toGet[MAX_LENGTH_NAME])
{

    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    // if list is empty
    if (head == NULL)
    {
        return -1;
    }

    // navigate through list
    while (strcmp(current->name, toGet) != 0)
    {

        // if it is last node
        if (current->next == NULL)
        {
            return -1;
        }
        else
        {
            // move to next link
            current = current->next;
        }
    }

    // found match
    return 1;
}

int getAddress(char toGet[MAX_LENGTH_NAME])
{
    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    // if list is empty
    if (head == NULL)
    {
        return -1;
    }

    // navigate through list
    while (strcmp(current->name, toGet) != 0)
    {

        // if it is last node
        if (current->next == NULL)
        {
            return -1;
        }
        else
        {
            // move to next link
            current = current->next;
        }
    }

    // found match
    return current->address;
}

int getDepth(char toGet[MAX_LENGTH_NAME])
{
    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    // if list is empty
    if (head == NULL)
    {
        return -1;
    }

    // navigate through list
    while (strcmp(current->name, toGet) != 0)
    {

        // if it is last node
        if (current->next == NULL)
        {
            return -1;
        }
        else
        {
            // move to next link
            current = current->next;
        }
    }

    // found match
    return current->depth;
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
    while (strcmp(current->name, toGet) != 0)
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

    // found a match, update the link    // if list is empty
    if (head == NULL)
    {
        return NULL;
    }
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

void deleteScope(int scopeToDelete)
{
    // start from the first link
    Node *current = head;
    Node *previous = NULL;

    printf("Deleting scope... \n");

    // navigate through list
    while (current->next!=NULL)
    {

        // store reference to current link
        previous = current;
        // move to next link
        current = current->next;
        if(previous->depth == scopeToDelete)
        {
            // found a match, update the link
            if (previous == head)
            {
                // change first to point to next link
                head = head->next;
                size--;
            }
            else
            {
                // bypass the current link
                previous->next = current->next;
                size--;
            }
        }
    }
    printf("Scope deleted \n");
}
