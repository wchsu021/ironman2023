%{
#include "main.h"
#include "yacc.tab.h"
%}

posint      ([0-9]+)
blank_chars ([ \f\r\t\v]+)

%%

{posint}        { yylval = atoi(yytext); return NUM_T; }
"+"             { return yytext[0]; }
{blank_chars}   { ; }
\n              { ; }

%%

int yywrap(void) {
    return 1;
}
