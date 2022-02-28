%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#include "include/analyser.h"
%}

%% 
[ \t]+ {};
"+" ECHO;
"-" ECHO;
"*" ECHO;
"/" ECHO;
"=" ECHO;