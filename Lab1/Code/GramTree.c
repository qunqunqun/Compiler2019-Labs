#include"GramTree.h"


struct GramTree *newTreeNode(enum TagOfNode tag,int n, ...){
    va_list valist;         //dynamic paraments
    va_start(valist, n);
    struct GramTree *root = (struct GramTree*)malloc(sizeof(struct GramTree));   //new node
    root->tag = tag;
    root->first_child = NULL;
    root->first_sibling = NULL;
    
    
}
