%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}


%%
[ \t]+ ;
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLY;}
"/" {return DIVIDE;}
"=" {return EQUAL;}
"\n" {return EOL;}
"." {return DOT;}
"," {return COMMA;}
";" {return SEMICOLON;}
"const" {return CONST;}
"int" {return INT;}
"(" {return OPEN_PARENT;}
")" {return CLOSE_PARENT;}
"{" {return OPEN_BRACE;}
"}" {return CLOSE_BRACE;}
"[" {return OPEN_BRACKET;}
"]" {return CLOSE_BRACKET;}
"return" {return RETURN;}
"main" {return MAIN;}
"printf" {return PRINTF;}
[0-9]+ {//yyval.nb = atoi(yytext);
        return NUMBER;}
[A-Za-z]+ {//yyval.var = yytext[0];
            return ALPHA;}


%%
int yywrap()
{
return 1 ;
}
