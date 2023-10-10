%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

func:
      expr '='              { printf("Result: %d\n", $1); }
    ;

expr:
      NUMBER                { $$ = $1; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { $$ = $1 / $3; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'          { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



