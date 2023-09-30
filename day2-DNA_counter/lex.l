%{
    int numA, numT, numC, numG; 
%}

%%

A    { numA++; }
T    { numT++; }
C    { numC++; }
G    { numG++; }
.    { ; } 

%%

int yywrap(void) {
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
    printf("Counter :\nA: %d\nT: %d\nC: %d\nG: %d\n", numA, numT, numC, numG);
    return 0;
}