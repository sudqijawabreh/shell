#include<stdio.h>
#include<stdlib.h>
#include"command.h"
#include<unistd.h>
#include<fcntl.h>

extern int yyparse();
void execute(command * c){
  int tmpin=dup(0);
  int tmpout=dup(1);


  int fdin;
  if(c->inputfile){
    fdin=open(c->inputfile,O_RDONLY);
  }
  else{
    fdin=dup(tmpin);
  }

  int ret;
  int fdout;
  for(int i=0;i<c->commandsNumber;i++){
    dup2(fdin,0);
    close(fdin);
    if(i==c->commandsNumber-1){
      if(c->outfile&&c->append==0){
        fdout=open(c->outfile,O_WRONLY|O_CREAT|O_TRUNC,0664);
        if(fdout==-1)return;
      }
      else if( c->append){
        fdout=open(c->outfile,O_WRONLY|O_CREAT|O_APPEND,0664);
        if(fdout==-1)return;
      }
      else{
        fdout=dup(tmpout);
      }
    }
    else{
      int fdpip[2];
      pipe(fdpip);
      fdout=fdpip[1];
      fdin=fdpip[0];
    }

    dup2(fdout,1);
    close(fdout);

    ret=fork();
    if(ret==0){
      dup2(fdin,0);
      execvp(c->simpleCommand[i]->args[0],c->simpleCommand[i]->args);
      perror("error");
      exit(1);
    }
  }

  dup2(tmpin,0);
  dup2(tmpout,1);
  close(tmpin);
  close(tmpout);

  if(!c->background){
    wait(ret,NULL);
  }

}
int main(){
  char  buf[200];
  while(1){
    if(getcwd(buf,sizeof(buf))==NULL){
      perror("current direcory");
      exit(1);
    }
  printf("%s$ ",buf);
  simple=createSimple();
  com=createCommand();
    if(yyparse())continue;
  if(strcmp(com->simpleCommand[0]->args[0],"cd")==0){
    chdir(com->simpleCommand[0]->args[1]);
  }
  else if(strcmp(com->simpleCommand[0]->args[0],"exit")==0){
    exit(0);
  }
  else{
    execute(com);
  }
}
return 0;
}
