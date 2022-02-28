%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}


%%
[ \t]+ {};
[0-9]+ {yyval.nb = atoi(yytext);
        return NUMBER_TOKEN}
[a-zA-Z]+ {yyval.var = yytext[0];
            return ALPHA_TOKEN};
"+" {return PLUS_TOKEN};
"-" {return MINUS_TOKEN};
"*" {return MULTIPLY_TOKEN};
"/" {return DIVIDE_TOKEN};
"=" {return EQUAL_TOKEN};
"\n" {return EOL_TOKEN};
"." {return DOT_TOKEN};
"," {return COMMA_TOKEN};
";" {return SEMICOLON_TOKEN};
"const" {return CONST_TOKEN};
"int" {return INT_TOKEN};
"(" {return OPEN_PARENT_TOKEN};
")" {return CLOSE_PARENT_TOKEN};
"{" {return OPEN_BRACE_TOKEN};
"}" {return CLOSE_BRACE_TOKEN};
"[" {return OPEN_BRACKET_TOKEN};
"]" {return CLOSE_BRACKET_TOKEN};
"return" {return RETURN_TOKEN};
"main" {return MAIN_TOKEN};
"printf" {return PRINTF_TOKEN};


%%
int yywrap()
{
return 1 ;
}
