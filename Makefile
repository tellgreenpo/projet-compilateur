GRM=source/analyseur.y
LEX=source/analyseur.l
BIN=analyseur

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o main.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -v $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm -rf $(OBJ) y.tab.c y.tab.h lex.yy.c

