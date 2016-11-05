%{
#include<string.h>
#include"y.tab.h"
%}
%option noyywrap
%%
[ \t]
\n    {return NEWLINE;}
">"   {return GREAT;}
"<"   {return LESS;}
"<<"  {return GREATGREAT;}
">&"  {return GREATAMPERSAND;}
"|"   {return PIPE;printf("pip");}
"&"   {return AMPERSAND;}
[^\t\n|&><][^\t\n|&><]*   {yylval.str=strdup(yytext);
                   return WORD;}
%%
