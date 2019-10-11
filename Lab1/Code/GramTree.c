#include"GramTree.h"

void printBlank(int blank){
    int i = 0;
    for(; i<2*blank;i++){
        printf(" ");
    }
}

void initTreeNode(GramTree* node){
    int i = 0;
    for(; i<MAX_CHILD;i++){
        node->child[i] = NULL;
    }
    node->nChild = 0;
}

GramTree *newTreeNode(enum TagOfNode tag,int n, ...){
    va_list valist;         
    va_start(valist, n);

    GramTree *root = (GramTree*)malloc(sizeof(GramTree));   //new node
    root->tag = tag;
    initTreeNode(root);

    if(n == 0){
        root->lineNo = va_arg(valist, int);
    }else if(n <0){
        assert(0);
    }else{
        int i = 0;
        for(; i<n; i++){
            root->child[i] = va_arg(valist, struct ast*);
        }
        root->lineNo = root->child[0]->lineNo;
        root->nChild = n;
    }

    va_end(valist);
    return root;

}


// No indet now
void printGramTree(GramTree* node, int blank){

    if( node == NULL){
        return;
    }

    if(node->nChild != 0){
        printf("%d %s\n",node->lineNo,node->val.str);
        int i = 0;
        for(; i < node->nChild;i++){
            printGramTree(node->child[i], blank+1);
        }
    }else{
        if (node->tag == TAG_ID || node->tag == TAG_TYPE){
            printf(": %s\n", node->val.str);
        }
        else if (node->tag == TAG_INT){
            printf(": %d\n", node->val.a);
        }
        else if (node->tag == TAG_FLOAT){
            printf(": %f\n", node->val.b);
        }
        else{
            assert(0);
        }
    }


}