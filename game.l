%{
#include "game.tab.h"
%}

%%

"DISPLAY"        { return DISPLAY; }
"CHOICE"         { return CHOICE; }
"IF"             { return IF; }
"ELSE"           { return ELSE; }
"SET"            { return SET; }
"EXIT"           { return EXIT; }

[0-9]+           { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z_0-9]* { yylval.str = strdup(yytext); return IDENTIFIER; }
\"[^\"]*\"       { yytext[strlen(yytext) - 1] = '\0'; yylval.str = strdup(yytext + 1); return STRING; }

">"              { return '>'; }
"<"              { return '<'; }
";"              { return ';'; }
"="              { return '='; }
"{"              { return '{'; }
"}"              { return '}'; }
"+"              { return '+'; }
"-"              { return '-'; }

[ \t\n]+         ; // Ignore whitespace
.                { printf("Unknown token: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}