%{
#include "main.h"

void yyerror(const char *s);
extern int yylex();
extern int yyparse();

int *array = new int[64];
int arraySize = 0;

void PrintArray() {
    cout << "Array: ";
    for (int i = 0; i < arraySize; i++) {
        cout << array[i] << " ";
    }
    cout << ".\n";
}

%}

%token NUMBER

%%

func:
      '[' array ']'        { /*printf("Result: %d is %d\n", arraySize, array[arraySize-1]);*/ PrintArray(); delete [] array; }
    ;

array:
    | array NUMBER         { array[arraySize] = $2; arraySize++; }
    ;

%%

void yyerror(const char *s) {
    cerr << s << endl;
}



