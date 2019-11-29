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
	# ./parser ../Test/A_1.cmm
	# ./parser ../Test/A_2.cmm
	# ./parser ../Test/A_3.cmm
	# ./parser ../Test/A_4.cmm
	# ./parser ../Test/A_5.cmm
	# ./parser ../Test/A_6.cmm
	# ./parser ../Test/A_7.cmm
	# ./parser ../Test/A_8.cmm
	# ./parser ../Test/A_9.cmm
	# ./parser ../Test/A_10.cmm 
	# ./parser ../Test/A_11.cmm
	# ./parser ../Test/A_12.cmm
	# ./parser ../Test/A_13.cmm
	# ./parser ../Test/A_14.cmm
	# ./parser ../Test/A_15.cmm
	# ./parser ../Test/A_16.cmm
	# ./parser ../Test/A_17.cmm
	# ./parser ../Test/A_18.cmm
	# ./parser ../Test/A_19.cmm
	# ./parser ../Test/A_20.cmm
	# ./parser ../Test/B_1.cmm
	# ./parser ../Test/B_2.cmm	
	# ./parser ../Test/C_1.cmm
	# ./parser ../Test/C_2.cmm	
	# ./parser ../Test/D_1.cmm
	# ./parser ../Test/D_2.cmm	
	# ./parser ../Test/D_3.cmm	
	# ./parser ../Test/E_2.cmm	

clean:
	rm -f parser lex.yy.c syntax.tab.c syntax.tab.h syntax.output
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC) $(YFC) $(YFC:.c=.h)
	rm -f *~

