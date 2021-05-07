%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<iostream>
#include<string>
#include<list>
#define SIZE 500
#define MOD 500
using namespace std;

int arr[SIZE];

int line_count=1;
int error_count=0;

FILE *logout;
FILE *tokenout;


int hash_func(string str)
{
    int i,len=str.length();
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

    symbolInfo(string names, string val)
    {
		
		item=names;
		type=val;		

    }


};


class symbolTable
{
public:
    list <symbolInfo> stable[SIZE];
	
    list<symbolInfo>::iterator it;

    void input(symbolInfo obj)
    {
        int index, counter;
		
        index = Search(obj.item);
		
        if(index==-1)
        {
			int i;
			char *itm,*tp;
			itm=new char[obj.item.length()];
			for ( i=0;i<obj.item.length();i++){
			itm[i]=obj.item[i];
			}
			itm[i]='\0';
			tp=new char[obj.type.length()];
			for ( i=0;i<obj.type.length();i++){
			tp[i]=obj.type[i];
			}
			tp[i]='\0';
			fprintf(logout,"<%s,%s> already exits\n",itm, tp);
		           			
        }
		else
		{
			arr[index]=1;
			stable[index].push_back(obj);
		}

    }

	void print()
    {
        for(int index = 0; index<SIZE; index++)
        {
            if(arr[index]!=0)
            {
                
                fprintf(logout,"%d ->",index);
                for(it=stable[index].begin(); it!=stable[index].end(); it++)
                    {
						int i;
						char *itm,*tp;
						int itemsz=it->item.length();
						int typesz=it->type.length();
						itm=new char[itemsz+1];
						for ( i=0;i<itemsz;i++){
						itm[i]=it->item[i];
						}
						itm[i]='\0';
						tp=new char[typesz+1];
						for ( i=0;i<typesz;i++){
						tp[i]=it->type[i];
						}
						tp[i]='\0';
						fprintf(logout,"<%s,%s>",itm, tp);
						
						
                    	
                    }


                fprintf(logout,"\n");

            }
        }
        fprintf(logout,"\n\n");
    }
	
	int Search(string s)
    {
		int index=hash_func(s); 
        
        if(arr[index])
        {
            for(it=stable[index].begin(); it!=stable[index].end(); it++)
            {
                if(s== it->item)
                {
                    return -1;
                }
            }
        }
        
        return index;
    }
}symtab;


%}

WHITESPACE [ \t\f\r\v\a\“\b\0\\]+ 

NEWLINE 		\n





