%{
#include "game.tab.h"
#include <string.h>
%}

%option noyywrap

%%

"flare"         { return a; }
"climb"         { return b; }
"23"            { return c; }
"option1"       { return e; }
"option2"       { return f; }
"option3"       { return g; }
"option4"       { return h; }
"fire"          { return i; }
"CLR"           { return k; }
[0-9]+          { yylval.string = strdup(yytext); return d; }
[0-9a-zA-Z_]+   { yylval.string = strdup(yytext); return j; }
[ \t\n]+        { /* Ignore whitespace */ }

%%



