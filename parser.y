%token NOTOKEN GREAT NEWLINE WORD GREATGREAT PIPE AMPERSAND LESS GREATAMPERSAND
%define parse.error verbose
%{
#include<stdio.h>
#include"command.h"
char * args[20];
int count=0;
//struct SimpleCommand * simple;
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
 void print(char ** a){
        for(int i=0;i<=count;i++){
        printf("%s \n",a[i]);
        }
 }
%}
%union {
  char * str;
  char ** args;
  struct SimpleCommand * sm;
}
%start command_list
%type<str> WORD arg_list
%type<sm> cmd_and_args
%%
arg_list:
     arg_list WORD {

       insertArg(simple,$2);
      }
      |{$$="";}
      ;
cmd_and_args:
      WORD arg_list{
       insertArgBeg(simple,$1);
        $$=simple;
      }
      ;
pipe_list:
      pipe_list PIPE cmd_and_args{insertCommand(com,$3);
                                  simple=createSimple();}
      |pipe_list LESS WORD  PIPE cmd_and_args{if(com->commandsNumber==1)com->firstInput=$3;}
      |pipe_list LESS WORD{com->inputfile=$3;}
      |cmd_and_args{insertCommand(com,$1);
                    simple=createSimple();}
      ;
io_modifier:
GREATGREAT WORD{com->append=1;com->outfile=$2;}
      |GREAT WORD{com->outfile=$2;}
      |GREATGREAT AMPERSAND WORD
      |GREAT AMPERSAND WORD
      |LESS WORD{;com->inputfile=$2;}
      ;
io_modifier_list:
      io_modifier_list io_modifier
      |/*empty*/
      ;
background_optional:
      AMPERSAND{com->background=1;}
      |/*empty*/
      ;
command_line:
      pipe_list io_modifier_list background_optional NEWLINE{YYACCEPT;}
			|NEWLINE{YYACCEPT;}/*accept empty cmd line*/
			|error NEWLINE{yyerrok;YYABORT;}
      /*error recovery*/
command_list:
			command_line command_list
			|NEWLINE{YYACCEPT;}
      ;/* command loop*/
%%