PASS			([@!]|[0-9])[a-z]+[A-Z]*([0-9])?
DIGIT			[0-9]
digits			{DIGIT}+
number 			{digits}(\.{digits})?([eE][+-]?{digits})? 
LETTER          [A-Za-z]
ID              ((_)*)?{LETTER}({LETTER}|{digits})*
RELOP			(<|>|!=|<=|>=|==)
invalidid		((_)*)?{LETTER}[#$.]+({LETTER}|{digits})*
	



%%

{NEWLINE} 	{		line_count++;
				printf("\n");
			}
{WHITESPACE} {}

"if"		{
				fprintf(tokenout,"<IF>");
				fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n\n",line_count,yytext);
				 
			}
		
"else"		{
				fprintf(tokenout,"<ELSE>");
				fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n\n",line_count,yytext);
				 
			}
		
"for" 		{
				fprintf(tokenout,"<FOR>");
				fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n\n",line_count,yytext);
				 
			}
"while" 	{
				fprintf(tokenout,"<WHILE>");
				fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n\n",line_count,yytext);
				 
			}
"do" 		{
				fprintf(tokenout,"<DO>");
				fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
"break" 	{
				fprintf(tokenout,"<BREAK>");
				fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n\n",line_count,yytext);
				 
			}
"int" 		{
				fprintf(tokenout,"<INT>");
				fprintf(logout,"Line no %d: TOKEN <INT> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
"char" 		{
				fprintf(tokenout,"<CHAR>");
				fprintf(logout,"Line no %d: TOKEN <CHAR> Lexeme %s found\n\n",line_count,yytext);
				 
			}
"float" 	{
				fprintf(tokenout,"<FLOAT>");
				fprintf(logout,"Line no %d: TOKEN <FLOAT> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
"double" 	{
				fprintf(tokenout,"<DOUBLE>");
				fprintf(logout,"Line no %d: TOKEN <DOUBLE> Lexeme %s found\n\n",line_count,yytext);
				 
			}
"void" 		{
				fprintf(tokenout,"<VOID>");
				fprintf(logout,"Line no %d: TOKEN <VOID> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
"return" 	{
				fprintf(tokenout,"<RETURN>");
				fprintf(logout,"Line no %d: TOKEN <RETURN> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
"switch" 	{
				fprintf(tokenout,"<SWITCH>");
				fprintf(logout,"Line no %d: TOKEN <SWITCH> Lexeme %s found\n\n",line_count,yytext);
				 
			}  
"case" 		{
				fprintf(tokenout,"<CASE>");
				fprintf(logout,"Line no %d: TOKEN <CASE> Lexeme %s found\n\n",line_count,yytext);
				 
			}  
"default" {
				fprintf(tokenout,"<DEFAULT>");
				fprintf(logout,"Line no %d: TOKEN <DEFAULT> Lexeme %s found\n\n",line_count,yytext);
				 
			}   
"continue" {
				fprintf(tokenout,"<CONTINUE>");
				fprintf(logout,"Line no %d: TOKEN <CONTINUE> Lexeme %s found\n\n",line_count,yytext);
				 
			} 
\".*\"		{
				fprintf(tokenout,"<STRING,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s found\n",line_count,yytext);
				/* */
			}	

["].*(\\[^"].*)*["]	{

				fprintf(tokenout,"<MULTI_LINE_STRING,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <MULTI_LINE_STRING> Lexeme %s found\n",line_count,yytext);
				/* */
			}
"//".*		{				
				fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n",line_count,yytext);
				/* */
			}				

"/*"(.|\n)*"*/"		{
				
				fprintf(logout,"Line no %d: TOKEN <MULTI_LINE_COMMENT> Lexeme %s found\n",line_count,yytext);
				 
				/*("/*"( [^*] | (\*+[^* /]) )*\*+\/)*/
			}			
"("		{
					fprintf(tokenout,"<LPAREN,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LPAREN> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LPAREN");
					symtab.input(symbolIn);
					symtab.print();
			}
")"		{
					fprintf(tokenout,"<RPAREN,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <RPAREN> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"RPAREN");
					symtab.input(symbolIn);
					symtab.print();
			}	
"{"		{
					fprintf(tokenout,"<LCURL,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LCURL> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LCURL");
					symtab.input(symbolIn);
					symtab.print();
			}
"}"		{
					fprintf(tokenout,"<RCURL,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <RCURL> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"RCURL");
					symtab.input(symbolIn);
					symtab.print();
			}	
			
"["		{
					fprintf(tokenout,"<LBRACKET,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LBRACKET> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LBRACKET");
					symtab.input(symbolIn);
					symtab.print();
			}
"]"		{
					fprintf(tokenout,"<RBRACKET,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <RBRACKET> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"RBRACKET");
					symtab.input(symbolIn);
					symtab.print();
			}	
";"		{
					fprintf(tokenout,"<SEMICOLON,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"SEMICOLON");
					symtab.input(symbolIn);
					symtab.print();
			}
","		{
					fprintf(tokenout,"<COMMA,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"COMMA");
					symtab.input(symbolIn);
					symtab.print();
			}	
			

"+"		{
					fprintf(tokenout,"<ADDOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"ADDOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"-"			{
					fprintf(tokenout,"<SUBOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <SUBOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"SUBOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"*"			{
					fprintf(tokenout,"<MULOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"MULOP");
					symtab.input(symbolIn);
					symtab.print();
			}
			
"/"			{
					fprintf(tokenout,"<DIVOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <DIVOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"DIVOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"%"			{
					fprintf(tokenout,"<MODOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <MODOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"MODOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"="			{
					fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"ASSIGNOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"++"			{
					fprintf(tokenout,"<INCOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"INCOP");
					symtab.input(symbolIn);
					symtab.print();
			}			
"--"			{
					fprintf(tokenout,"<DECOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <DECOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"DECOP");
					symtab.input(symbolIn);
					symtab.print();
			}
{RELOP}		{
					fprintf(tokenout,"<RELOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"RELOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"&&"			{
					fprintf(tokenout,"<LOGICOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LOGICOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"||"	{
					fprintf(tokenout,"<LOGICOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LOGICOP");
					symtab.input(symbolIn);
					symtab.print();
			}
"!"			{
					fprintf(tokenout,"<LOGICOP,%s>",yytext);
					fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found\n",line_count,yytext);
					 
					symbolInfo symbolIn(yytext,"LOGICOP");
					symtab.input(symbolIn);
					symtab.print();
			}
					
{digits} 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found\n",line_count,yytext);
				 
				symbolInfo symbolIn(yytext,"CONST_INT");
                symtab.input(symbolIn);
				symtab.print();
			}
{number} 	{
				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found\n",line_count,yytext);
				 
				symbolInfo symbolIn(yytext,"CONST_FLOAT");
                symtab.input(symbolIn);
				symtab.print();
			}
'.'		{
				fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				 
				symbolInfo symbolIn(yytext,"CONST_CHAR");
                symtab.input(symbolIn);
				symtab.print();
			}
"'\\n'"		|
"'\\t'"		|
"'\\\\'"		|
"'\\“'"		|
"'\\a'"		|
"'\\f'"		|
"'\\r'"		|
"'\\b'"		|
"'\\v'"		|
"'\\0'"		 	{
				fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				 
				symbolInfo symbolIn(yytext,"CONST_CHAR");
                symtab.input(symbolIn);
				symtab.print();
			}
{ID}		{
				printf("Valid id");
				fprintf(tokenout,"<ID,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found\n",line_count,yytext);
				 			
				symbolInfo symbolIn(yytext,"ID");
                symtab.input(symbolIn);
				symtab.print();
				
			}
	
{invalidid}		{
					printf("Invalid ID");
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
	
	
	
	logout= fopen("008_log.txt","w");
	tokenout= fopen("008_token.txt","w");

	yyin= fin;
	yylex();
	
	fprintf(logout,"\nTotal Lines: %d", line_count);
	fprintf(logout,"\nTotal Errors: %d", error_count);
	
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	
	

	return 0;
}