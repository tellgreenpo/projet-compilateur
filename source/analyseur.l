%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}


%%
[ \t]+ ;
[ \n]+ ;
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
"==" {return EQUALITY;}
"!=" {return DIFF;}
"<" {return LESS;}
">" {return MORE;}
"<=" {return LESS_EQ;}
">=" {return MORE_EQ;}
"!" {return EXCLAM;}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"return" {return RETURN;}
"main" {return MAIN;}
"printf" {return PRINTF;}
[0-9]+ {yylval.nb = atoi(yytext);
        return NUMBER;}
[A-Za-z]+ {yylval.str = strdup(yytext);
            return ALPHA;}


%%
int yywrap()
{
return 1 ;
}
