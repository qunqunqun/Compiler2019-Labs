#include<stdio.h>
#include "common.h"
#include "semantic.h"
#include "InterCode.h"

extern FILE* yyin;
extern int yylex();
extern int yyparse();
extern int yyrestart(FILE *);
extern char* codeFileName;

//version 1
int main(int argc, char ** argv){

	if(argc <= 1) return 1;
	FILE* f = fopen(argv[1], "r");
	if(f == NULL) { //Can't open
		perror(argv[1]);
		return 1;
	}
	codeFileName =  argv[2];
	//start parse
	ErrorFlag = 0;
	yyrestart(f);
	// yylex(); //using yyparse rather than yylex()
	yyparse();
	fclose(f);
	if( ErrorFlag == 0){
		//printGramTree(treeRoot,0);	//if has no error test senamatic
		printPhase("Grammar Tree Printf End");
		semanticParse(treeRoot);
		translateTree(treeRoot);
	}
	return 0;
}
