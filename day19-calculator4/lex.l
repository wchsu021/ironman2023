%{
#include "main.h"
#include "yacc.tab.h"
%}

posint      ([0-9]+)
blank_chars ([ \f\r\t\v]+)
expressions ([-+*/])

%%

{posint}        { yylval = atoi(yytext); return NUMBER; }
{expressions}   { return yytext[0]; }
{blank_chars}   { ; }
"="             { return yytext[0]; }
\n              { ; }

%%

int yywrap(void) {
    return 1;
}
