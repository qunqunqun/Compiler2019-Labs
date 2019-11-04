#include "semantic.h"

SymbolElem symbol_HashTable[MAX_HASHNUM]; //define hash table

SymbolElem symbol_Stack[MAX_STACKNUM]; //define symelem stack
int Top_of_stack = -1;  //the top of stack

// SymbolElem symList[MAX_STACKNUM];
// int global_Symbol_Index = 0;         //global sym  index,符号表
// Type typeList[MAX_STACKNUM];
// int global_Type_Index = 0;        //global type index，类型定义


//工具人函数
void semantic_Init(){ //初始化函数
    assert(Top_of_stack == -1);
    for (int i = 0; i < MAX_HASHNUM; i++) {
        symbol_HashTable[i] = NULL;
    }
    for (int i = 0; i < MAX_STACKNUM; i++) {
        symbol_Stack[i] = NULL;
    }
    //初始化栈顶
    Top_of_stack++;
}

unsigned int hash_pjw(char* name) {     //hash函数
    unsigned int val = 0, i;
    for (; *name; ++name) {
        val = (val << 2) + *name;
        if (i = val & ~0x3fff)
            val = (val ^ (i >> 12)) & 0x3fff;
    }
    return val;
}

int isEqual(char *a, char *b) {
    //printf("%s, %s\n",a,b);
    if(strcmp(a,b) == 0) {
        return 1;
    } else{
        return 0;
    }
}

//处理规则函数
SymbolElem Handle_VarDec(GramTree* root, Type type) { //处理varDec不进行插入操作
    printf("Handle_VarDec:%s\n",root->val.str);
    SymbolElem res = NULL;
    if (root->nChild == 4) { // VarDec ->VarDec LB INT RB 数组
        Type newType = malloc(sizeof(Typesize)); 
        newType->kind = ARRAY;
        newType->u.array.elem = type;
        newType->u.array.size = root->child[2]->val.a; //数值
        root = root->child[0];
        res = Handle_VarDec(root, newType);
    }
    else {
        res = malloc(sizeof(symElemsize)); //只有一个
        res->right = NULL;
        res->down = NULL;
        res->u.var = type;
        res->kind = VAR_ELEMENT;    
        res->lineNo = root->lineNo;
        printf("DEC:%s %s\n",root->child[0]->tag, root->child[0]->val.str);
        strcpy(res->name, root->child[0]->val.str); //复制名字
    }
    return res;
}




//获得类型函数
void Clear_TopOf_Stack() { //将最顶层进行清理
    printf("clear Top\n");
    SymbolElem temp = symbol_Stack[Top_of_stack]; //最前面的
    while(temp != NULL) {
        SymbolElem toFree = NULL;
        //remove from Symbol Table
        unsigned int HashNum = hash_pjw(temp->name);
        SymbolElem p = symbol_HashTable[HashNum];
        if(p == NULL) {
            printf("error while clear stack.\n");
        } else {
            if(isEqual(p->name, temp->name) == 1){ 
                toFree = p;
                symbol_HashTable[HashNum] = p->right;
            }
            else {
                while(p->right != NULL) {
                    if(isEqual(p->right->name, temp->name) == 1){
                        toFree = p->right;
                        p->right = toFree->right;
                    }
                }
            }
        }
        if(toFree == NULL) {
            printf("error while clear stack.\n");
        } else {
            free(toFree);
        }
        //下一步
        temp = temp->down;
    }
    Top_of_stack--; //退出嵌套
    printf("Finish clear\n");
}

