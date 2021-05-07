
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define pi acos(-1.0)
#define YYSTYPE double      /* yyparse() stack type */

void yyerror(const char *s){
	printf("ERROR: %s\n",s);
}


extern int yylex(void);

%}

%token NEWLINE NUMBER PLUS MINUS SLASH ASTERISK LPAREN RPAREN DOUBLESTERIK INC DEC LEFTSHIFT RIGHTSHIFT INTNUMBER MOD COSINE

%left LEFTSHI RIGHTSHI
%left DOUBLESTE
%left PLUS MINUS
%left MUL DIV MOD
%right UNMINUS UNPLUS
%nonassoc   INC DEC 
%%
input:              /* empty string */
    | input line
    ;
line: NEWLINE
    | expr NEWLINE          { printf("\t = %.10g\n",$1); }
    ;
expr: expr PLUS term    %prec PLUS    { $$ = $1 + $3; }
    | expr MINUS term   %prec MINUS    { $$ = $1 - $3; }
	| MINUS expr %prec UNMINUS { $$ = -$2 ; }
	| PLUS expr %prec UNPLUS { $$ = $2 ; }
    | term
    ;
term: term ASTERISK factor %prec MUL  { $$ = $1 * $3; }
    | term SLASH factor   %prec DIV  { if ( $3 == 0 )
								{
								yyerror("DIVIDE BY ZERO ERROR FOUND, RESULT IS UNDEFINED!!!");
								exit(0);
								}
								 else
									$$ = $1 / $3; }
	| term MOD num			{ if ( $3 == 0 )
								{
								yyerror("MOD BY ZERO ERROR FOUND, RESULT IS UNDEFINED!!!");
								exit(0);
								}
								 else
								 $$ = (int)$1 % (int)$3;  }
	
	| INC factor 			{ $$ = $2 + 1;}
	| factor INC 			{ $$ = $1 + 1; }
	| DEC factor			{ $$ = $2 - 1; }
	| factor DEC 			{ $$ = $1 - 1; }
	| expr LEFTSHIFT expr %prec LEFTSHI { $$ = (int)$1 << (int)$3;  }
	| expr RIGHTSHIFT expr %prec RIGHTSHI { $$ = (int)$1 >> (int)$3;  }
	| COSINE factor 		{ double x;
								x = $2 * ((double)pi /180.0);
								$$ = (double)cos(x);
							}
    | factor
    ;
factor: LPAREN expr RPAREN   { $$ = $2 ; }
	  | factor DOUBLESTERIK factor %prec DOUBLESTE 	 { $$ = pow ($1, $3); }
	  | INTNUMBER 
      | NUMBER
	  ;
num: INTNUMBER
	| MINUS INTNUMBER %prec UNMINUS { $$ = -$2 ; }
	| PLUS INTNUMBER %prec UNPLUS { $$ = $2 ; }
	| NUMBER { yyerror("MOD BY NUMBER HAVING DECIMAL is NOT ALLOWED !!!"); exit(0);}
	;

%%

main()
{
    yyparse();
    exit(0);
}
