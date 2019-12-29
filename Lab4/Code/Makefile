# GNU make手册：http://www.gnu.org/software/make/manual/make.html
# ************ 遇到不明白的地方请google以及阅读手册 *************

# 编译器设定和编译选项
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -std=c99

# 编译目标：src目录下的所有.c文件
CFILES = $(shell find ./ -name "*.c")
OBJS = $(CFILES:.c=.o)
LFILE = $(shell find ./ -name "*.l")
YFILE = $(shell find ./ -name "*.y")
LFC = $(shell find ./ -name "*.l" | sed s/[^/]*\\.l/lex.yy.c/)
YFC = $(shell find ./ -name "*.y" | sed s/[^/]*\\.y/syntax.tab.c/)
LFO = $(LFC:.c=.o)
YFO = $(YFC:.c=.o)

parser: syntax $(filter-out $(LFO),$(OBJS))
	$(CC) -o parser $(filter-out $(LFO),$(OBJS)) -lfl -ly

syntax: lexical syntax-c
	$(CC) -c $(YFC) -o $(YFO)

lexical: $(LFILE)
	$(FLEX) -o $(LFC) $(LFILE)

syntax-c: $(YFILE)
	$(BISON) -o $(YFC) -d -v $(YFILE)

-include $(patsubst %.o, %.d, $(OBJS))

# 定义的一些伪目标
.PHONY: clean test
lexto:
	flex lexical.l
	gcc main.c lex.yy.c -lfl -o scanner

testScanner:
	./scanner ../Test/test0.cmm

bisonto:
	flex lexical.l
	bison -d syntax.y
	gcc syntax.tab.c GramTree.c main.c -lfl -ly -o parser

debug:
	flex lexical.l
	bison -d -v -t syntax.y
	gcc syntax.tab.c GramTree.c main.c -lfl -ly -o parser -D YY_DEBUG

gramTest:
	rm -f parser lex.yy.c syntax.tab.c syntax.tab.h syntax.output
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC) $(YFC) $(YFC:.c=.h)
	rm -f *~
	flex lexical.l
	bison -d syntax.y
	gcc syntax.tab.c GramTree.c main.c -lfl -ly -o parser	
	./parser ../Test/test15.cmm

test:
	./parser ../Test/test4.c ../Test/4.ir
	

addtionTest:
	./../parser ../Test/t1.cmm  ../SC/t1.s	
	./../parser ../Test/t2.cmm  ../SC/t2.s
	./../parser ../Test/test1.cmm  ../SC/test1.s	
	./../parser ../Test/test2.cmm  ../SC/test2.s
	./../parser ../Test/test3.cmm  ../SC/test3.s	
	./../parser ../Test/test4.cmm  ../SC/test4.s
	./../parser ../Test/A_1.cmm  ../SC/A_1.s
	./../parser ../Test/A_2.cmm  ../SC/A_2.s
	./../parser ../Test/A_3.cmm  ../SC/A_3.s
	./../parser ../Test/A_4.cmm  ../SC/A_4.s
	./../parser ../Test/B_1.cmm  ../SC/B_1.s
	./../parser ../Test/B_2.cmm  ../SC/B_2.s
	./../parser ../Test/B_3.cmm  ../SC/B_3.s
	./../parser ../Test/C_1.cmm  ../SC/C_1.s
	./../parser ../Test/C_2.cmm  ../SC/C_2.s
	./../parser ../Test/D_1.cmm  ../SC/D_1.s
	./../parser ../Test/E_11.cmm  ../SC/E_11.s
	./../parser ../Test/E_12.cmm  ../SC/E_12.s
	./../parser ../Test/E_13.cmm  ../SC/E_13.s
	./../parser ../Test/E_21.cmm  ../SC/E_21.s	
	./../parser ../Test/E_22.cmm  ../SC/E_22.s
	./../parser ../Test/E_23.cmm  ../SC/E_23.s
	./../parser ../Test/O_1.cmm  ../SC/O_1.s

clean:
	rm -f parser lex.yy.c syntax.tab.c syntax.tab.h syntax.output
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC) $(YFC) $(YFC:.c=.h)
	rm -f *~