FieldList getFieldList(GramTree* root) { //DefList
    FieldList temp = malloc(sizeof(FieldListsize));
    FieldList head = NULL, tailer;
    GramTree* defList = root;
    while(defList != NULL) { //DefList -> Def DefList
        printf("%s,%d\n",defList->tag,defList->nChild);
        if(defList->nChild == 0) { //DefList ->empty
            break;
        } else {
            GramTree* def = defList->child[0]; //Def -> sepcifier DecList SEMI
            Type tempType = getType(def->child[0]); // sepcifier
            GramTree* decList = def->child[1]; 
            while(decList != NULL) {    //DecList -> Dec | Dec COMMA DecList
                GramTree* Dec = decList->child[0];
                SymbolElem temp_Symbol = Handle_VarDec(Dec->child[0], tempType); //获得符号定义，下一步进行插入
                if(Dec->nChild == 3) { //Dec -> VarDec ASSOGNOP EXP
                    printErrorOfSemantic(15,Dec->child[2]->lineNo,Dec->child[2]->val.str); //ASSIGN
                } else { //Dec -> VarDec, 进行检查后插入
                    FieldList temp_F = head;
                    while(temp_F != NULL) {
                        if(isEqual(temp_F->name, temp_Symbol->name) == 1) {
                             printErrorOfSemantic(15,Dec->child[0]->lineNo,temp_F->name); //REDEFINE
                             break;
                        }
                        temp_F = temp_F->tail;
                    }
                    //check is OK and 进行插入到尾部
                    if(temp_F == NULL) {
                        temp_F = malloc(sizeof(FieldListsize));
                        temp_F->name = (char*)malloc(sizeof(char)*30);
                        strcpy(temp_F->name, temp_Symbol->name);
                        temp_F->type = tempType;
                        temp_F->tail = NULL;
                        if(head == NULL) {
                            head = temp_F;
                            tailer = head;
                        } else {
                            tailer->tail = temp_F;
                            tailer = temp_F;
                        }
                        //插入到符号表中
                        insert_Symbol_Table(temp_Symbol, Top_of_stack);
                    }
                }
                if(decList->nChild == 1) {
                    decList = NULL;
                } else {
                    decList = decList->child[2];
                }
            }
        }
        printf("%s,%d\n",defList->tag,defList->nChild);
        if(defList->nChild == 2) {
            defList = defList->child[1]; //next deflist
        } else {
            defList = NULL;
        }
    }
}

Type getType(GramTree* root) { //返回节点的Type
    printf("getType:%s\n",root->tag);
    Type temp = malloc(sizeof(Typesize));
    GramTree* p = root->child[0]; 
    if(isEqual(p->tag , "TYPE") == 1) { //节点类型int和float
        temp->kind = BASIC;   //基本变量类型
        if(isEqual(p->val.str , "int") == 1){   
            temp->u.basic = INT_TYPE;
        } else if(isEqual(p->val.str , "float") == 1){
            temp->u.basic = FLOAT_TYPE;
        }
    } else if(isEqual(p->tag, "StructSpecifier") == 1){    //Struct类型
        temp->kind = STRUCTURE;
        int count_of_child = p->nChild; //节点
        if(count_of_child == 5) { // StructSpecifier -> STRUCT OptTag LC DefList RC
            //如果是定义，开始循环嵌套
            Top_of_stack++;
            symbol_Stack[Top_of_stack] = NULL;
            temp->u.structure = getFieldList(p->child[3]);    //得到域
            //定义结束之后回退栈
            Clear_TopOf_Stack();
            //插入进符号表中
            SymbolElem res = malloc(sizeof(symElemsize)); 
            res->kind = STRUCTURE_ELEMENT;
            strcpy(res->name, p->child[1]->val.str); //p->child[1] means OptTag
            res->u.var = temp;
            res->lineNo = p->child[1]->lineNo;
            res->right = NULL;
            res->down = NULL;
            //插入到符号表中
            insert_Symbol_Table(res, Top_of_stack);

        } else if(count_of_child == 2) {
            //TOD:类型的重定义
        }
    } else {
        printf("error"); assert(0);
    }
    return temp;
}

