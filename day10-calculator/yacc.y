%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

%}

%token NUM_T

%%

expr:
      NUM_T '+' NUM_T   { $$ = $1 + $3; printf("%d\n", $$); }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



