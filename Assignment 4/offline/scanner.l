%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<bits/stdc++.h>
using namespace std;

int line_count=1;
int error=0;

FILE *logout;
FILE *tokenout;
#define MOD 1001
#define SIZE 1001

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
    string name;
    string type;

    symbolInfo(string n,string t){
        name=n;
        type=t;
    }
};

class symbolTable
{
public:
    vector <symbolInfo> stable[SIZE];
    int count1=0;
	bool lookup(string name,string type){
        int key=hash_func(name);
        count1=0;

        vector<symbolInfo> ::iterator it;
        for(it=stable[key].begin() ; it!=stable[key].end() ;it++){
            if(it->name == name)
                return true;
                count1++;
        }
        return false;
    }
	void insert (string name,string type){
        int key=hash_func(name);
        if(lookup(name,type)==true){
			fprintf(logout,"already inserted.\n\n");
            return;
        }
            symbolInfo e(name,type);
            stable[key].push_back(e);
    }
	void print(){
        int i,j;
        vector<symbolInfo>::iterator it;
        for(i=0;i<SIZE ;i++){
            if(stable[i].size()==0)
                continue;
			fprintf(logout,"%d -->  ",i);
            for(it=stable[i].begin();it!=stable[i].end();it++){
				string tp=it->type;
				string nm= it->name;
				char *n=new char[nm.length()+1];
				char  *t=new char [tp.length()+1];
				
				for(j=0;j<tp.length();j++)
				t[j]=tp[j];
				t[j]='\0';
				
				for(j=0;j<nm.length();j++)
				n[j]=nm[j];
				n[j]='\0';
				fprintf(logout,"< %s,%s >",n,t);
				//cout<<"name"<<it->name<<endl;
            }
			fprintf(logout,"\n");
			
        }
		fprintf(logout,"\n\n");
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
SMALL		('[a-zA-Z]')
CHAR		[travbf0n(\\)(\")]
EXP_CHAR_LIT ('\\{CHAR}') 
ID		({LETTER}|_)({LETTER}|{DIGIT}|_)*
COMMENT_UF	"/*"((([^\*/]+)+)|(\*+[^\*/]+)+|("/"+))+\**
COMMENTS	((\/)(\/).*)
COMMENTM	"/*"((([^\*/]+)+)|(\*+[^\*/]+)+|("/"+))+\**"*/"
DECERROR	{DIGITS}?(\.{DIGITS}*)+
EXPERROR	{DIGITS}?(\.{DIGITS})?((\.{DIGITS})*[Ee][+-]?{DIGITS}(\.{DIGITS})).*
INVCHAR		[!@#$&0-9.\^]
IDERROR		{INVCHAR}+({LETTER}|_)+({DIGITS}|{LETTER}|_)*
NUMERROR	{DIGITS}[{LETTER}|_]+
CHARERROR	('{LETTER}{LETTER}+')|('\\[^{CHAR}]')
STRING		\"(((\\)(\"))|[^"\n]|(\\)(\n))*\"
STRING_UF	\"(((\\)(\"))|[^";\n]*|(\\)(\n))*;
CHAR_UF		'[^';\"]*
BB	[#$\.]
WRONGID  ({LETTER}|_)+({LETTER}|_|{DIGITS})*{BB}+({LETTER}|_|{DIGITS}|{BB})*

%%

{NEWLINE} {line_count++;}
{WHITESPACE}	{}

"if"	{
			fprintf(tokenout,"<IF>");
			fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n\n",line_count,yytext);
		}
		
"else"	{
			fprintf(tokenout,"<ELSE>");
			fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n\n",line_count,yytext);
		}
"for"	{
			fprintf(tokenout,"<FOR>");
			fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n\n",line_count,yytext);
		}
"int"	{
			fprintf(tokenout,"<INT>");
			fprintf(logout,"Line no %d: TOKEN <INT> Lexeme %s found\n\n",line_count,yytext);
		}

"do"	{
			fprintf(tokenout,"<DO>");
			fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n\n",line_count,yytext);
		}
"float"	{
			fprintf(tokenout,"<FLOAT>");
			fprintf(logout,"Line no %d: TOKEN <FLOAT> Lexeme %s found\n\n",line_count,yytext);
		}
"void"	{
			fprintf(tokenout,"<VOID>");
			fprintf(logout,"Line no %d: TOKEN <VOID> Lexeme %s found\n\n",line_count,yytext);
		}		
"switch"	{
			fprintf(tokenout,"<SWITCH>");
			fprintf(logout,"Line no %d: TOKEN <SWITCH> Lexeme %s found\n\n",line_count,yytext);
		}
"default"	{
			fprintf(tokenout,"<DEFAULT>");
			fprintf(logout,"Line no %d: TOKEN <DEFAULT> Lexeme %s found\n\n",line_count,yytext);
		}
"while"	{
			fprintf(tokenout,"<WHILE>");
			fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n\n",line_count,yytext);
		}		
"break"	{
			fprintf(tokenout,"<BREAK>");
			fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n\n",line_count,yytext);
		}
"double"	{
			fprintf(tokenout,"<DOUBLE>");
			fprintf(logout,"Line no %d: TOKEN <DOUBLE> Lexeme %s found\n\n",line_count,yytext);
		}		
"char"	{
			fprintf(tokenout,"<CHAR>");
			fprintf(logout,"Line no %d: TOKEN <CHAR> Lexeme %s found\n\n",line_count,yytext);
		}

"return"	{
			fprintf(tokenout,"<RETURN>");
			fprintf(logout,"Line no %d: TOKEN <RETURN> Lexeme %s found\n\n",line_count,yytext);
		}		
"case"	{
			fprintf(tokenout,"<CASE>");
			fprintf(logout,"Line no %d: TOKEN <CASE> Lexeme %s found\n\n",line_count,yytext);
		}	

"continue"	{
			fprintf(tokenout,"<CONTINUE>");
			fprintf(logout,"Line no %d: TOKEN <CONTINUE> Lexeme %s found\n\n",line_count,yytext);
		}
{COMMENTS}	{
			fprintf(tokenout,"<COMMENT>");
			fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n",line_count,yytext);
			line_count++;
			}
{COMMENTM}	{
			fprintf(tokenout,"<COMMENT>");
			fprintf(logout,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n\n",line_count+1,yytext);
			line_count++;
			}

			
		
"+"		|

"-"		{
			fprintf(tokenout,"<ADDOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n\n",line_count,yytext);
			string t="ADDOP";
			symtab.insert(yytext,t);
			symtab.print();
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
		}
"*"		|
"/"		|
"%"		{
			fprintf(tokenout,"<MULOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n\n",line_count,yytext);
			string t="MULOP";
			symtab.insert(yytext,t);
			symtab.print();
		}
"++"	|
"--"	{
			fprintf(tokenout,"<INCOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n\n",line_count,yytext);
			string t="INCOP";
			symtab.insert(yytext,t);
			symtab.print();
		}
"<"|"<="|">"|">="|"=="|"!="		{
			fprintf(tokenout,"<RELOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found\n\n",line_count,yytext);
			string t="RELOP";
			symtab.insert(yytext,t);
			symtab.print();
		}
"="		{
			fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found\n\n",line_count,yytext);
			string t="ASSIGNOP";
			symtab.insert(yytext,t);
			symtab.print();
		}
"&&"|"!"|"||"	{
			fprintf(tokenout,"<LOGOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LOGOP> Lexeme %s found\n\n",line_count,yytext);
			string t="LOGOP";
			symtab.insert(yytext,t);
			symtab.print();
			}
"\("|"\)"	{
			fprintf(tokenout,"<PAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <PAREN> Lexeme %s found\n\n",line_count,yytext);
			string t="PAREN";
			symtab.insert(yytext,t);
			symtab.print();
			}
"\{"|"\}"	{
			fprintf(tokenout,"<CURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <CURL> Lexeme %s found\n\n",line_count,yytext);
			string t="CURL";
			symtab.insert(yytext,t);
			symtab.print();
			}
"\["|"\]"	{
			fprintf(tokenout,"<BRACKET,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <BRACKET> Lexeme %s found\n\n",line_count,yytext);
			string t="BRACKET";
			symtab.insert(yytext,t);
			symtab.print();
			}
;		{
			fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found\n\n",line_count,yytext);
			string t="SEMICOLON";
			symtab.insert(yytext,t);
			symtab.print();
		}
,		{
			fprintf(tokenout,"<COMMA,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found\n\n",line_count,yytext);
			string t="COMMA";
			symtab.insert(yytext,t);
			symtab.print();
		}
{EXPERROR}	{
				fprintf(logout,"Error at Line no %d: Ill formed of number such as %s .\n\n",line_count,yytext);
				error++;
			}
		
{DIGIT}+ 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line    no %d: TOKEN <CONST_INT> Lexeme %s found\n\n",line_count,yytext);
				string t="CONST_INT";
				symtab.insert(yytext,t);
				symtab.print();
				//insert in symbol table and print symbol table content(only non empty buckets)
			}			

{FLOAT} 	{
				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found\n\n",line_count,yytext);
				string t="CONST_FLOAT";
				symtab.insert(yytext,t);
				symtab.print();
				//insert in symbol table and print symbol table content(only non empty buckets)
			}
{WRONGID}		{
				fprintf(logout,"Error at Line no %d: INVALID IDENTIFIER %s .\n\n",line_count,yytext);
				error++;
			}			
{ID}		{
				fprintf(tokenout,"<ID,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found\n\n",line_count,yytext);
				string t="ID";
				symtab.insert(yytext,t);
				symtab.print();
			}

{EXP_CHAR_LIT}|{SMALL} {
				fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n\n",line_count,yytext);
				string t="CONST_CHAR";
				symtab.insert(yytext,t);
				symtab.print();
			   }			
{STRING}	{   fprintf(tokenout,"<STRING,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s found\n\n",line_count,yytext);
			}	
{DECERROR}	{
				fprintf(logout,"Error at Line no %d: Too many decimal points %s .\n\n",line_count,yytext);
				error++;
			}
{IDERROR}	{
				fprintf(logout,"Error at Line no %d: Invalid prefix %s .\n\n",line_count,yytext);
				error++;
			}
{NUMERROR}	{
				fprintf(logout,"Error at Line no %d: Invalid suffix %s .\n\n",line_count,yytext);
				error++;
			}
{CHARERROR}	{
				fprintf(logout,"Error at Line no %d: Multicharacter constant error for character sequence %s .\n\n",line_count,yytext);
				error++;
			}
{STRING_UF}	{
				fprintf(logout,"Error at Line no %d: Unfinished string %s .\n\n",line_count,yytext);
				error++;
			}
{CHAR_UF}	{
				fprintf(logout,"Error at Line no %d: Unfinished character %s .\n\n",line_count,yytext);
				error++;
			}
{COMMENT_UF}	{
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
	
	logout= fopen("201514021_log.txt","w");
	tokenout= fopen("201514021_token.txt","w");

	yyin= fin;
	yylex();
	fprintf(logout,"Total number of line : %d .\n",line_count);
	fprintf(logout,"Total number of errors : %d .\n",error);
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	return 0;
}