%{
    int yylex(void);
%}

%x COMMENT

%%

\/\/              { BEGIN COMMENT; }
<COMMENT>[^\n]*   { ; }
<COMMENT>\n       { BEGIN 0; ECHO; }

.|\n              { ECHO; }


%%

int yywrap(void) {
    return 1;
}

int main(void) {
    const char* sFile = "file.cpp";
    FILE* fp = fopen(sFile, "r");
    if (fp == NULL)
    {
        printf("cannot open %s\n", sFile);
        return -1;
    }
    extern FILE* yyin;
    yyin = fp;
    yylex();
    return 0;
}