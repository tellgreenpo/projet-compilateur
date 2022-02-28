 %{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union { int nb; const var; }
%token PLUS MINUS MULTIPLY DIVIDE EQUAL NUMBER ALPHA INT
       CONST EOL DOT COMMA SEMICOLON OPEN_BRACE CLOSE_BRACE
%start Analyseur
%%
declaration: datatype INT
datatype: INT
    |CONST
;
;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}