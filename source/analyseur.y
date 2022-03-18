 %{
#include <stdlib.h>
#include <stdio.h>
//int str[26];
void yyerror(char *s);
%}
%union { int nb; char *str; }
%token PLUS MINUS MULTIPLY DIVIDE EQUAL INT MAIN RETURN PRINTF
       CONST EOL DOT COMMA SEMICOLON OPEN_BRACE CLOSE_BRACE
       OPEN_BRACKET CLOSE_BRACKET OPEN_PARENT CLOSE_PARENT
%token <nb> NUMBER
%token <str> ALPHA
%type <nb> value expr divMul
%type <str> name
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


declaration : type names SEMICOLON
              | CONST type names SEMICOLON ;
affectation : type name EQUAL value SEMICOLON
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

value : NUMBER { $$ = $1;};
type : INT | ;

name : ALPHA { $$ = $1; }; 
names : name COMMA names | name;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
