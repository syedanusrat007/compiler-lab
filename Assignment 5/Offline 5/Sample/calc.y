%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
extern yylex();
void yyerror(char *);
%}
%token PLUS MINUS NUMBER NEWLINE 
%%
input:
	 | input line
	 ;
 
 line: NEWLINE
	 | expr NEWLINE {printf("\t%.10g\n",$1);}
	 ;
 expr: expr PLUS term {$$=$1 + $3;}
	 | expr MINUS term {$$=$1 - $3;}
	 | term
	 ;
 term: 
	 | factor
	 ;
 factor:
	   | NUMBER
	   ;
   
 %%
 void yyerror(char *s)
 {fprintf(stderr,"%s\n",s);}
 main()
 {
 yyparse();
 exit(0);
 }