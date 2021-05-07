%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>

#include <iostream>
#include <string>

#include <list>
#include <string.h>
#include <fstream>
#define MOD 100
#define SIZE 100

using namespace std;

int line_count=1;

int error_count=0;

FILE *logout;
FILE *tokenout;



int ar[SIZE];

int hash_func(string str)
{
    int i,len=strlen(str);
    int hash=0;
    for(i=0; i<len; i++)
    {
        hash += str[i]^i * 27;
        hash %= MOD;
    }
    return hash;
}

class symbolInfo
{
public:
    string item;
    string type;
//your code
    symbolInfo(string nam,string val)
	{
	    item=nam;
		type=val;
	}
	};
    

class symbolTable
{
public:
    list <symbolInfo> stable[SIZE];
    //your code
    list <symbolInfo>:: iterator it;

    void Insert(symbolInfo obj)
    {
        int index,cnt;
		index=search(obj.item);
		
		if(index==1)
		{
		   int x;
		   char *item1,*type1;
		   item1=new char[strlen(obj.item);
		   for(x=0;x<strlen(obj.item);x++) 
		   {
		      item1[x]=obj.item[x];
		   }
		   item1[x]='\0'
		   type1=new char[strlen(obj.type)];
		   for{x=0;x<strlen(obj.type);x++){
		   tp[x]=obj.type[x];
		   }
		   type1[x]='\0';
		   fprint(logout,"<%s,%s> Already exists\n",item1,type1);
		   error_count++;
		   }
		   else
		   {
		   ar[index]=1;
		   stable[index].push_back(obj);
		   }
		   }
        
	



    void print()
    {
        for(int index=0;index<=SIZE;index++)
        {
            if(ar[index]!=0)
            {
              fprint(logout"%d ->",index);
			  for(it=stable[index].begin(); it!=stable[index].end();it++)
			  {
			     int x;
				 char *item1,type1;
				 item1=new char[strlen(obj.item)];
				 for(x=0;x<strlen(obj.item);x++)
				 
				 {
				    item1[x]=obj.item[x];
				  }
				  item[x]='\0';
				  type1=new char[strlen(obj.type)];
				  for (x=0;x<strlen(obj.type);x++)
				  type1[x]=obj.type[x];
				  }
				  tp[x]='\0';
				  fprint(logout,"<%s,%s>",item1,type1);
				  
        }
          fprint("\n");
       }
	}
	   fprint("\n\n");
	   }
	   
	  int search(string s)
        {
          	int index=hash_func(s);
            
            if(ar[index])
               {
                  for(it=stable[index].begin(); it!=stable[index].end();it++)
                      {
                          if(s==it->item)
                           {
                             return -1;
                            }
                          }
                         }
                       return index;
                 }
               };
symbolTable symtab;
			   

 %}

