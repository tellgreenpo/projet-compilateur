 %{
#include <stdlib.h>
#include <stdio.h>
#include "include/ts.h"
#include "include/instructions.h"
//int str[26];
extern int size; 
int current_depth = 0;
enum t_type current_type; 
/*extern Node *head;
extern Node *current;*/ 
void yyerror(char *s);
//enum TYPE { T_INT, T_CONST_INT } ;
%}
%union { int nb; char *str; }
%token MAIN RETURN PRINTF CONST EOL DOT COMMA SEMICOLON 
       OPEN_BRACE CLOSE_BRACE OPEN_BRACKET CLOSE_BRACKET 
       OPEN_PARENT CLOSE_PARENT IF ELSE WHILE
       EXCLAM EQUALITY DIFF LESS MORE LESS_EQ MORE_EQ
%token <nb> NUMBER
%token <nb> EXPON
%token <str> ALPHA
%token <str> INT
%type <nb> value expr divMul
%type <str> name id
%type <nb> type 
%right EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE
%start main_structure
%%
/*fun : type name OPEN_PARENT params CLOSE_PARENT body ;*/

main_structure : type MAIN OPEN_PARENT params CLOSE_PARENT body ; // TODO - automatiser suppression *.txt

body : OPEN_BRACE {current_depth++;} declarations insts CLOSE_BRACE {if (current_depth > 0) {
                                      deleteScope(current_depth);
                                      current_depth--;
                                    } else {
                                      deleteScope(current_depth);
                                      current_depth = 0;
                                    }};

insts : inst insts | ;
inst : affectation
      | print
      | ifBlock
      | whileBlock
      | RETURN value SEMICOLON {affectation(0,$2);}
      | RETURN name SEMICOLON {
        int e = exists($2);
        if (e) {
          int add = getAddress($2);
          load(0,add);
        } 
        // else erreur, la variable n'existe pas 
      };

args : value COMMA args | value | ; // TODO - comment on gere les arguments dans la table des symboles ??
params : type name COMMA params | type name | ;

declaration : type ids SEMICOLON | type id EQUAL value SEMICOLON ;
declarations : declaration declarations | declaration;
affectation : name EQUAL value SEMICOLON {
                                          int e = exists($2);
                                          if (e) {
                                            int add = getAddress($1);
                                            affectation(14,$3);
                                            store(add, 14);
                                          } 
                                          // else erreur, la variable n'existe pas 
                                         } ;

print : PRINTF OPEN_PARENT value CLOSE_PARENT SEMICOLON { affectation(15, value);
                                                          print(15); 
                                                        };


// TODO - Mateo fait l'asm
ifBlock : IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE IF OPEN_PARENT condition CLOSE_PARENT body
        | ELSE body;

whileBlock : WHILE OPEN_PARENT condition CLOSE_PARENT body;

condition : valueOrVar
          | unaryOperand valueOrVar
          | valueOrVar binaryOperand valueOrVar;

binaryOperand : LESS | LESS_EQ | MORE | MORE_EQ | EQUALITY | DIFF;
unaryOperand: EXCLAM;

expr : expr EQUAL expr
| expr PLUS expr
| expr MINUS expr
| expr MULTIPLY expr
| expr DIVIDE expr
| name
| value;

value : NUMBER {$$ = $1;} | EXPON {$$ = $1;};
type : INT { current_type = INTEGER; $$ = current_type ; } 
    | CONST INT { current_type = CONSTINT; $$ = current_type ;} ;

name : ALPHA ; 
names : name COMMA names | name;

valueOrVar : value | name;

id : ALPHA {if (current_type == INTEGER) {insertFirst($1, size, INTEGER, current_depth);} 
            else if (current_type == CONSTINT) {insertFirst($1, size, CONSTINT, current_depth);}} ; 
ids : id COMMA ids | id ; 
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Analyser\n"); // yydebug=1;
  yyparse();
  return 0;
}
