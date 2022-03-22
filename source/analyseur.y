 %{
#include <stdlib.h>
#include <stdio.h>
#include "include/ts.h"
//int str[26];
extern int size; 
int nb_args = 0; 
/*extern Node *head;
extern Node *current;*/ 
void yyerror(char *s);
//enum TYPE { T_INT, T_CONST_INT } ;
%}
%union { int nb; char *str; }
%token PLUS MINUS MULTIPLY DIVIDE EQUAL MAIN RETURN PRINTF
       CONST EOL DOT COMMA SEMICOLON OPEN_BRACE CLOSE_BRACE
       OPEN_BRACKET CLOSE_BRACKET OPEN_PARENT CLOSE_PARENT
%token <nb> NUMBER
%token <str> ALPHA
%token <str> INT
%type <nb> value expr divMul
%type <str> name id
%type <nb> type 
%start main_structure
%%
/*fun : type name OPEN_PARENT params CLOSE_PARENT body ;*/

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body ;

body : OPEN_BRACE insts CLOSE_BRACE ;

insts : inst insts | ;
inst : declaration
      | affectation
      | print
      | RETURN value SEMICOLON
      | RETURN name SEMICOLON;

args : value COMMA args | value | ;
params : type name COMMA params | type name | ;


declaration : type ids SEMICOLON {if ($1 == INTEGER) {insertFirst($2, size, INTEGER, 0);} 
                                  else if ($1 == CONSTINT) {insertFirst($2, size, CONSTINT, 0);}
                                  nb_args ++;};
affectation : type id EQUAL value SEMICOLON 
              | name EQUAL value SEMICOLON
              | name EQUAL expr SEMICOLON;
print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON
        | PRINTF OPEN_PARENT name CLOSE_PARENT SEMICOLON;

expr : expr PLUS divMul { $$ = $1 + $3; }
		| expr MINUS divMul { $$ = $1 - $3; }
		| divMul { $$ = $1; } ;
divMul :	  divMul MULTIPLY value { $$ = $1 * $3; }
		| divMul DIVIDE value { $$ = $1 / $3; }
		| value { $$ = $1; } ; 

value : NUMBER;
type : INT { $$ = INTEGER ; } | CONST INT { $$ = CONSTINT; } ;

name : ALPHA ; 
names : name COMMA names | name;

id : ALPHA { $$ = nb_args++; } ; 
ids : id COMMA ids | id ; 
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
