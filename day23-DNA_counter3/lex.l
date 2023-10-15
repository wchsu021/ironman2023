%{
    int numA, numT, numC, numG, numU; 
%}

%x DNA_S
%x RNA_S

blank       [ \t]

%%

\*              { BEGIN 0; }
<*>{blank}      { ; }
<*>\n           { ; }
DNA             { BEGIN DNA_S; }
RNA             { BEGIN RNA_S; }
<DNA_S,RNA_S>A  { numA++; }
<DNA_S,RNA_S>C  { numC++; }
<DNA_S,RNA_S>G  { numG++; }
<DNA_S>T        { numT++; }
<RNA_S>U        { numU++; }
<DNA_S,RNA_S>\* { BEGIN 0; }
<DNA_S>[^ACGT]  { printf("wrong alphabet in DNA: "); ECHO; printf(".\n"); }
<RNA_S>[^ACGU]  { printf("wrong alphabet in RNA: "); ECHO; printf(".\n"); }

.               { ; } 

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    const char* sFile = "file.txt";
    FILE* fp = fopen(sFile, "r");
    if (fp == NULL)
    {
        printf("cannot open %s\n", sFile);
        return -1;
    }
    yyin = fp;
    yylex();
    printf("Counter :\nA: %d\nT: %d\nC: %d\nG: %d\nU: %d\n", numA, numT, numC, numG, numU);
    return 0;
}