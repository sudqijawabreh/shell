typedef struct SimpleCommand{
  int argv;
  int size;
  char ** args;
}SimpleCommand;
typedef struct command{
  int size;
  int commandsNumber;
  SimpleCommand ** simpleCommand;
  char * outfile;
  char * inputfile;
  char * errfile;
  char *  firstInput;
  int background;
}command;
void insertCommand(command * c,SimpleCommand * simple);
void insertArg(SimpleCommand * c,char * arg);
command * createCommand();
SimpleCommand * createSimple();
SimpleCommand * simple;
