cc=gcc
files= main.c parser.y scanner.l
build:	$(files)
	yacc -d parser.y
	lex scanner.l
	$(cc) main.c y.tab.c lex.yy.c command.h command.c -g -o a.out
	./a.out
clean:
	-rm -f lex.yy.c y.tab.c  y.tab.h
rebuild:	clean build