void insert_Symbol_Table(SymbolElem p, int stackIndex) {
    printf("start insert into SymbolTable:%s\n",p->name);
    SymbolElem t = symbol_Stack[stackIndex]; //头元素
    //插入之前需要检查重定义，也就是名字重复
    while(t != NULL) {
        if(isEqual(t->name, p->name) == 1 && p-> kind == VAR_ELEMENT) {
            printErrorOfSemantic(3, t->lineNo, t->name); //error 3 redefine var
            return;
        }
        if(isEqual(t->name, p->name) == 1 && p-> kind == FUNCTION) {
            printErrorOfSemantic(3, t->lineNo, t->name); //error 3 redefine Function
            return;
        }
        if(isEqual(t->name, p->name) == 1 && p-> kind == STRUCTURE_ELEMENT) {
            printErrorOfSemantic(16, t->lineNo, t->name); //error 3 redefine Struct
            return;
        }
        t = t->down;
    }
    //No conflict and insert
    unsigned int hashIndex = hash_pjw(p->name);
    if(symbol_HashTable[hashIndex] == NULL) {
        symbol_HashTable[hashIndex] = p;
    } else {
        p->right = symbol_HashTable[hashIndex];
        symbol_HashTable[hashIndex] = p; 
    }
    //insert into stack and put into tail
    if(symbol_Stack[Top_of_stack] == NULL) {
        symbol_Stack[Top_of_stack] = p;
    } else {
        SymbolElem temp = symbol_Stack[Top_of_stack];
        while(temp->down != NULL) {
            temp = temp->down;
        }
        temp->down = p;
    }
}

void Insert_Into_Table(GramTree* root) {
    if (isEqual( root->tag, "ExtDef") == 1) {   //ExtDef -> Specifier ExtDeclist SEMI
        if(isEqual( root->child[1]->tag, "ExtDecList") == 1) { 
            printf("tag:%s\n",root->child[0]->tag);
            Type temp_type = getType(root->child[0]); //get type of specifier
            GramTree* t = root->child[1];      //ExtDeclist
            while(t != NULL) {
                GramTree* curVarDec = t->child[0];
                SymbolElem res = Handle_VarDec(curVarDec, temp_type);
                insert_Symbol_Table(res, Top_of_stack);
                int n = t->nChild;
                if(n == 1) {        //DecList -> Dec
                    break;
                } else if(n == 3) {     //Dec COMMA DecList
                    t = t->child[2];
                }
            }
        } else if(isEqual( root->child[1]->tag, "FunDec") == 1) { //special for Function


        } else if(isEqual( root->child[1]->tag, "SEMI") == 1) { //special for STRUCT
            getType(root->child[0]);
        }

    }
}

void Analyse(GramTree* root) { //分析函数
    int count_of_child = root->nChild; //孩子节点个数
    if(count_of_child == 0) {
        return;
    }
    if(isEqual(root->tag, "ExtDef") == 1){ //ExtDef
        printf("originally start Insert into Table\n");
        Insert_Into_Table(root);
    } else {
        for(int i = 0; i < count_of_child; i++){ //开始进行分析
            if(root->child[i] != NULL) {
                Analyse(root->child[i]);
            }
        }
    }
}


void semanticParse(GramTree * root) {
    printf("strat semantic parse \n");
    semantic_Init();
    if(root != NULL) {
        Analyse(root); //开始进行分析
    }
}

void printErrorOfSemantic(int error_type, int line_no, char* str) {
    printf("Error type \033[31m %d \033[0m at line \033[31m %d \033[0m: ", error_type, line_no);
    switch(error_type) {
        // case 1: printf("Undefined variable \"%s\"." , str); break;
        // case 2: printf("Undefined function \" %s \".", str); break;
        case 3: printf("Redefined variable \" %s \"."); break;
        case 4: printf("Redefined function \" %s \"."); break;
        // case 5: printf("Type mismatched for assignment."); break;
        // case 6: printf("The left-hand side of an assignment must be a variable."); break;
        // case 7: printf("Type mismatched for operands."); break;
        // case 8: printf("Type mismathced for return."); break;
        // case 9: printf("Function \" %s \" is not applicable for arguments."); break;
        // case 10: printf(str << " is not an array."); break;
        // case 11: printf("\" %s \" is not a function."); break;
        // case 12: printf(str << " is not an integer."); break;
        // case 13: printf("Illegal use of \" %s \"."); break;
        // case 14: printf("Non-existent field \" %s \"."); break;
        case 15: if (str != "struct") printf("Redefined field \" %s \".", str); else printf("Initialize a field of structure."); break;
        case 16: printf("Duplicated name \" %s \"."); break;
        // case 17: printf("Undefined structure\" %s \".",str); break;
        default: break;
    }
    printf("\n");
}