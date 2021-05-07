%option noyywrap

%{
#include <stdio.h>
#include <iostream>

using namespace std;

int lineCount = 1;
int wcCount = 0;
%}

digit [0-9]

%%

{digit}+(\.{digit}+)? {
	cout<<"number: "<<yytext<<","<<lineCount<<endl;
}
\n {
	printf("Newline\n");
	lineCount++;
     cout<<"line number: "<<lineCount<<endl;
}



%%
int main(void)
{
	yylex();
	cout<<"Total Line Count: "<<lineCount<<endl;
	cout<<"Total Word Count: "<<wcCount<<endl;
	return 0;
}