%{  
#include<string.h>
#include"y.tab.h"
%}
#define YYSTYPE char *
%%
[ \t] 
\n return NEWLINE;
">"     { 
                return GREAT; 
        } 
"<"     { 
                return LESS; 
        } 
">>"    { 
                return GREATGREAT; 
        } 
">&"    { 
                return GREATAMPERSAND; 
        } 
"|"     { 
                return PIPE; 
        } 
"&"     { 
                return AMPERSAND; 
        } 
[^ \t\n][^ \t\n]*     { 
                yylval.str= strdup(yytext); 
                return WORD;
        } 
%%
