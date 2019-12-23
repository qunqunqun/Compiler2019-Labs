#include<stdio.h>
#include "common.h"
// #include "semantic.h"
// #include "InterCode.h"
#include "objectCode.h"

extern FILE* yyin;
extern int yylex();
extern int yyparse();
extern int yyrestart(FILE *);
extern char* codeFileName;
extern char* compileFileName;

//version 1
int main(int argc, char ** argv){

	if(argc <= 1) return 1;
	FILE* f = fopen(argv[1], "r");
	if(f == NULL) { //Can't open
		perror(argv[1]);
		return 1;
	}
	codeFileName =  argv[2]; 	//Lab3 中间代码生成
	compileFileName =  argv[3]; //Lab4 汇编代码生成
	//start parse
	ErrorFlag = 0;
	yyrestart(f);
	// yylex(); //using yyparse rather than yylex()
	yyparse();
	fclose(f);
	if(ErrorFlag == 0){
		//printGramTree(treeRoot,0);	//if has no error test senamatic
		printPhase("Grammar Tree Printf End");
		semanticParse(treeRoot);
		InterCodes codes = translateTree(treeRoot);
		objectCode(codes); //转化为目标代码
	}
	return 0;
}
