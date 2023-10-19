%{
#include "main.h"
#include "yacc.tab.h"
%}

posint      ([0-9]+)
blank_chars ([ \f\r\t\v]+)

%%

{posint}        { yylval = atoi(yytext); return NUMBER; }
{blank_chars}   { ; }
"["             { return yytext[0]; }
"]"             { return yytext[0]; }
\n              { ; }

%%

int yywrap(void) {
    cout << "Finish parsing!" << endl;
    return 1;
}
