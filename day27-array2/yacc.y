%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

extern int* array;
extern int* arraySize;

void PrintArrayYacc() {
    cout << "Array in yacc: [ ";
    for (int i = 0; i < (*arraySize); i++) {
        cout << array[i] << " ";
    }
    cout << "]\n";
}

%}

%token NUMBER

%%

func:
      '[' array ']'        { PrintArrayYacc(); }
    ;

array:
    | array NUMBER         { array[(*arraySize)] = $2; (*arraySize)++; }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



