#include "common.h"

//The definition of Grammar Tree
typedef struct TreeNode
{
    char tag[32];   
    // int symIndex;
    // int typeIndex;       
    union { //value
        int a;
        float b; // if using exp, precision of float may lost while using ATOF //TODO 
        char str[32];
    } val;
    int lineNo;			//TempLineNumber
	int nChild;			//Number of children
    int symbolIndex;
    int typeIndex;
	struct TreeNode *child[MAX_CHILD];

} GramTree;

GramTree * treeRoot;

void initTreeNode(GramTree* node);
GramTree * newTreeNode(char* tag,int n, ...);
void printGramTree(GramTree* node, int blank);
void printTreeNode(GramTree* node);