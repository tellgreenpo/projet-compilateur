%{
#include <stdlib.h>
#include <stdio.h>
#include "include/analyser.h"
%}

%% 
[ \t]+ {};
"+" ECHO;
"-" ECHO;
"*" ECHO;
"/" ECHO;
"=" ECHO;

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