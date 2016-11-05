%token NOTOKEN GREAT NEWLINE WORD GREATGREAT PIPE AMPERSAND LESS GREATAMPERSAND
%union {
  char * str;
}
%type<str> WORD
%define parse.error verbose
%{
#include<stdio.h>
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
%}
%start command_list
%%
arg_list:
      WORD arg_list
      |{printf("arglist\n");}/*empty*/
      ;
cmd_and_args:
      WORD arg_list{printf("%s\n",$1);}
      ;
pipe_list:
      pipe_list PIPE cmd_and_args{printf("pipeList");}
      |cmd_and_args
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
