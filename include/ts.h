#define MAX_LENGTH_NAME 20
#define MAX_LENGTH_LIST 10
enum t_type
{
    INT,
    VOID
};

typedef struct Cell
{
    char name[MAX_LENGTH_NAME];
    int address;
    enum t_type type;
    int depth;
} Cell;

typedef struct table
{
    Cell *list[MAX_LENGTH_LIST];
    int current;
} table;

void add(table *pTable, char *newName, enum t_type type);
// Returns 0 if the variable doesn't exist
// Return the address if it does
int getAddress(table *pTable, char *toGet);
// Returns -1 if it doesn't exist, 1 if it does
int exists(table *pTable, char *toGet);
