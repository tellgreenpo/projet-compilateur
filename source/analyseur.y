 %{
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "include/ts.h"
#include "include/instructions.h"
#include "include/jump_stack.h"
//int str[26];
extern int size;
int current_depth = 0;
int linenumber = 0;
// A utiliser quand on parcours le fichier
int whileLoop = 0;
enum t_type current_type;
/*extern Node *head;
extern Node *current;*/
void yyerror(char *s);
//enum TYPE { T_INT, T_CONST_INT } ;
%}
%union { int nb; char *str; }
%token MAIN RETURN PRINTF CONST COMMA SEMICOLON
       OPEN_BRACE CLOSE_BRACE
       OPEN_PARENT CLOSE_PARENT IF ELSE WHILE
       EXCLAM EQUALITY DIFF LESS MORE LESS_EQ MORE_EQ
%token <nb> NUMBER
%token <nb> EXPON
%token <str> ALPHA
%token <str> INT
%type <nb> value divMul arithmExpr
%type <str> name id
%type <nb> type
%right EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE
%start main_structure
%%

// 0 : return
// 8-10 : operations booleennes (10 resultat op, 8 premier terme, 9 deuxieme terme)
// 11-13 : opérations (13 resultat op, 11 premier terme, 12 deuxieme terme)
// 14 : affectations
// 15 : print

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body {add_ASM_file();} ;

body : OPEN_BRACE {current_depth++; } declarations insts CLOSE_BRACE {if (current_depth > 0) {
                                      deleteScope(current_depth);
                                      current_depth--;
                                    } else {
                                      deleteScope(current_depth);
                                      current_depth = 0;
                                    }};

insts : inst insts | ;
inst : affectation
      | print
      | ifBlock
      | whileBlock
      | RETURN value SEMICOLON {affectation(0,$2, linenumber);  linenumber++;}
      | RETURN name SEMICOLON {
        int e = exists($2);
        if (e) {
          int addr = getAddress($2);
          load(0,addr, linenumber);
          linenumber++;
        }
        // else erreur, la variable n'existe pas
        else {
          printf("Erreur : la variable n'existe pas\n");
        }
      };

args : value COMMA args | value | ;
params : type name COMMA params | type name | ;

declaration : type ids SEMICOLON | type id EQUAL value SEMICOLON ;
declarations : declaration declarations | declaration;
affectation : name EQUAL arithmExpr SEMICOLON {
                                          int e = exists($1);
                                          if (e) {
                                            int addr = getAddress($1);
                                            affectation(14,$3, linenumber);
                                            linenumber++;
                                            store(addr, 14, linenumber);
                                            linenumber++;
                                          }
                                          // else erreur, la variable n'existe pas
                                          else {
                                            printf("Erreur : la variable n'existe pas\n");
                                          }
                                         } ;

print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON { affectation(15, $3, linenumber);
                                                          linenumber++;
                                                          print(15, linenumber);
                                                          linenumber++;
                                                        };


if : IF OPEN_PARENT condition CLOSE_PARENT {jump_false(10, -1, linenumber); add_JMF(linenumber); linenumber++;} body { int jmf_start = pop_JMF();
                                                                                                        update_JMF(jmf_start, linenumber);}
ifBlock : if ELSE if
        | if ELSE body;

whileBlock : WHILE {add_while(linenumber);} OPEN_PARENT condition CLOSE_PARENT {jump_false(10, -1, linenumber); add_JMF(linenumber); linenumber++;} body { int jmf_start;
                                                                                                                                            int while_start = pop_while();
                                                                                                                                            jump(while_start, linenumber);
                                                                                                                                            linenumber++;
                                                                                                                                            jmf_start = pop_JMF();
                                                                                                                                            update_JMF(jmf_start, linenumber); };

