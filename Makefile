GRM=source/analyseur.y
LEX=source/analyseur.l
BIN=analyseur

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o ts.o instructions.o jump_stack.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

ts.o: source/ts.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

instructions.o: source/instructions.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

jump_stack.o: source/jump_stack.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -v $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm -rf $(OBJ) y.tab.c y.tab.h lex.yy.c

test: all
	./analyseur < main.c

interpretor:
	$(CC) -g interpretor.c -o interpretor
