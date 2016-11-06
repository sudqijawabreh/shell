%token NOTOKEN GREAT NEWLINE WORD GREATGREAT PIPE AMPERSAND LESS GREATAMPERSAND
%union {
  char * str;
  char ** args;
}
%type<str> WORD arg_list
%type<args> cmd_and_args
%define parse.error verbose
%{
#include<stdio.h>
char * args[20];
int count=0;
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
 void print(char ** a){
        for(int i=0;i<=count;i++){
        printf("%s \n",a[i]);
        }
 }
%}
%start command_list
%%
arg_list:
     arg_list WORD {
        args[count+1]=$2;
        $$=args;
        count++;
      }
      |{$$="";}
      ;
cmd_and_args:
      WORD arg_list{
        args[0]=$1;
        $$=args;
      }
      ;
pipe_list:
      pipe_list PIPE cmd_and_args
      |cmd_and_args{print($1);}
      ;
io_modifier:
GREATGREAT WORD
      |GREAT WORD{printf("%s\n",$2);}
      |GREATGREAT AMPERSAND WORD
      |GREAT AMPERSAND WORD
      |LESS WORD
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
      pipe_list io_modifier_list background_optional
			|NEWLINE/*accept empty cmd line*/
			|error NEWLINE{yyerrok;}
      /*error recovery*/
command_list:
			command_line command_list
			|NEWLINE
      ;/* command loop*/
%%
