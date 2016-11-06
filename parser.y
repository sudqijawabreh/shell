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
     WORD arg_list {

      printf("inside %d \n",simple->argv);
       insertArg(simple,$1);
      }
      |{$$="";}
      ;
cmd_and_args:
      WORD arg_list{
       insertArg(simple,$1);
      printf("out %d \n",simple->argv);
        $$=simple;
      }
      ;
pipe_list:
      pipe_list PIPE cmd_and_args
      |pipe_list LESS WORD  PIPE cmd_and_args{printf("thre");}
      |cmd_and_args
      ;
io_modifier:
GREATGREAT WORD
      |GREAT WORD{printf("%s\n",$2);}
      |GREATGREAT AMPERSAND WORD
      |GREAT AMPERSAND WORD
      |LESS WORD{printf("%s\n",$2);}
      ;
io_modifier_list:
      io_modifier_list io_modifier
      |/*empty*/
      ;
background_optional:
      AMPERSAND
      |/*empty*/
      ;
command_line:
      pipe_list io_modifier_list background_optional NEWLINE{YYABORT;}
			|NEWLINE{YYABORT;}/*accept empty cmd line*/
			|error NEWLINE{yyerrok;}
      /*error recovery*/
command_list:
			command_line command_list
			|NEWLINE{YYABORT;}
      ;/* command loop*/
%%
