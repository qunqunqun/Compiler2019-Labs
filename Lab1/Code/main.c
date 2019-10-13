#include<stdio.h>
#include "common.h"
#include "GramTree.h"

extern FILE* yyin;
extern int yylex();
extern int yyparse();
extern int yyrestart(FILE *);


//version 1
int main(int argc, char ** argv){

	if(argc <= 1) return 1;
	FILE* f = fopen(argv[1], "r");
	if(f == NULL) { //Can't open
		perror(argv[1]);
		return 1;
	}
	//start parse
	ErrorFlag = 0;
	yyrestart(f);
	// yylex(); //using yyparse rather than yylex()
	yyparse();
	fclose(f);
	printf("--------------Grammar Tree--------------\n");
	if(ErrorFlag == 1) { //No Error
		printGramTree(treeRoot,0);
	}
	return 0;
}
