%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sanity = 100;
int user_choice;

void yyerror(const char *s);
int yylex(void);

void take_user_input();
void check_endings();

extern FILE *yyin;
%}

%union {
    int num;
    char* str;
}

%token DISPLAY CHOICE IF ELSE SET EXIT
%token IDENTIFIER STRING NUMBER
%type <str> STRING IDENTIFIER
%type <num> NUMBER expression condition

%left '+' '-'
%left '>' '<'
%right '='

%%

game:
    scene_list
    {
        check_endings();
    }
;

scene_list:
    scene
    | scene_list scene
;

scene:
    DISPLAY STRING ';'
    {
        printf("\n%s\n", $2);
        free($2);
    }
    | CHOICE STRING '{' choice_list '}'
    {
        printf("\n%s\n", $2);
        take_user_input();
        free($2);
    }
    | IF condition '{' scene_list '}'
    {
        if ($2) {
            printf("Condition met, processing scene block.\n");
        }
    }
    | ELSE '{' scene_list '}'
    {
        printf("Processing ELSE block.\n");
    }
    | SET IDENTIFIER '=' expression ';'
    {
        if (strcmp($2, "sanity") == 0)
            sanity = $4;
        printf("Setting: %s = %d\n", $2, $4);
        free($2);
    }
    | EXIT ';'
    {
        printf("Exiting the game...\n");
        exit(0);
    }
;

choice_list:
    choice
    | choice_list choice
    | scene_list
;

choice:
    STRING '{' scene_list '}'
    {
        static int choice_number = 1;
        if (choice_number == user_choice) {
            yyparse();
        }
        choice_number++;
        free($1);
    }
;

condition:
    IDENTIFIER '>' expression
    {
        $$ = (strcmp($1, "sanity") == 0 && sanity > $3);
        free($1);
    }
    | IDENTIFIER '<' expression
    {
        $$ = (strcmp($1, "sanity") == 0 && sanity < $3);
        free($1);
    }
;

expression:
    NUMBER
    {
        $$ = $1;
    }
    | IDENTIFIER
    {
        if (strcmp($1, "sanity") == 0) {
            $$ = sanity;
        } else {
            yyerror("Unknown identifier");
        }
        free($1);
    }
    | expression '+' expression
    {
        $$ = $1 + $3;
    }
    | expression '-' expression
    {
        $$ = $1 - $3;
    }
    | '(' expression ')'
    {
        $$ = $2;
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

void take_user_input() {
    printf("Enter your choice: ");
    scanf("%d", &user_choice);
}

void check_endings() {
    if (sanity > 50) {
        printf("You escaped with your sanity intact! (Ending 1)\n");
    } else if (sanity > 0) {
        printf("You escaped, but you are mentally broken. (Ending 2)\n");
    } else {
        printf("You succumbed to despair or madness in the asylum. (Ending 3)\n");
    }
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }

    printf("Welcome to the Asylum Survival Game!\n");
    yyparse();
    return 0;
}