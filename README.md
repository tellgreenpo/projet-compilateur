# Projet Systeme Informatique
## Sujet: Creation compilateur


### Compilation process:
- lex -> lex.yy.c
- yacc -> y.tab.c
- gcc y.tab.c  lex.yy.c -ll -o name_exec

### Process
- Parse
- Call  C functions
- Generate interpretable and binary files
- execute binary file
