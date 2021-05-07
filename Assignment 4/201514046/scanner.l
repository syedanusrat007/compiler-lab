%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<bits/stdc++.h>
#include <string>
#include <vector>
#include <iostream>
#include <list>
#include <string.h>
#include <cstring>
using namespace std;

int line_count=1;
int error=0;
FILE *logout;
FILE *tokenout;

#define MOD 101
#define SIZE 101

int hash_func(string str)
{
    int i;
    int hash=0;
    for(i=0; i<str.length(); i++)
    {
        hash += str[i]^i * 27;
        hash %= MOD;
    }
    return hash;
}

class symbolInfo
{
public:
    string name;
    string type;
    symbolInfo(){}
   symbolInfo(string n, string t)
    {
        name = n;
        type = t;
    }

};

class symbolTable
{
public:
    vector <symbolInfo > stable[SIZE];
   
	int look_up(string n)
    {
          int f=0;
        vector<symbolInfo>::iterator it;
        for(int i=0;i<SIZE;i++){
        for(it= stable[i].begin();it!=stable[i].end();it++){

            if( n== it->name)
            {
                f++;
               // break;
               return 1;
            }
     }
        }
        if(f==0)
        {
            return 0;
        }

    }


    void insert(string n, string type)

    {
        int key=hash_func(n);
		 if(look_up(n)==1){
			fprintf(logout," already exists.\n\n");
            return;
        }

        else{
         
		  symbolInfo e(n,type);
            stable[key].push_back(e);
		 vector<symbolInfo>:: iterator it;
		 for(int i=0;i<SIZE;i++){
                      if(stable[i].size() == 0)continue;
                  
				  fprintf(logout,"%d -->  ",i);
               for(it=stable[i].begin();it!=stable[i].end();it++){

                    //cout<<"\t<"<<it->name <<","<<it->type<<">"<<endl;
					fprintf(logout,"< %s,%s >",n.c_str(),type.c_str());
                    }
                    //cout<<endl;
					fprintf(logout,"\n");
                }
		  
        }
    }
};
symbolTable symtab;

%}

WHITESPACE [ \t\f\r\v]+ 
LETTER [a-zA-Z]
DIGIT [0-9]
DIGITS [0-9]+
FLOAT	{DIGITS}(\.{DIGITS})(E[+-]?{DIGITS})?
NEWLINE \n
CHAR   '.'|"'\\n'"|"'\\t'"|"'\\\\'"|"'\\“'"|"'\\a'"|"'\\f'"|"'\\r'"|"'\\b'"|"'\\v'"|"'\\0'"
chars	('[a-zA-Z]'|'[0-9]')
CHARLIT ('{CHAR}')
ID      [a-zA-Z_][a-zA-Z0-9_]*
ufcmnt     "/*"((([^\*/]+)+)|(\*+[^\*/]+)+|("/"+))+\** 
comntsin   (("//").*)
cmntmult   "/*"((([^*/]+)+)|(\*+[^*/]+)+|("/"+))+\**"*/"
decpoinerr  {DIGITS}?(\.{DIGITS}*)+
illEerr	   {DIGITS}(\.{DIGITS})?([Ee][+-]?{DIGITS}(\.{DIGITS})).+
invldchrtr [!@#$&0-9.\^]
iderr      {invldchrtr}+[a-zA-Z_]+[a-zA-Z0-9_]*
charerr 	('{LETTER}{LETTER}+')|('.?[^{CHAR}]')
string     \"(((\\)(\"))|[^"\n]|(\\)(\n))*\"
ufstring   \"(((\\)(\"))|[^"\n]|(\\)(\n))*
ufchar		('[a-zA-Z]|'[0-9])


%%

{NEWLINE} {line_count++;}

"if"	{
			fprintf(tokenout,"<IF>");
			fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n",line_count,yytext);
		}
		
"else"	{
			fprintf(tokenout,"<ELSE>");
			fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n",line_count,yytext);
		}
"for"	{
			fprintf(tokenout,"<FOR>");
			fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n",line_count,yytext);
		}
"while"	{
			fprintf(tokenout,"<WHILE>");
			fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n",line_count,yytext);
		}
"do"	{
			fprintf(tokenout,"<DO>");
			fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n",line_count,yytext);
		}
"break"	{
			fprintf(tokenout,"<BREAK>");
			fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n",line_count,yytext);
		}
"int"	{
			fprintf(tokenout,"<INT>");
			fprintf(logout,"Line no %d: TOKEN <INT> Lexeme %s found\n",line_count,yytext);
		}
		
"char"	{
			fprintf(tokenout,"<CHAR>");
			fprintf(logout,"Line no %d: TOKEN <CHAR> Lexeme %s found\n",line_count,yytext);
		}
"float"	{
			fprintf(tokenout,"<FLOAT>");
			fprintf(logout,"Line no %d: TOKEN <FLOAT> Lexeme %s found\n",line_count,yytext);
		}
		
"double"	{
			fprintf(tokenout,"<<DOUBLE>");
			fprintf(logout,"Line no %d: TOKEN <<DOUBLE> Lexeme %s found\n",line_count,yytext);
		}
"void"	{
			fprintf(tokenout," <VOID>");
			fprintf(logout,"Line no %d: TOKEN <VOID> Lexeme %s found\n",line_count,yytext);
		}
		
"return"	{
			fprintf(tokenout,"<RETURN>");
			fprintf(logout,"Line no %d: TOKEN <RETURN> Lexeme %s found\n",line_count,yytext);
		}
