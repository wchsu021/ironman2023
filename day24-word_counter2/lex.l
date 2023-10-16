%{
    int yylex(void);
    int nchar, nword, nline;
%}

word    [^ \t\n]+
eol     \n

%%

{eol}         { nline++; nchar++; }
{word}        { nword++, nchar += yyleng; }
.           { nchar++; } 

%%

int ncharTotal = 0;
int nwordTotal = 0;
int nlineTotal = 0;

char **fileList;
int currentFile = 0;
int nFiles;

int main(int argc, char **argv) {
    FILE *file;
    fileList = argv + 1;
    nFiles = argc - 1;

    if (argc == 1) {
        printf("No input files!\n");
        return -1;
    }

    if (argc == 2) {
        currentFile = 1;
        file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr,"could not open %s\n",argv[1]);
            return -1;
        }
        yyin = file;
    }

    if (argc > 2) yywrap();

    yylex();

    if (argc > 2) {
        printf("%s result: line %d, word %d, char %d\n", fileList[currentFile - 1], ++nline, nword, nchar);
        ncharTotal += nchar;
        nwordTotal += nword;
        nlineTotal += nline;
        printf("total: line %d, word %d, char %d\n", nlineTotal, nwordTotal, ncharTotal);
    } else {
        printf("A result: line %d, word %d, char %d\n", ++nline, nword, nchar);
    }
        
    return 0;
}

int yywrap() {
    FILE *file = NULL;
    if ((currentFile != 0) && (nFiles > 1) && (currentFile < nFiles)) {
        printf("%s result: line %d, word %d, char %d\n", fileList[currentFile - 1], ++nline, nword, nchar);
        ncharTotal += nchar;
        nwordTotal += nword;
        nlineTotal += nline;
        nchar = nword = nline = 0;
        fclose (yyin);
    }
    while (fileList[currentFile] != nullptr) {
        file = fopen(fileList[currentFile++], "r");
        if (file != NULL) {
            yyin = file;
            break;
        }
        fprintf(stderr, "could not open %s\n", fileList[currentFile - 1]);
    }
    return (file ? 0 : 1);
}