WHITESPACE    [ \t\f\r\v\a\"\b\0\\]+ 
NEWLINE       \n
PASSWORD      ([@!]|[0-9])[A-Z]*([0-9])?
DIGIT         [0-9]
digits        {DIGIT}+
number        {digits} (\.{digits})?([eE] [+-]?{digits})?       
LETTER        [a-Za-Z]
ID            ((_)*)?{LETTER}({LETTER}|{DIGIT})*
RELOP         (<|>|!=|<=|>=|==)
ASSIGNOP      (&&|!|||)
LPAREN        (
RPAREN        )
LCURL         {
RCURL         }
LBRACKET      [
RBRACKET      ]
SEMICOLON     ;
COMMA         ,



%%

{NEWLINE} {line_count++;}
{WHITESPACE} ()

"if"	  {
			 fprintf(tokenout,"<IF>");
			 fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n\n\n",line_count,yytext);
		  }
		
"else"	  {
			fprintf(tokenout,"<ELSE>");
			fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n\n\n",line_count,yytext);
		  }
		
"for"	  {
		     fprintf(tokenout,"<FOR>");
			 fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n\n\n",line_count,yytext);
		  }
		
"while"   {
             fprintf(tokenout,"<WHILE>");
			 fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n\n\n",line_count,yytext);
		  }

"do"      {
              fprintf(tokenout,"<DO>");
			  fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n\n\n",line_count,yytext);
		  }

"break"   {
               fprintf(tokenout,"<BREAK>");
			   fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n\n\n",line_count,yytext);	
          }

"int"	  {
                fprintf(tokenout,"<int>");
			    fprintf(logout,"Line no %d: TOKEN <int> Lexeme %s found\n\n\n",line_count,yytext);  
		  }
		
"char"    {
                 fprintf(tokenout,"<char>");
			     fprintf(logout,"Line no %d: TOKEN <char> Lexeme %s found\n\n\n",line_count,yytext);
		  
		  }
		  
"float"   {    
                 fprintf(tokenout,"<float>");
			     fprintf(logout,"Line no %d: TOKEN <float> Lexeme %s found\n\n\n",line_count,yytext);
		  }


"double"  {
                 fprintf(tokenout,"<double>");
			     fprintf(logout,"Line no %d: TOKEN <double> Lexeme %s found\n\n\n",line_count,yytext);
		  }
		  
"void"    {
                 fprintf(tokenout,"<void>");
			     fprintf(logout,"Line no %d: TOKEN <void> Lexeme %s found\n\n\n",line_count,yytext);
		  }
		  
"return"   {
                 fprintf(tokenout,"<return>");
			     fprintf(logout,"Line no %d: TOKEN <return> Lexeme %s found\n\n\n",line_count,yytext);
		   }

"switch"   {
                 fprintf(tokenout,"<switch>");
			     fprintf(logout,"Line no %d: TOKEN <switch> Lexeme %s found\n\n\n",line_count,yytext);
		   }
		   
"case"     {
                 fprintf(tokenout,"<case>");
			     fprintf(logout,"Line no %d: TOKEN <case> Lexeme %s found\n\n\n",line_count,yytext);
		    }
"default"   {
                 fprintf(tokenout,"<default>");
			     fprintf(logout,"Line no %d: TOKEN <default> Lexeme %s found\n\n\n",line_count,yytext);
		    }
		
"continue"  {
                 fprintf(tokenout,"<continue>");
			     fprintf(logout,"Line no %d: TOKEN <continue> Lexeme %s found\n\n\n",line_count,yytext);
				 
			}
"/.*/"    {
                 
			     fprintf(tokenout,"<STRING,%s>");
			     fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s found\n\n\n",line_count,yytext);
		  
		  }
"//.x/"    {
                 
		         fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n\n",line_count,yytext);
		   }
"/*.**/
		  {
		         
			   fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n\n",line_count,yytext);
		   }
		  
		  
"+"		{
               fprintf(tokenout,"<ADDOP,%S>");
			   fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n\n\n",line_count,yytext);
			   symbolInfo symbolIn(yytext,"ADDOP");
			   symtab.input(symbolIn);
			   symtab.print();
		}
"-"      {
               
               fprintf(tokenout,"<SUBOP,%S>");
			   fprintf(logout,"Line no %d: TOKEN <SUBOP> Lexeme %s found\n\n\n",line_count,yytext);
			   symbolInfo symbolIn(yytext,"SUBOP");
			   symtab.input(symbolIn);
			   symtab.print();
		 }
"*"      {
              fprintf(tokenout,"<MULOP,%S>");
			  fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n\n\n",line_count,yytext);
			  symbolInfo symbolIn(yytext,"MULOP");
			   symtab.input(symbolIn);
			   symtab.print();
          }
"/"		 {
              fprintf(tokenout,"<DIVOP,%S>");
			  fprintf(logout,"Line no %d: TOKEN <DIVOP> Lexeme %s found\n\n\n",line_count,yytext);
			  symbolInfo symbolIn(yytext,"DIVOP");
			   symtab.input(symbolIn);
			   symtab.print();
          }  
"%"       {
              
              fprintf(tokenout,"<MODOP,%S>");
			  fprintf(logout,"Line no %d: TOKEN <MODOP> Lexeme %s found\n\n\n",line_count,yytext);
			  symbolInfo symbolIn(yytext,"MODOP");
			   symtab.input(symbolIn);
			   symtab.print();
          }
"++"      {
              fprintf(tokenout,"<INCOP,%S>");
			  fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n\n\n",line_count,yytext);
			  symbolInfo symbolIn(yytext,"INCOP");
			   symtab.input(symbolIn);
			   symtab.print();
          }
"--"      {
              fprintf(tokenout,"<DECOP,%S>");
			  fprintf(logout,"Line no %d: TOKEN <DECOP> Lexeme %s found\n\n\n",line_count,yytext);
			  symbolInfo symbolIn(yytext,"DECOP");
			   symtab.input(symbolIn);
			   symtab.print();
          }
{digits}  {
                fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found\n",line_count,yytext);
				symbolInfo symbolIn(yytext,"CONST_INT");
                symtab.input(symbolIn);
				symtab.print();
		  }

'{LETTER}' 
          {
                fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				symbolInfo symbolIn(yytext,"CONST_CHAR");
                symtab.input(symbolIn);
				symtab.print();
		  }
		

			
{ID}        {
                fprintf(tokenout,"<ID,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				symbolInfo symbolIn(yytext,"CONST_CHAR");
                symtab.input(symbolIn);
				symtab.print();
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
	
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	return 0;
}