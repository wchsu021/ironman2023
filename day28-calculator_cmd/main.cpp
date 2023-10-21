#include "main.h"
#include "yacc.tab.h"

extern int yyparse(void);

int main()
{
    printf("Please insert an equation, or \"exit\" for exit.\n");
    yyparse();
    return 0;
}
