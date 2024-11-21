%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int result;

void checkGameStatus();
void challengeOne();
void failC1();
void challengeTwo();
void failC2();
void challengeThree();
void failC32();
void failC33();
void failC34();
void challengeFour();
void failC4();
void bonusChallenge();
void failBonus();

void yyerror(const char *s);
int yylex();
%}

%union {
    char *string;  // For RANDOM_STRING
    int *integer; // FOR RANDOM_NUMBER
}

// Tokens
%token a b c e f g h i k
%token <integer> d 
%token <string> j

%%

Game : CH1 { checkGameStatus(); } ;
CH1 : a { challengeTwo(); } CH2 | b { failC1(); } ;
CH2 : c { challengeThree(); } CH3 | d { failC2(); } ;
CH3 : e { challengeFour(); } CH4 | f { failC32(); } | g { failC33(); } | h { failC34(); } ;
CH4 : i { bonusChallenge(); } BONUS | j { failC4(); } ;
BONUS : k | j { failBonus(); };

%%

void checkGameStatus()
{
    if(result == 0 )
    {
        printf("CONGRATULATIONS!!! You survived 'DO OR DIE'!\n\n");
    }
    else if(result == 1 )
    {
        printf("You have lost in challenge 1.GAME OVER!!\n");
    }
    else if(result == 2 )
    {
        printf("You have lost in challenge 2.GAME OVER!!\n\n");
    }
    else if(result == 3 )
    {
        printf("You have lost in challenge 3.GAME OVER!!\n\n");
    }
    else if(result == 4 )
    {
        printf("You have lost in challenge 4.GAME OVER!!\n\n");
    }
    else if(result == 5 )
    {
        printf("You have lost in Bonus challenge.GAME OVER!!\n\n");
    }
    exit(0);
};

void challengeOne()
{
    //Challenge 1 problem statement
    printf("You're trapped in a dark cave, and the air suddenly feels heavy. You hear a low growl echoing through the cavern—it's a bear, and it's slowly approaching.\n");
    printf("Do you :\nUse a flare you found earlier to scare it away? \nOr attempt to climb a nearby ledge to escape?\n");
    printf("Input (flare / climb) : ");
};

void challengeTwo()
{
    printf("The bright light and sparks startle the bear, and it retreats deeper into the cave, giving you time to escape.\n\n");

    //Challenge 2 problem statement
    printf("Now onto your next challenge...\n");
    printf("You find yourself locked in a dimly lit study room. On the desk, there's a dusty old box with a lock. On the lock you find the words Solve this to unlock the treasure: 10 + 5 × 3 - 4 ÷ 2 \n");
    printf("Input (Number) : ");
};

void challengeThree()
{
    printf("Hurray! You are a genius...you unlocked the treasure.\n\n");

    //challenge 3 problem statement
    printf("Now, onto your next challenge...\n");
    printf("You’re in a burning building, and you can only save one person. Four people are nearby, all needing help, who do you choose to save?\n");
    printf("A: Your childhood friend, who you’ve known since you were five and has the most embarrassing stories about you.\n");
    printf("B: Your boss, who could potentially give you a huge promotion if you save them.\n");
    printf("C: Your annoying neighbor who always borrows your ladder and never returns it, but they have a really good Wi-Fi password.\n");
    printf("D: The delivery driver who always brings your food still piping hot, even in the rain.\n");
    printf("Input (option1/option2/option3/option4) : ");
    

};

void challengeFour()
{
    printf("Look at you, loyalty champ of the burning building! Guess all those embarassing stories were worth saving then.\n\n");

    //challenge 4 problem statement
    printf("Now, onto your next challenge...\n");
    printf("You come across an old angry lady who wants you to help her solve a crossword she has been doing since forever. The clue for the password is : I am always hungry, I must always be fed. The finger I touch, will soon turn red. What am I?\n");
    printf("Input (String) : ");
};

void bonusChallenge()
{
    printf("Great job! You are very intellectual and you made the old lady very happy.\n\n");

    //Bonus problem statement
    printf("You think you were done!? Get ready for the last and ultimate question which will determine your fate! Here it goes......\n");
    printf("WHICH IS THE MOST POWERFUL PARSER ?\n");
    printf("Input (String) : ");
};

void failC1()
{
    result = 1;
    printf("As you try to climb, the bear catches up and pulls you down. You don’t survive.\n\n");
};

void failC2()
{
    result = 2;
    printf("Uh oh! You miscalculated...go learn your tables.\n\n");
};

void failC32()
{
    result = 3;
    printf("Corporate climber in a crisis, respect the hustle but loyalty zero stars buddy.\n\n");
};

void failC33()
{
    result = 3;
    printf(" Hope the internet's worth the shame.\n\n");
};

void failC34()
{
    result = 3;
    printf("Sure they keep your food hot, but your loyalty is ice cold.\n\n");
};

void failC4()
{
    result = 4;
    printf("Nooooo the old lady is angrier than ever...\n\n");

};

void failBonus()
{
    result = 5;
    printf("So close but yet so far...should've paid more attention in class!\n\n");
};

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
};

int main()
{
    result = 0;
    printf("Welcome to our Escape Room : DO or DIE!\nGet ready to test your abilities!!!\n\n");
    challengeOne();
    yyparse();
    return 0;
};