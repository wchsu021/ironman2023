LEX=flex
YACC=bison
CC=g++
OBJECT=main

$(OBJECT): main.o yacc.tab.o lex.yy.o
		$(CC) main.o lex.yy.o yacc.tab.o -o $(OBJECT)
		@./$(OBJECT)

lex.yy.o: lex.yy.c yacc.tab.h main.h
		$(CC) -c lex.yy.c

yacc.tab.o: yacc.tab.c main.h
		$(CC) -c yacc.tab.c

yacc.tab.c yacc.tab.h: yacc.y
		$(YACC) -d yacc.y

lex.yy.c: lex.l
		$(LEX) lex.l

main.o: main.cpp
		$(CC) -c main.cpp

clean:
		@del -f $(OBJECT) *.o lex.yy.c yacc.tab.h yacc.tab.c main.exe
