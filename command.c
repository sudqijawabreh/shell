#include"command.h"
#include<stdio.h>
#include"stdlib.h"
#include"string.h"
SimpleCommand * createSimple(){
  SimpleCommand * c=(SimpleCommand *)malloc(sizeof(SimpleCommand));
  c->argv=0;
  c->size=80;
  char ** args=(char **)malloc(c->size*(sizeof(char)));
  c->args=args;
  c->args[c->size]=0;
  return c;
}
command * createCommand(){
  command * c;
  c->size=100;
  c->commandsNumber=0;
  c->simpleCommand=(SimpleCommand **)malloc(c->size*sizeof(SimpleCommand));
  c->outfile=NULL;
  c->inputfile=NULL;
  c->errfile=NULL;
  c->firstInput=NULL;
  c->background=0;
  return c;
}
void insertArg(SimpleCommand * c,char * arg){
  /*if(c->argv==c->size){
    c->size=c->size*2;
    char ** temp=c->args;
    c->args=(char **)malloc(c->size*(sizeof(char))+1);
    c->args[c->size]=0;
   memcpy(c->args,temp,sizeof(char)*(c->size/2)-1);
  }*/
  c->args[c->argv]=arg;
  c->argv++;
}
void insertCommand(command * c,SimpleCommand * simple){
  /*if(c->commandsNumber==c->size){
    c->size=c->size*2;
    SimpleCommand ** temp=c->simpleCommand;
    c->simpleCommand=(SimpleCommand **)malloc(c->size*(sizeof(SimpleCommand)));
   //memcpy(c->simpleCommand,temp,c->size/2);
  }*/
  c->simpleCommand[c->commandsNumber]=simple;
  c->commandsNumber++;
}


