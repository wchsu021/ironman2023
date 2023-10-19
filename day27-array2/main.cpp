#include "main.h"

extern int yyparse(void);
extern FILE* yyin;

int *arraySize = nullptr;
int *array = nullptr;

void PrintArrayMain(int *arr, int arrSize) {
    cout << "Array in main: [ ";
    for (int i = 0; i < arrSize; i++) {
        cout << arr[i] << " ";
    }
    cout << "]\n";
}

int main()
{
    const char* sFile = "file.txt";
    FILE* fp = fopen(sFile, "r");
    if (fp == NULL) {
        printf("cannot open %s\n", sFile);
        return -1;
    }

    int arrayMainSize = 0;
    int *arrayMain = new int[64];

    array = arrayMain;
    arraySize = (&arrayMainSize);
    
    yyin = fp;
    yyparse();
    fclose(fp);

    PrintArrayMain(arrayMain, arrayMainSize);

    delete [] arrayMain;

    return 0;
}
