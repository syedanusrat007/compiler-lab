%option noyywrap

%{
#include <stdio.h>
int word_count = 0;
%}

delim 			[  \t\n]
digit			[0-9]
letter                  [A-Za-z]
id                      {letter}+

%%
if {printf("<KEYWORD, %s>, line_num\n",yytext);}
then {printf("<KEYWORD, %s>, line_num\n",yytext);}
{id}	{printf("<ID, %s>, line_num\n",yytext); word_count++;}
{delim}+ {}
{digit}+	{  printf("digit:%s\n",yytext);  }
%%

int main()
{
	yylex();
	
	printf("Total Count: %d",word_count);
	
	return 0;
}
