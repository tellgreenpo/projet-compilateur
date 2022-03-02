 %{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union { int nb; const var; }
%token PLUS MINUS MULTIPLY DIVIDE EQUAL NUMBER ALPHA INT
       CONST EOL DOT COMMA SEMICOLON OPEN_BRACE CLOSE_BRACE
       OPEN_BRACKEY CLOSE_BRACKET OPEN_PARENT CLOSE_PARENT 
       MAIN RETURN PRINTF
%start Analyseur
%%
fun : type name OPEN_PARENT params CLOSE_PARENT body ;

main_structure : MAIN OPEN_PARENT params CLOSE_PARENT ;

params : type value COMMA params | type value;
body : OPEN_BRACE insts CLOSE_BRACE ;
insts : inst insts | ;
inst : declaration 
      | affectation
      | PRINTF
      | RETURN ;
declaration : type name SEMICOLON | CONST type name SEMICOLON ;
affectation : type name EQUAL value | name EQUAL value;

signs : PLUS | MINUS | MULTIPLY | DIVIDE;
operation: operation signs operation | value;

value : NUMBER ;
type : INT ;

name : ALPHA end_name ;
end_name : ALPHA | NUMBER ;
;
;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
