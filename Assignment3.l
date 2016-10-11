%{
#include <cstdio>
#include <iostream>
#include "AST.h"
#include "Assignment3.tab.hh"
#define YY_DECL extern "C" int yylex()

extern int error_count;
//ofstream flexoutfile;
%}

%option yylineno

DIGIT [0-9]
ALPHA [a-zA-Z]

%%
[ \t\n]  {

};
\/\/(.*?)\n {

}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] {

}

{DIGIT}+ {
    yylval.ival = atoi(yytext);
    return INT_VALUE;
}
int {
    return INT;
}
bool {
    return BOOLEAN;
}
true {
    return TRUE;
}
false {
    return FALSE;
}
main {
    return MAIN;
}
{ALPHA}({ALPHA}|{DIGIT})* {
    yylval.sval = strdup(yytext);
    return IDENTIFIER;
}
\[ {
    return OPEN_SQUAREBRACKET;
}
\] {
    return CLOSE_SQUAREBRACKET;
}
\{ {
    return OPEN_CURLYBRACE;
}
\} {
    return CLOSE_CURLYBRACE;
}
\( {
    return OPEN_PARANTHESIS;
}
\) {
    return CLOSE_PARANTHESIS;
}
\= {
    return EQUAL;
}
\+ {
    return PLUS;
}
\- {
    return MINUS;
}
\* {
    return MULTIPLY;
}
\/ {
    return DIVIDE;
}
\% {
    return MODULO;
}
; {
    return SEMICOLON;
}
. {++error_count;}
%%
