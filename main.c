#include<stdio.h>
#include"command.h"

extern int yyparse();
int main(){
  simple=createSimple();
  yyparse();
  printf("%s \n",simple->args[0]);
  printf("%s \n",simple->args[1]);
  //printf("%s\n",co->simpleCommand[30]->args[92]);
  return 0;
}
