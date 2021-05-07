
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define YYSTYPE double                                  /* yyparse() stack type */

void yyerror(const char *s){
	printf("%s\n",s);
}

extern int yylex(void);

%}

%token NEWLINE NUMBER PLUS MINUS INC DEC LEFTSHIFT RIGHTSHIFT SLASH ASTERISK MOD DOUBLEASTERISK LPAREN RPAREN 
%left ab
%right bc
%nonassoc ac



%%
input:                                                      /* empty string */
    | input line
    ;
line: NEWLINE
    | expr NEWLINE                                          { printf("\t%.10g\n",$1); }
    ;
expr: expr PLUS term                    %prec ab            { $$ = $1 + $3; }
    | expr MINUS term                   %prec ab            { $$ = $1 - $3; }
	| expr LEFTSHIFT expr              %prec ab            { $$ =(int) $1 << (int) $3;}
    | expr RIGHTSHIFT expr             %prec ab            { $$ =(int) $1 >> (int) $3;}
	| term
	;
	
term: term ASTERISK factor              %prec ab             { $$ = $1 * $3; }
	
    | term SLASH factor                 %prec ab            { if($3 == 0)yyerror("undefined!");  else 
	                                                             $$ = $1 / $3; 
												            }
	| term MOD factor                   %prec ab            { if($1==(int) $1 && $3==(int) $3) $$= (int) $1 % (int) $3; else
								                     
								                                 yyerror("Only integers!!!"); 
								                     
                                                            }							                                                                                                      
	
	| MINUS   factor                    %prec ab            { $$ = -$2;}
	| PLUS   factor                     %prec ab            { $$ = $2;}
	
	| factor
	;
	
	
factor: INC factor                      %prec ac            { $$ = $2+1; }
      | DEC factor                      %prec ac            { $$ = $2-1; }
	  | factor  INC                     %prec ac            { $$ = $2+1; }
      | factor  DEC                     %prec ac            { $$ = $2-1; }
	  
	  | factor DOUBLEASTERISK factor    %prec ab            { $$ = pow($1,$3); }
	  | LPAREN expr RPAREN                                  { $$ = $2; } 
      | NUMBER
   
    ;
%%

main()
{
    yyparse();
    exit(0);
}
