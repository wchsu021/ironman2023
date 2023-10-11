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
      expr '='              { printf("Result: %f\n", $1); }
    ;

expr:
      value                 { $$ = $1; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { $$ = $1 / $3; }
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