"switch"	{
			fprintf(tokenout,"<SWITCH>");
			fprintf(logout,"Line no %d: TOKEN <SWITCH> Lexeme %s found\n",line_count,yytext);
		}
		
"case"	{
			fprintf(tokenout,"<CASE>");
			fprintf(logout,"Line no %d: TOKEN <CASE> Lexeme %s found\n",line_count,yytext);
		}
"default"	{
			fprintf(tokenout,"<DEFAULT>");
			fprintf(logout,"Line no %d: TOKEN <DEFAULT> Lexeme %s found\n",line_count,yytext);
		}
		
"continue"	{
			fprintf(tokenout,"<CONTINUE>");
			fprintf(logout,"Line no %d: TOKEN <CONTINUE> Lexeme %s found\n",line_count,yytext);
		}
{comntsin}	{
			fprintf(tokenout,"<COMMENT>");
			fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n",line_count,yytext);
			line_count++;
		}
{cmntmult}	{
			fprintf(tokenout,"<COMMENT>");
			fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n",line_count+1,yytext);
			line_count++;
		}




"+"		|

"-"		{
			fprintf(tokenout,"<ADDOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n",line_count,yytext);
			string t="ADDOP";
			symbolTable symtab;
			symtab.insert(yytext,t);
		}
"*"		|

"/"     |
"%"		{
			fprintf(tokenout,"<MULOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n",line_count,yytext);
			string t="MULOP";
			
           symbolTable symtab;
			symtab.insert(yytext,t);
		}
"++"		|

"--"		{
			fprintf(tokenout,"<INCOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n",line_count,yytext);
			string t="INCOP";
			
            //symbolTable symtab;
			symtab.insert(yytext,t);
		}
"<"|"<="|">"|">="|"=="|"!="	 {
			fprintf(tokenout,"<RELOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found\n",line_count,yytext);
			string t="RELOP";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		}
"="		{
			fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found\n",line_count,yytext);
			string t="ASSIGNOP";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		}
"&&"|"!"|"||"	{
			fprintf(tokenout,"<LOGOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LOGOP> Lexeme %s found\n\n",line_count,yytext);
			string t="LOGOP";
			//symbolTable symtab;
			symtab.insert(yytext,t);
			}
"("|"\)"	{
			fprintf(tokenout,"<PAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <PAREN> Lexeme %s found\n\n",line_count,yytext);
			string t="PAREN";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		
			}
"{"|"\}"	{
			fprintf(tokenout,"<CURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <CURL> Lexeme %s found\n\n",line_count,yytext);
			string t="CURL";
			//symbolTable symtab;
			symtab.insert(yytext,t);
			
			}
"["|"\]"	{
			fprintf(tokenout,"<BRACKET,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <BRACKET> Lexeme %s found\n\n",line_count,yytext);
			string t="BRACKET";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		
			}
;		{
			fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found\n\n",line_count,yytext);
			string t="SEMICOLON";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		
		}
,		{
			fprintf(tokenout,"<COMMA,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found\n\n",line_count,yytext);
			string t="COMMA";
			//symbolTable symtab;
			symtab.insert(yytext,t);
		}
{illEerr}	{
				fprintf(logout,"Error at Line no %d: Ill formed of number such as %s .\n\n",line_count,yytext);
				error++;
			}
		
		
{DIGIT}+ 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found\n",line_count,yytext);
				string t="CONST_INT";
				//symbolTable symtab;
				symtab.insert(yytext,t);
			}
{FLOAT}     {
				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found\n",line_count,yytext);
				string t="CONST_FLOAT";
				//symbolTable symtab;
				symtab.insert(yytext,t);
			}
			
{ID}		{
				fprintf(tokenout,"<ID,%s>",yytext);
				
		        fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found\n\n",line_count,yytext);
				string t="ID";
				//symbolTable symtab;
				symtab.insert(yytext,t);
				
			}
{CHARLIT}|{chars} {
				fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n\n",line_count,yytext);
				string t="CONST_CHAR";
				//symbolTable symtab;
				symtab.insert(yytext,t);
				
			   }


{string}	{   fprintf(tokenout,"<STRING,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s found\n\n",line_count,yytext);
			}

{decpoinerr}	{
				fprintf(logout,"Error at Line no %d: Too many decimal points %s .\n\n",line_count,yytext);
				error++;
			}
{iderr}	{
				fprintf(logout,"Error at Line no %d: Invalid prefix %s .\n\n",line_count,yytext);
				error++;
			}
{charerr}	{
				fprintf(logout,"Error at Line no %d: Multicharacter constant error for character sequence %s .\n\n",line_count,yytext);
				error++;
			}

{ufstring}	{
				fprintf(logout,"Error at Line no %d: Unfinished string %s .\n\n",line_count,yytext);
				error++;
			}
{ufchar}	{
				fprintf(logout,"Error at Line no %d: Unfinished character %s .\n\n",line_count,yytext);
				error++;
			}


{ufcmnt}	{
				fprintf(logout,"Error at Line no %d: Unfinished comment %s .\n\n",line_count,yytext);
				error++;
			}			
			

%%

int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	//printf("1st: %s 2nd: %s\n\n",argv[0],argv[1]);
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	
	logout= fopen("log.txt","w");
	tokenout= fopen("token.txt","w");

	yyin= fin;
	yylex();
	fprintf(logout,"Total number of line : %d .\n",line_count);
	fprintf(logout,"Total number of error : %d .\n",error);
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	return 0;
}