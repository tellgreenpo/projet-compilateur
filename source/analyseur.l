%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

number [0-9]
unary "++"|"--"
alpha [a-zA-Z]

%%
[ \t]+ {};
"+" {return PLUS_TOKEN};
"-" {return MINUS_TOKEN};
"*" {return MULTIPLY_TOKEN};
"/" {return DIVIDE_TOKEN};
"=" {return EQUAL_TOKEN};
[ ] {return SPACE_TOKEN};
"\n" {return EOL_TOKEN};
"." {return DOT_TOKEN};
"," {return COMMA_TOKEN};
";" {return SEMICOLON_TOKEN};
"const" {return CONST_TOKEN};
"int" {return INT_TOKEN};
"(" {return OPEN_BRACE_TOKEN};
")" {return CLOSE_BRACE_TOKEN};


%%
int yywrap()
{
return 1 ;
}
int main ()
{
yylex() ;
return 1 ;
}
