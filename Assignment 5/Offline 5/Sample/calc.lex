%{
#include <malloc.h>
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}
WS [ \t]+
DIGIT [0-9]
NUMBER [-]?{DIGIT}+(\.{DIGIT}+)?
%%
{NUMBER} {sscanf(yytext,"%lf",&yylval); return NUMBER;}
"+" { return PLUS;}
"-" { return MINUS;}
"\n" { return NEWLINE;}
{WS} {}
%%
int yywrap(void){
return 1;}
