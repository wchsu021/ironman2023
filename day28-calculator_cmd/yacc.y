%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();

%}

%union {
    float   floatNum;
    int     intNum;
}

%token <intNum>   INTEGER
%token <floatNum> FLOAT
%token MSG

%type <floatNum> value expr

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

lines:
    | lines expr '\n'       { printf("Result: %f\n", $2); printf("Please insert an equation, or \"exit\" for exit.\n");}
    | lines undef '\n'      { printf("Invalid!\n"); printf("Please insert an equation, or \"exit\" for exit.\n"); }
    ;

undef:
    | undef MSG
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