condition : value { if ($1==0) {
                      affectation(10, 0, linenumber);
                       linenumber++;
                    }
                    else {
                      affectation(10, 1, linenumber);
                       linenumber++;
                    }
                  }
          | name { int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(10, addr, linenumber);
                       linenumber++;
                      affectation(9, 1, linenumber);
                       linenumber++;
                      is_equal(10, 10, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    } ;
          | unaryOperand value
            { if ($2==0) {
                affectation(10, 1, linenumber);
                 linenumber++;
              }
              else {
                affectation(10, 0, linenumber);
                 linenumber++;
              }
            }
          | unaryOperand name { int e = exists($2);
                    if (e) {
                      int addr = getAddress($2);
                      load(10, addr, linenumber);
                       linenumber++;
                      affectation(9, 0, linenumber);
                       linenumber++;
                      is_equal(10, 10, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    } ;

          | value LESS value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3, linenumber);
             linenumber++;
            inferior(10, 8, 9, linenumber);
             linenumber++;
          }
          | value LESS_EQ value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3+1, linenumber);
             linenumber++;
            inferior(10, 8, 9, linenumber);
             linenumber++;
          }
          | value MORE value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3, linenumber);
             linenumber++;
            superior(10, 8, 9, linenumber);
             linenumber++;
          }
          | value MORE_EQ value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3-1, linenumber);
             linenumber++;
            superior(10, 8, 9, linenumber);
             linenumber++;
          }
          | value EQUALITY value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3, linenumber);
             linenumber++;
            is_equal(10, 8, 9, linenumber);
             linenumber++;
          }
          | value DIFF value {
            affectation(8, $1, linenumber);
             linenumber++;
            affectation(9, $3, linenumber);
             linenumber++;
            is_equal(10, 8, 9, linenumber);
             linenumber++;
            affectation(9, 0, linenumber);
             linenumber++;
            is_equal(10, 9, 10, linenumber);
             linenumber++;
          }

          | value LESS name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | value LESS_EQ name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, 1, linenumber);
                       linenumber++;
                      add(9, 8, 9, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | value MORE name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      superior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | value MORE_EQ name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, 1, linenumber);
                       linenumber++;
                      substract(9, 9, 8, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | value EQUALITY name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | value DIFF name {int e = exists($3);
                    if (e) {
                      int addr = getAddress($3);
                      load(9, addr, linenumber);
                       linenumber++;
                      affectation(8, $1, linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                      affectation(9, 0, linenumber);
                       linenumber++;
                      is_equal(10, 9, 10, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }


          | name LESS value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(8, addr, linenumber);
                       linenumber++;
                      affectation(9, $3, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name LESS_EQ value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      affectation(8, 1, linenumber);
                       linenumber++;
                      affectation(9, $3, linenumber);
                       linenumber++;
                      add(9, 8, 9, linenumber);
                       linenumber++;
                      load(8, addr, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name MORE value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(8, addr, linenumber);
                       linenumber++;
                      affectation(9, (int)(*($1)), linenumber);
                       linenumber++;
                      superior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name MORE_EQ value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(8, addr, linenumber);
                       linenumber++;
                      affectation(9, 1, linenumber);
                       linenumber++;
                      substract(8, 8, 9, linenumber);
                       linenumber++;
                      affectation(9, $3, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name EQUALITY value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(8, addr, linenumber);
                       linenumber++;
                      affectation(9, (int)(*($1)), linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name DIFF value {int e = exists($1);
                    if (e) {
                      int addr = getAddress($1);
                      load(8, addr, linenumber);
                       linenumber++;
                      affectation(9, (int)(*($1)), linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                      affectation(9, 0, linenumber);
                       linenumber++;
                      is_equal(10, 9, 10, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }

          | name LESS name { int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                      linenumber++;
                      load(9, add2, linenumber);
                      linenumber++;
                      inferior(10, 8, 9, linenumber);
                      linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name LESS_EQ name {int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                       linenumber++;
                      load(9, add2, linenumber);
                       linenumber++;
                      affectation(10, 1, linenumber);
                       linenumber++;
                      add(9, 9, 10, linenumber);
                       linenumber++;
                      inferior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name MORE name {int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                       linenumber++;
                      load(9, add2, linenumber);
                       linenumber++;
                      superior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name MORE_EQ name {int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                       linenumber++;
                      load(9, add2, linenumber);
                       linenumber++;
                      affectation(10, 1, linenumber);
                       linenumber++;
                      substract(9, 9, 10, linenumber);
                       linenumber++;
                      superior(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name EQUALITY name {int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                       linenumber++;
                      load(9, add2, linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }
          | name DIFF name {int e1 = exists($1);
                    int e2 = exists($3);
                    if (e2 && e1) {
                      int add1 = getAddress($1);
                      int add2 = getAddress($3);
                      load(8, add1, linenumber);
                       linenumber++;
                      load(9, add2, linenumber);
                       linenumber++;
                      is_equal(10, 8, 9, linenumber);
                       linenumber++;
                      affectation(9, 0, linenumber);
                       linenumber++;
                      is_equal(10, 9, 10, linenumber);
                       linenumber++;;
                    }
                    // else erreur, la variable n'existe pas
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    }

          | condition binaryOperand condition
          | unaryOperand condition;

binaryOperand : LESS | LESS_EQ | MORE | MORE_EQ | EQUALITY | DIFF;
unaryOperand: EXCLAM;

arithmExpr : value PLUS value  { affectation(11, $1, linenumber);
 linenumber++;
                              affectation(12, $3, linenumber);
                               linenumber++;
                              add(13,11,12, linenumber);
                               linenumber++;}
          | value PLUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                 linenumber++;
                                affectation(11, $1, linenumber);
                                 linenumber++;
                                add(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name PLUS value {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                affectation(12, $3, linenumber);
                                 linenumber++;
                                add(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name PLUS name {int e1 = exists($1);
                            int e2 = exists($3);
                              if (e1 && e2) {
                                int add1 = getAddress($1);
                                int add2 = getAddress($3);
                                load(11,add1, linenumber);
                                 linenumber++;
                                load(12,add2, linenumber);
                                 linenumber++;
                                add(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value PLUS arithmExpr {affectation(11, $1, linenumber);
           linenumber++;
                                  add(13, 11, 13, linenumber);
                                   linenumber++;}
          | name PLUS arithmExpr {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                add(13, 11, 13, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr PLUS value {affectation(12, $3, linenumber);
           linenumber++;
                                  add(13,13,12,linenumber);
                                   linenumber++;}
          | arithmExpr PLUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12, addr, linenumber);
                                 linenumber++;
                                add(13, 13, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr PLUS arithmExpr
          | value MINUS value  {affectation(11, $1, linenumber);
           linenumber++;
                                affectation(12, $3, linenumber);
                                 linenumber++;
                                substract(13, 11, 12, linenumber);
                                 linenumber++;}
          | value MINUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                 linenumber++;
                                affectation(11, $1, linenumber);
                                 linenumber++;
                                substract(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name MINUS value {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                affectation(12, $3, linenumber);
                                 linenumber++;
                                substract(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name MINUS name {int e1 = exists($1);
                            int e2 = exists($3);
                              if (e1 && e2) {
                                int add1 = getAddress($1);
                                int add2 = getAddress($3);
                                load(11,add1, linenumber);
                                 linenumber++;
                                load(12,add2, linenumber);
                                 linenumber++;
                                substract(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value MINUS arithmExpr {affectation(11, $1, linenumber);
           linenumber++;
                                  add(13, 11, 13, linenumber);
                                   linenumber++;}
          | name MINUS arithmExpr {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                substract(13, 11, 13, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr MINUS value {affectation(12, $3, linenumber);
           linenumber++;
                                  substract(13,13,12,linenumber); linenumber++;}
          | arithmExpr MINUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12, addr, linenumber);
                                 linenumber++;
                                substract(13, 13, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr MINUS arithmExpr
          | OPEN_PARENT arithmExpr CLOSE_PARENT
          | divMul;

divMul : value MULTIPLY value { affectation(11, $1, linenumber);
 linenumber++;
                              affectation(12, $3, linenumber);
                               linenumber++;
                              multiply(13,11,12, linenumber);
                               linenumber++;}
          | value MULTIPLY name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                 linenumber++;
                                affectation(11, $1, linenumber);
                                 linenumber++;
                                multiply(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name MULTIPLY value {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                affectation(12, $3, linenumber);
                                 linenumber++;
                                multiply(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name MULTIPLY name {int e1 = exists($1);
                                int e2 = exists($3);
                              if (e1 && e2) {
                                int add1 = getAddress($1);
                                int add2 = getAddress($3);
                                load(11,add1, linenumber);
                                 linenumber++;
                                load(12,add2, linenumber);
                                 linenumber++;
                                multiply(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value MULTIPLY arithmExpr {affectation(11, $1, linenumber);
           linenumber++;
                                      multiply(13, 11, 13, linenumber);
                                       linenumber++;}
          | name MULTIPLY arithmExpr {int e = exists($1);
                                      if (e) {
                                        int addr = getAddress($1);
                                        load(11, addr, linenumber);
                                         linenumber++;
                                        multiply(13, 11, 13, linenumber);
                                         linenumber++;
                                      }
                                      // else erreur, la variable n'existe pas
                                      else {
                                        printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr MULTIPLY value {affectation(12, $3, linenumber);
           linenumber++;
                                      multiply(13,13,12,linenumber); linenumber++;}
          | arithmExpr MULTIPLY name {int e = exists($3);
                                      if (e) {
                                        int addr = getAddress($3);
                                        load(12, addr, linenumber);
                                         linenumber++;
                                        multiply(13, 13, 12, linenumber);
                                         linenumber++;
                                      }
                                      // else erreur, la variable n'existe pas
                                      else {
                                       printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr MULTIPLY arithmExpr
          | value DIVIDE value  { affectation(11, $1, linenumber);
           linenumber++;
                              affectation(12, $3, linenumber);
                               linenumber++;
                              divide(13,11,12, linenumber);
                               linenumber++;}
          | value DIVIDE name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                 linenumber++;
                                affectation(11, $1, linenumber);
                                 linenumber++;
                                divide(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name DIVIDE value {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                 linenumber++;
                                affectation(12, $3, linenumber);
                                 linenumber++;
                                divide(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | name DIVIDE name {int e1 = exists($1);
                                int e2 = exists($3);
                              if (e1 && e2) {
                                int add1 = getAddress($1);
                                int add2 = getAddress($3);
                                load(11,add1, linenumber);
                                 linenumber++;
                                load(12,add2, linenumber);
                                 linenumber++;
                                divide(13, 11, 12, linenumber);
                                 linenumber++;
                              }
                              // else erreur, la variable n'existe pas
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value DIVIDE arithmExpr {affectation(11, $1, linenumber);
           linenumber++;
                                      divide(13, 11, 13, linenumber);
                                       linenumber++;}
          | name DIVIDE arithmExpr {int e = exists($1);
                                      if (e) {
                                        int addr = getAddress($1);
                                        load(11, addr, linenumber);
                                         linenumber++;
                                        divide(13, 11, 13, linenumber);
                                         linenumber++;
                                      }
                                      // else erreur, la variable n'existe pas
                                      else {
                                        printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr DIVIDE value {affectation(12, $3, linenumber);
           linenumber++;
                                      divide(13,13,12,linenumber);
                                       linenumber++;}
          | arithmExpr DIVIDE name {int e = exists($3);
                                      if (e) {
                                        int addr = getAddress($3);
                                        load(12, addr, linenumber);
                                         linenumber++;
                                        divide(13, 13, 12, linenumber);
                                         linenumber++;
                                      }
                                      // else erreur, la variable n'existe pas
                                      else {
                                        printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr DIVIDE arithmExpr
          | OPEN_PARENT arithmExpr CLOSE_PARENT
          | value
          | name;

term : value | name;

value : NUMBER {$$ = $1;} | EXPON {$$ = $1;};
type : INT { current_type = INTEGER; $$ = current_type ; }
    | CONST INT { current_type = CONSTINT; $$ = current_type ;} ;

name : ALPHA ;

id : ALPHA {if (current_type == INTEGER) {insertFirst($1, size, INTEGER, current_depth);}
            else if (current_type == CONSTINT) {insertFirst($1, size, CONSTINT, current_depth);}} ;
ids : id COMMA ids | id ;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n");
  yyparse();
  return 0;
}
