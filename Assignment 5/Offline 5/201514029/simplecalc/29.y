%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define YYSTYPE double      /* yyparse() stack type */
#define PI acos(-1.0)

void yyerror(const char *s){
	printf("%s\n",s);
}

extern int yylex(void);
int i,j;
%}

%token NEWLINE NUMBER INC DEC POW ASTERISK SLASH MOD PLUS MINUS LEFTSHIFT RIGHTSHIFT LPAREN RPAREN FACT LN LOG SQRT UNARYMINUS COS
%left PLUS MINUS
%left LN LOG
%right UNARYMINUS
%left POW

 

%%
input:              /* empty string */
    | input line
    ;
line: NEWLINE
    | expr NEWLINE           { printf("\t%.10g\n",$1); }
    ;
expr: expr PLUS term         { $$ = $1 + $3; }
    | expr MINUS term        { $$ = $1 - $3; }
	| MINUS expr %prec UNARYMINUS   { $$=-$2; }
	| term
    ;
term: term ASTERISK factor   { $$ = $1 * $3;printf("Result is "); }
    | term SLASH factor      { if($3 == 0) printf("undefined result"); else $$ = $1 / $3; printf("Result is ");  }
	| term MOD factor        { if($1==(int) $1 && $3==(int) $3) $$= (int) $1 % (int) $3;  else
								{
								  yyerror("Only integers!!!"); $$ = -1;
								}
                             }
	
	
	| PLUS expr                {$$ = + $2; }
    | factor
    ;

factor: LPAREN expr RPAREN  { $$ = $2; }
      | INC factor         { $$ = $2+1; }
      | DEC factor         { $$ = $2-1; }
	  | COS LPAREN expr RPAREN {$3=$3/180*PI; $$=cos($3); printf("COS is ");}
      | factor INC  { $$ = $1+1; }
      | factor DEC  { $$ = $1-1; }
	  | term LEFTSHIFT term      { $$ =(int) $1 << (int) $3; printf("Leftshift value is "); }
	  | term RIGHTSHIFT term     { $$ =(int) $1 >> (int) $3; printf("Rightshift value is ");}
	  | factor POW factor       { $$ = pow($1,$3); printf("Power is "); }
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
