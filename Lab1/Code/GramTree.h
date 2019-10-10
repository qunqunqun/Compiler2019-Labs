#include"common.h"

string DICT [] = {
	"TYPE", "STRUCT", "IF", "ELSE",
	"WHILE", "RETURN", "INT", "FLOAT",
	"ID", "SEMI", "COMMA", "ASSIGNNOP",
	"RELOP", "PLUS", "MINUS", "STAR",
	"DIV", "AND", "OR", "DOT",
	"NOT", "LP", "RP", "LB", "RB", "LC", "RC",

	"Program", "ExtDefList", "ERROR", "EMPTY",
	"ExtDef", "EXtDecList", "Specifier",
	"StructSpecifier", "OptTag", "Tag",
	"VarDec", "FunDec", "VarList", "ParamDec",
	"CompSt", "StmtList", "Stmt",
	"DefList", "Def", "DecList", "Dec",
	"Exp", "Args"
};

enum TagOfNode {
	TYPE, STRUCT, IF, ELSE,
	WHILE, RETURN, INT, FLOAT,
	ID, SEMI, COMMA, ASSIGNNOP,
	RELOP, PLUS, MINUS, STAR,
	DIV, AND, OR, DOT,
	NOT, LP, RP, LB, RB, LC, RC,

	Program, ExtDefList, ERROR, EMPTY,
	ExtDef, EXtDecList, Specifier,
	StructSpecifier, OptTag, Tag,
	VarDec, FunDec, VarList, ParamDec,
	CompSt, StmtList, Stmt,
	DefList, Def, DecList, Dec,
	Exp, Args
}

//The definition of Grammar Tree
struct GramTree
{
    int LineNo;                 //TempLineNumber
    TagOfNode tag;              
    union { //value
        int a;
        float b;
        char *str;
    } val;

    GramTree *first_child;   //child
    GramTree *slibing;       //neighbour
};

GramTree * root = nullptr;

GramTree * newTreeNode(int i,int n, ...);
GramTree * printGramTree();