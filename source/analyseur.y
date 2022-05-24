 %{
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "include/ts.h"
#include "include/instructions.h"
//int str[26];
extern int size; 
int current_depth = 0;
int calcul = 0; 
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
// 11-13 : opérations (13 resultat op, 11 premier terme, 12 deuxieme terme)
// 14 : affectations
// 15 : print

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body ; // TODO - automatiser suppression *.txt

body : OPEN_BRACE {current_depth++; printf("scope + 1\n");} declarations insts CLOSE_BRACE {if (current_depth > 0) {
                                      deleteScope(current_depth);
                                      current_depth--;
                                    } else {
                                      deleteScope(current_depth);
                                      current_depth = 0;
                                    }
                                    printf("%d\n", calcul);};

insts : inst insts | ;
inst : affectation
      | print
      | ifBlock
      | whileBlock
      | RETURN value SEMICOLON {affectation(0,$2);}
      | RETURN name SEMICOLON {
        int e = exists($2);
        if (e) {
          int add = getAddress($2);
          load(0,add);
        } 
        // else erreur, la variable n'existe pas 
      };

args : value COMMA args | value | ; // TODO - comment on gere les arguments dans la table des symboles ??
params : type name COMMA params | type name | ;

declaration : type ids SEMICOLON | type id EQUAL value SEMICOLON ;
declarations : declaration declarations | declaration;
affectation : name EQUAL arithmExpr SEMICOLON {
                                          int e = exists($1);
                                          if (e) {
                                            int add = getAddress($1);
                                            affectation(14,$3);
                                            store(add, 14);
                                          } 
                                          // else erreur, la variable n'existe pas 
                                         } ;

print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON { affectation(15, $3);
                                                          print(15); 
                                                        };


// TODO - Mateo fait l'asm
ifBlock : IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE body;

whileBlock : WHILE OPEN_PARENT condition CLOSE_PARENT body;

condition : value
          | name
          | unaryOperand value
          | unaryOperand name
          | value binaryOperand value
          | value binaryOperand name
          | name binaryOperand value
          | name binaryOperand name;

binaryOperand : LESS | LESS_EQ | MORE | MORE_EQ | EQUALITY | DIFF;
unaryOperand: EXCLAM;

arithmExpr : value PLUS value  {calcul = $1+$3;}
          | value PLUS name 
          | name PLUS value
          | name PLUS name
          | value PLUS arithmExpr {calcul = calcul + $1;}
          | name PLUS arithmExpr
          | arithmExpr PLUS value {calcul = calcul + $3;}
          | arithmExpr PLUS name
          | arithmExpr PLUS arithmExpr 
          | value MINUS value  {calcul = $1-$3;}
          | value MINUS name 
          | name MINUS value
          | name MINUS name
          | value MINUS arithmExpr {calcul = calcul - $1;}
          | name MINUS arithmExpr
          | arithmExpr MINUS value {calcul = calcul - $3;}
          | arithmExpr MINUS name
          | arithmExpr MINUS arithmExpr 
          | OPEN_PARENT arithmExpr CLOSE_PARENT
          | divMul;

divMul : value MULTIPLY value  {calcul = $1*$3;}
          | value MULTIPLY name 
          | name MULTIPLY value
          | name MULTIPLY name
          | value MULTIPLY arithmExpr {calcul = $1 * calcul;}
          | name MULTIPLY arithmExpr
          | arithmExpr MULTIPLY value {calcul = calcul * $3;}
          | arithmExpr MULTIPLY name
          | arithmExpr MULTIPLY arithmExpr 
          | value DIVIDE value  {calcul = $1/$3;}
          | value DIVIDE name 
          | name DIVIDE value
          | name DIVIDE name
          | value DIVIDE arithmExpr {calcul = floor($1 / calcul);}
          | name DIVIDE arithmExpr
          | arithmExpr DIVIDE value {calcul = floor(calcul / $3);}
          | arithmExpr DIVIDE name
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
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
