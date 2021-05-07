%option noyywrap

%{
#include <stdio.h>
#include <iostream>

using namespace std;

int lineCount = 1;
int wcCount = 0;
%}
delim 			[  \t]
digit			[0-9]
letter          [a-zA-Z]
id              [a-zA-Z_][a-zA-Z0-9_]*

keyword         program|if|not|end|begin|else|then|do|while|function|procedure|integer|real|var|oh|array|write 
pm              [+-]
md              [*/]
mod              [%]
asop             :=
relop            =|<>|<|<=|>=|>
p                "("|")"|"["|"]"
comma            [,]
semcln           [;]
cln              [:]
dot              [..]

number          -?([0-9]+|[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?)
string           L?\"([^"\\]|\\['"?\\abfnrtv]|\\[0-7]{1,3}|\\[Xx][0-9a-fA-F]+)*\"
comnt            "{"[^}\n]*"}" 

%%
{keyword}	{cout<<"<KEYWORD ,"<<yytext<<" > ,"<<lineCount<<endl;}

{id}	{cout<<"<ID ,"<<yytext<<" > ,"<<lineCount<<endl;}
{p}     {cout<<"<PAREN ,"<<yytext<<" > ,"<<lineCount<<endl;}

{comma}     {cout<<"<COMMA ,"<<yytext<<" > ,"<<lineCount<<endl;}
{semcln}     {cout<<"<SEMICOLON ,"<<yytext<<" > ,"<<lineCount<<endl;}
{cln}     {cout<<"<COLON ,"<<yytext<<" > ,"<<lineCount<<endl;}
{dot}     {cout<<"<DOTDOT ,"<<yytext<<" > ,"<<lineCount<<endl;}

{asop}  {cout<<"<ASSIGNOP ,"<<yytext<<" > ,"<<lineCount<<endl;}
{relop}  {cout<<"<RELOP ,"<<yytext<<" > ,"<<lineCount<<endl;}


{pm}	{cout<<"<PLUSMINUS ,"<<yytext<<" > ,"<<lineCount<<endl;}
{md}	{cout<<"<MULDIV ,"<<yytext<<" > ,"<<lineCount<<endl;}
{mod}	{cout<<"<MOD ,"<<yytext<<" > ,"<<lineCount<<endl;}


{number} {	cout<<"<NUMBER ,"<<yytext<<" > ,"<<lineCount<<endl;} 
{string} {	cout<<"<STRING ,"<<yytext<<" > ,"<<lineCount<<endl;} 
{comnt} {	cout<<"<COMMENT ,"<<yytext<<" > ,"<<lineCount<<endl;}  
{delim}+ {}
\n {
	
	lineCount++;
     
}
%%

int main()
{
	yylex();
	
	cout<<"Total Line Count: "<<lineCount<<endl;
	cout<<"Total Word Count: "<<wcCount<<endl;
	
	return 0;
}
