#include"GramTree.h"

void printTreeNode(GramTree* node){
    printf("lineNo = %d, nChild = %d\n", node->lineNo, node->nChild);
    printf("tag = %s\n",node->tag);
    if(strcmp(node->tag,"FLOAT") == 0){
        printf("value:%f\n",node->val.b);
    }else if(strcmp(node->tag,"INT") == 0){
        printf("value:%d\n",node->val.a);
    }else{
        printf("value:%s\n",node->val.str);
    }

}

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

GramTree *newTreeNode(char* tag,int n, ...){
    va_list valist;         
    va_start(valist, n);

    GramTree *root = (GramTree*)malloc(sizeof(GramTree));   //new node
    // root->tag = tag;
    strcpy(root->tag, tag);

    initTreeNode(root);

    if(n == 0){
        root->lineNo = va_arg(valist, int);
    }else if(n <0){
        assert(0);
    }else{
        int i = 0;
        for(; i<n; i++){
            root->child[i] = va_arg(valist, GramTree*);
        }
        root->lineNo = root->child[0]->lineNo;
        root->nChild = n;
    }

    va_end(valist);
    return root;

}


// No indet now
void printGramTree(GramTree* node, int blank){


    printBlank(blank);

    if( node == NULL){
        printf("Printing GramTree, node == NULL\n");
        return;
    }

    if(node->nChild != 0){
        printf("%s (%d)\n",node->tag,node->lineNo);
        int i = 0;
        for(; i < node->nChild;i++){
            if( strcmp(node->tag, "EMPTY") == 0){
                continue;
            }
            printGramTree(node->child[i], blank+1);
        }
    }else{
        // if(strcmp(node->tag,"EMPTY") != 0){
        //     printf("%s",node->tag);
        // }
        printf("%s",node->tag);

        if (strcmp(node->tag,"ID") == 0 || strcmp(node->tag,"TYPE") == 0){
            printf(": %s", node->val.str);
        }
        else if (strcmp(node->tag,"INT") == 0){
            printf(": %d", node->val.a);
        }
        else if (strcmp(node->tag,"FLOAT") == 0){
            // printTreeNode(node);
            printf(": %f", node->val.b);
        }

        printf("\n");
        // if(strcmp(node->tag,"EMPTY") != 0){
        //     printf("\n");
        // }
    }


}