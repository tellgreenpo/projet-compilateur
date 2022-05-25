 %{
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "include/ts.h"
#include "include/instructions.h"
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

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body {add_ASM_file();} ; // TODO - automatiser suppression *.txt

body : OPEN_BRACE {current_depth++; printf("scope + 1\n"); } declarations insts CLOSE_BRACE {if (current_depth > 0) {
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
      | RETURN value SEMICOLON {affectation(0,$2, linenumber);}
      | RETURN name SEMICOLON {
        int e = exists($2);
        if (e) {
          int add = getAddress($2);
          load(0,add, linenumber);
        } 
        // else erreur, la variable n'existe pas 
        else {
          printf("Erreur : la variable n'existe pas\n");
        }
      };

args : value COMMA args | value | ; // TODO - comment on gere les arguments dans la table des symboles ??
params : type name COMMA params | type name | ;

declaration : type ids SEMICOLON | type id EQUAL value SEMICOLON ;
declarations : declaration declarations | declaration;
affectation : name EQUAL arithmExpr SEMICOLON {
                                          int e = exists($1);
                                          if (e) {
                                            int add = getAddress($1);
                                            affectation(14,$3, linenumber);
                                            store(add, 14, linenumber);
                                          } 
                                          // else erreur, la variable n'existe pas 
                                          else {
                                            printf("Erreur : la variable n'existe pas\n");
                                          }
                                         } ;

print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON { affectation(15, $3, linenumber);
                                                          print(15, linenumber); 
                                                        };


// TODO - Mateo fait l'asm
ifBlock : IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE body;

whileBlock : WHILE OPEN_PARENT condition CLOSE_PARENT body;

condition : value { if ($1==0) {
                      affectation(10, 0, linenumber);
                    }
                    else {
                      affectation(10, 1, linenumber);
                    }
                  }
          | name { int e = exists($1);
                    if (e) {
                      int add = getAddress($1);
                      load(10, add, linenumber);
                      affectation(9, 1, linenumber);
                      is_equal(10, 10, 9, linenumber);
                    } 
                    // else erreur, la variable n'existe pas 
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    } ;
          | unaryOperand value 
            { if ($2==0) {
                affectation(10, 1, linenumber);
              }
              else {
                affectation(10, 0, linenumber);
              }
            }
          | unaryOperand name { int e = exists($2);
                    if (e) {
                      int add = getAddress($2);
                      load(10, add, linenumber);
                      affectation(9, 0, linenumber);
                      is_equal(10, 10, 9, linenumber);
                    } 
                    // else erreur, la variable n'existe pas 
                    else {
                      printf("Erreur : la variable n'existe pas\n");
                    }
                    } ;
                    
          | value LESS value {
            affectation(8, $1, linenumber);
            affectation(9, $3, linenumber);
            inferior(10, 8, 9, linumber);
          }
          | value LESS_EQ value {
            affectation(8, $1, linenumber);
            affectation(9, $3+1, linenumber);
            inferior(10, 8, 9, linumber);
          }
          | value MORE value {
            affectation(8, $1, linenumber);
            affectation(9, $3, linenumber);
            superior(10, 8, 9, linumber);
          }
          | value MORE_EQ value {
            affectation(8, $1, linenumber);
            affectation(9, $3-1, linenumber);
            superior(10, 8, 9, linumber);
          }
          | value EQUALITY value {
            affectation(8, $1, linenumber);
            affectation(9, $3, linenumber);
            is_equal(10, 8, 9, linumber);
          }
          | value DIFF value {
            affectation(8, $1, linenumber);
            affectation(9, $3, linenumber);
            is_equal(10, 8, 9, linumber);
            affectation(9, 0, linenumber);
            is_equal(10, 9, 10, linenumber);
          }

          | value binaryOperand name

          | name binaryOperand value

          | name binaryOperand name;

binaryOperand : LESS | LESS_EQ | MORE | MORE_EQ | EQUALITY | DIFF;
unaryOperand: EXCLAM;

arithmExpr : value PLUS value  { affectation(11, $1, linenumber);
                              affectation(12, $3, linenumber);
                              add(13,11,12, linenumber);}
          | value PLUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                affectation(11, $1, linenumber);
                                add(13, 11, 12, linenumber);
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
                                affectation(12, $3, linenumber);
                                add(13, 11, 12, linenumber);
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
                                load(12,add2, linenumber);
                                add(13, 11, 12, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value PLUS arithmExpr {affectation(11, $1, linenumber);
                                  add(13, 11, 13, linenumber);}
          | name PLUS arithmExpr {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                add(13, 11, 13, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr PLUS value {affectation(12, $3, linenumber);
                                  add(13,13,12,linenumber);}
          | arithmExpr PLUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12, addr, linenumber);
                                add(13, 13, 12, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr PLUS arithmExpr 
          | value MINUS value  {affectation(11, $1, linenumber);
                                affectation(12, $3, linenumber);
                                substract(13, 11, 12, linenumber);}
          | value MINUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                affectation(11, $1, linenumber);
                                substract(13, 11, 12, linenumber);
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
                                affectation(12, $3, linenumber);
                                substract(13, 11, 12, linenumber);
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
                                load(12,add2, linenumber);
                                substract(13, 11, 12, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value MINUS arithmExpr {affectation(11, $1, linenumber);
                                  add(13, 11, 13, linenumber);}
          | name MINUS arithmExpr {int e = exists($1);
                              if (e) {
                                int addr = getAddress($1);
                                load(11, addr, linenumber);
                                substract(13, 11, 13, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | arithmExpr MINUS value {affectation(12, $3, linenumber);
                                  substract(13,13,12,linenumber);}
          | arithmExpr MINUS name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12, addr, linenumber);
                                substract(13, 13, 12, linenumber);
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
                              affectation(12, $3, linenumber);
                              multiply(13,11,12, linenumber);}
          | value MULTIPLY name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                affectation(11, $1, linenumber);
                                multiply(13, 11, 12, linenumber);
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
                                affectation(12, $3, linenumber);
                                multiply(13, 11, 12, linenumber);
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
                                load(12,add2, linenumber);
                                multiply(13, 11, 12, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value MULTIPLY arithmExpr {affectation(11, $1, linenumber);
                                      multiply(13, 11, 13, linenumber);}
          | name MULTIPLY arithmExpr {int e = exists($1);
                                      if (e) {
                                        int addr = getAddress($1);
                                        load(11, addr, linenumber);
                                        multiply(13, 11, 13, linenumber);
                                      }
                                      // else erreur, la variable n'existe pas 
                                      else {
                                        printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr MULTIPLY value {affectation(12, $3, linenumber);
                                      multiply(13,13,12,linenumber);}
          | arithmExpr MULTIPLY name {int e = exists($3);
                                      if (e) {
                                        int addr = getAddress($3);
                                        load(12, addr, linenumber);
                                        multiply(13, 13, 12, linenumber);
                                      }
                                      // else erreur, la variable n'existe pas
                                      else {
                                       printf("Erreur : la variable n'existe pas\n");
                                      } 
                                      }
          | arithmExpr MULTIPLY arithmExpr 
          | value DIVIDE value  { affectation(11, $1, linenumber);
                              affectation(12, $3, linenumber);
                              divide(13,11,12, linenumber);}
          | value DIVIDE name {int e = exists($3);
                              if (e) {
                                int addr = getAddress($3);
                                load(12,addr, linenumber);
                                affectation(11, $1, linenumber);
                                divide(13, 11, 12, linenumber);
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
                                affectation(12, $3, linenumber);
                                divide(13, 11, 12, linenumber);
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
                                load(12,add2, linenumber);
                                divide(13, 11, 12, linenumber);
                              }
                              // else erreur, la variable n'existe pas 
                              else {
                                printf("Erreur : la variable n'existe pas\n");
                              }
                              }
          | value DIVIDE arithmExpr {affectation(11, $1, linenumber);
                                      divide(13, 11, 13, linenumber);}
          | name DIVIDE arithmExpr {int e = exists($1);
                                      if (e) {
                                        int addr = getAddress($1);
                                        load(11, addr, linenumber);
                                        divide(13, 11, 13, linenumber);
                                      }
                                      // else erreur, la variable n'existe pas 
                                      else {
                                        printf("Erreur : la variable n'existe pas\n");
                                      }
                                      }
          | arithmExpr DIVIDE value {affectation(12, $3, linenumber);
                                      divide(13,13,12,linenumber);}
          | arithmExpr DIVIDE name {int e = exists($3);
                                      if (e) {
                                        int addr = getAddress($3);
                                        load(12, addr, linenumber);
                                        divide(13, 13, 12, linenumber);
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
