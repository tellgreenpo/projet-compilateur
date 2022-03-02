 %{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union { int nb; const var; }
%token PLUS MINUS MULTIPLY DIVIDE EQUAL NUMBER ALPHA INT
       CONST EOL DOT COMMA SEMICOLON OPEN_BRACE CLOSE_BRACE
       OPEN_BRACKET CLOSE_BRACKET OPEN_PARENT CLOSE_PARENT 
       MAIN RETURN PRINTF
%start Analyseur
%%
/*fun : type name OPEN_PARENT params CLOSE_PARENT body ;*/

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body;

args : value COMMA args | value; 
params : type name COMMA params | type name;  
body : OPEN_BRACE insts CLOSE_BRACE ;
insts : inst insts | ;
inst : declaration 
      | affectation
      | print
      | RETURN value SEMICOLON
      | RETURN name SEMICOLON;
declaration : type names SEMICOLON 
              | CONST type names SEMICOLON ;
affectation : type name EQUAL value SEMICOLON 
              | name EQUAL value SEMICOLON
              | name EQUAL operation SEMICOLON;
print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON
        | PRINTF OPEN_PARENT name CLOSE_PARENT SEMICOLON;

signs : PLUS | MINUS | MULTIPLY | DIVIDE;
operation: operation signs operation | value;

value : NUMBER ;
type : INT ;

name : ALPHA end_name ;
end_name : ALPHA | NUMBER | ;
names : name COMMA names | name;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
