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
statement: declaration SEMICOLON | asign SEMICOLON
operation: element PLUS element | element MINUS element | element MULTIPLY element | element DIVIDE element
declaration: datatype ALPHA | datatype asign
datatype: INT
    | constant
constant: CONST INT
asign: ALPHA EQUAL NUMBER | ALPHA EQUAL operation
element: ALPHA | NUMBER
;
;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
