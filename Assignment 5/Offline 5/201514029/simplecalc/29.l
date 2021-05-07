%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>
#include <math.h>
#include "y.tab.h"

%}


WS [ \t]+
DIGIT [0-9]
NUMBER [-]?{DIGIT}+(\.{DIGIT}+)?
%%

{NUMBER}  {
  sscanf(yytext,"%lf", &yylval);
	     return NUMBER;
	  }

"+"       { return PLUS; }
"-"       { return MINUS; }
"~"       { return UNARYMINUS; }
"/"       { return SLASH; }
"**"       { return POW; }
"*"       { return ASTERISK; }
"("       { return LPAREN; }
")"       { return RPAREN; }
"%"       { return MOD; }
"<<"       { return LEFTSHIFT; }
">>"       { return RIGHTSHIFT; }
"++"      { return INC; }
cos        { return COS;}
"--"    { return DEC; }



"\n"      { return NEWLINE; }
{WS} { /* No action and no return */}
