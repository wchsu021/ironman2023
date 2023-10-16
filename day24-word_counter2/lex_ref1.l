%{
    // int nchar, nword, nline;
    unsigned long charCount = 0, wordCount = 0, lineCount = 0;
%}

word [^ \t\n]+
eol \n

%%

{word}  { wordCount++; charCount += yyleng; }
{eol}   { charCount++; lineCount++; }
.       { charCount++; }

%%

char **fileList;
unsigned currentFile = 0;
unsigned nFiles;
unsigned long totalCC = 0;
unsigned long totalWC = 0;
unsigned long totalLC = 0;

int main(int argc, char **argv) {
    FILE *file;
    fileList = argv + 1;
    nFiles = argc - 1;
    if (argc == 1) return 0;
    if (argc == 2) {
        currentFile = 1;
        file = fopen(argv[1], "r");
        if (!file) {
            printf("cannot open %s\n", argv[1]);
            return -1;
        }
        yyin = file;
    }

    if (argc > 2) yywrap();
    yylex();
    if (argc > 2) {
        printf("%8lu %8lu %8lu %s\n", lineCount, wordCount,
        charCount, fileList[currentFile - 1]);
        totalCC += charCount;
        totalWC += wordCount;
        totalLC += lineCount;
        printf("%8lu %8lu %8lu total\n",totalLC, totalWC, totalCC);
    } else {
        printf("%8lu %8lu %8lu\n",lineCount, wordCount, charCount);
    }
    return 0;
    //---------------------------------------------------------------
    // const char* sFile = "file.txt";
    // FILE* fp = fopen(sFile, "r");
    // if (fp == NULL)
    // {
    //     printf("cannot open %s\n", sFile);
    //     return -1;
    // }
    // extern FILE* yyin;
    // yyin = fp;
    // yylex();
    // printf("Characters: %d\nWords: %d\nLines: %d\n", nchar, nword, nline);
    // return 0;
}

int yywrap()
{
    FILE *file = NULL;
    if ((currentFile != 0) && (nFiles > 1) && (currentFile < nFiles)) {
        /*
        * we print out the statistics for the previous file.
        */
        printf("%8lu %8lu %8lu %s\n", lineCount, wordCount,
        charCount, fileList[currentFile-1]);
        totalCC += charCount;
        totalWC += wordCount;
        totalLC += lineCount;
        charCount = wordCount = lineCount = 0;
        fclose (yyin); /* done with that file */
    }
    while (fileList[currentFile] != (char *)0) {
        file = fopen(fileList[currentFile++], "r");
        if (file != NULL) {
            yyin = file;
            break;
        }
        fprintf(stderr, "could not open %s\n", fileList[currentFile - 1]);
    }
    return (file ? 0 : 1); /* 0 means there's more input */
}