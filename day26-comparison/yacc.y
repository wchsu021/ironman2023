%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

%}

%union {
    float   floatNum;
    int     intNum;
}

%token <intNum>   INTEGER
%token <floatNum> FLOAT

%type <floatNum> value expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

func:
      expr
        {
            printf("Left: %f\n", $1);
        } 
      '>' expr         
        {   printf("Right: %f\n", $4); 
            if ($1 > $4) 
                printf("Result: true\n"); 
            else 
                printf("Result: false\n"); 
        }
    ;

expr:
      value                 { $$ = $1; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         
        { 
            if ($3 == 0.0) { 
                yyerror("Error: divisor cannot be zero!"); 
                YYABORT; 
            } else { 
                $$ = $1 / $3; 
            } 
        }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'          { $$ = $2; }
    ;

value:
      FLOAT                 { $$ = $1; }
    | INTEGER               { $$ = (float)$1; }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



