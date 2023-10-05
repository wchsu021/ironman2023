%{
    int numA, numT, numC, numG;
    int lineno = 1;
    void yyerror(const char *s);
%}

%%

A    { numA++; }
T    { numT++; }
C    { numC++; }
G    { numG++; }
\n   { lineno++; }
.    { yyerror("invalid character"); yyterminate(); } 

%%

void yyerror(const char *s) {
    printf("line %d: %s at %s\n", lineno, s, yytext);
}

int yywrap(void) {
    printf("Counter :\nA: %d\nT: %d\nC: %d\nG: %d\n", numA, numT, numC, numG);
    return 1;
}

int main(void) {
    const char* sFile = "file.txt";
    FILE* fp = fopen(sFile, "r");
    if (fp == NULL) {
        printf("cannot open %s\n", sFile);
        return -1;
    }
    yyin = fp;
    yylex();
    return 0;
}