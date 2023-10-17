%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

int arraySum = 0;
int arraySize = 0;

%}

%token NUMBER

%%

func:
      '[' array ']'        { printf("Result: array size is %d; array sum is %d\n", arraySize, arraySum); }
    ;

array:
    | array NUMBER         { arraySum += $2; arraySize++; }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



