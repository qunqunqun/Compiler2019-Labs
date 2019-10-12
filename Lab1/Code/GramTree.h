#include "common.h"

// string DICT [] = {
// 	"TYPE", "STRUCT", "IF", "ELSE",
// 	"WHILE", "RETURN", "INT", "FLOAT",
// 	"ID", "SEMI", "COMMA", "ASSIGNNOP",
// 	"RELOP", "PLUS", "MINUS", "STAR",
// 	"DIV", "AND", "OR", "DOT",
// 	"NOT", "LP", "RP", "LB", "RB", "LC", "RC",

// 	"Program", "ExtDefList", "ERROR", "EMPTY",
// 	"ExtDef", "EXtDecList", "Specifier",
// 	"StructSpecifier", "OptTag", "Tag",
// 	"VarDec", "FunDec", "VarList", "ParamDec",
// 	"CompSt", "StmtList", "Stmt",
// 	"DefList", "Def", "DecList", "Dec",
// 	"Exp", "Args"
// };

// enum TagOfNode {
// 	TAG_TYPE, TAG_STRUCT, TAG_IF, TAG_ELSE,
// 	TAG_WHILE, TAG_RETURN, TAG_INT, TAG_FLOAT,
// 	TAG_ID, TAG_SEMI, TAG_COMMA, TAG_ASSIGNNOP,
// 	TAG_RELOP, TAG_PLUS, TAG_MINUS, TAG_STAR,
// 	TAG_DIV, TAG_AND, TAG_OR, TAG_DOT,
// 	TAG_NOT, TAG_LP, TAG_RP, TAG_LB, TAG_RB, TAG_LC, TAG_RC,

// 	Program, ExtDefList, ERROR, EMPTY,
// 	ExtDef, EXtDecList, Specifier,
// 	StructSpecifier, OptTag, Tag,
// 	VarDec, FunDec, VarList, ParamDec,
// 	CompSt, StmtList, Stmt,
// 	DefList, Def, DecList, Dec,
// 	Exp, Args
// };

//The definition of Grammar Tree
typedef struct TreeNode
{
    int lineNo;			//TempLineNumber
	int nChild;			//Number of children
    // enum TagOfNode tag;    
	char tag[32];          
    union { //value
        int a;
        float b;
        char str[32];
    } val;

    // GramTree *first_child;   //child
    // GramTree *slibing;       //neighbour

	struct TreeNode *child[MAX_CHILD];

}GramTree;

GramTree * treeRoot;

void initTreeNode(GramTree* node);
GramTree * newTreeNode(char* tag,int n, ...);
void printGramTree(GramTree* node, int blank);
void printTreeNode(GramTree* node);