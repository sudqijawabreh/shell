%{  
#include<string.h>
#include"y.tab.h"
%}
%option noyywrap
%%
[ \t]
\n return 0;
">"   {return GREAT;}
"<"   {return LESS;}
">>"    {return GREATGREAT;}
">&"  {return GREATAMPERSAND;}
"|"   {return PIPE;}
"&"   {return AMPERSAND;}
[^ \t\n][^ \t\n]*   {yylval.str=strdup(yytext);return WORD;}
%%
