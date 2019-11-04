#include "semantic.h"

SymbolElem symbol_HashTable[MAX_HASHNUM]; //define hash table

SymbolElem symbol_Stack[MAX_STACKNUM]; //define symelem stack
int Top_of_stack = -1;  //the top of stack

// SymbolElem symList[MAX_STACKNUM];
// int global_Symbol_Index = 0;         //global sym  index,符号表
// Type typeList[MAX_STACKNUM];
// int global_Type_Index = 0;        //global type index，类型定义

//工具人函数
void printPhase(char * msg){
    printf("---------- %s ----------\n", msg);
}

void printError(char * msg){
    printf("\033[31mError %s \033[0m \n", msg);
}

void printProduction(GramTree* root){
    printf("%s -> ",root->tag);
    int i=0;
    while(i<root->nChild){
        printf("%s ",root->child[i]->tag);
        i++;
    }
    printf("\n");
}

void printSymbolElem(SymbolElem sym){
    printPhase("printSymbolElem() Start");
    printf("Symbol.Name is: %s\n",sym->name);
    printf("Symbol.lineNo is: %d\n",sym->lineNo);
    printf("Symbol.kind is: %d\n",sym->kind);    
    // TODO: More information
    printPhase("printSymbolElem() End");
}

void myPrintf(const char* format, ...){
	va_list vp;
	va_start(vp, format);
	vprintf (format, vp);
	va_end  (vp);
}

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
    printPhase("Handle_VarDec() Start");
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
        //printf("DEC:%s %s\n",root->child[0]->tag, root->child[0]->val.str);
        strcpy(res->name, root->child[0]->val.str); //复制名字
    }
    myPrintf("res= %s\n",res->name);
    printPhase("Handle_VarDec() End");
    return res;
}


//查找函数
SymbolElem findFromTable_Struct(char *name) {
    return findFromTable(name);
}

SymbolElem findFromTable(char *name){
    unsigned int HashNum = hash_pjw(name);
    SymbolElem res = symbol_HashTable[HashNum];
    while(res != NULL) {
        if(isEqual(res->name,name)) { 
            break;
        }
        res = res->right;
    }
    return res;
}


//工具函数
void Clear_TopOf_Stack() { //将最顶层进行清理
    printPhase("Clear Top of Stack");
    SymbolElem temp = symbol_Stack[Top_of_stack]; //最前面的
    while(temp != NULL) {
        SymbolElem toFree = NULL;
        //remove from Symbol Table
        unsigned int HashNum = hash_pjw(temp->name);
        SymbolElem p = symbol_HashTable[HashNum];
        if(p == NULL) {
            printError("error while clear stack");
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
            printError("error while clear stack");
        } else {
            free(toFree);
        }
        //下一步
        temp = temp->down;
    }
    Top_of_stack--; //退出嵌套
    printPhase("Finish Clear Top of Stack");
}

FieldList getFieldList(GramTree* root) { //DefList
    FieldList temp = malloc(sizeof(FieldListsize));
    FieldList head = NULL, tailer;
    GramTree* defList = root;
    while(defList != NULL) { //DefList -> Def DefList
        //printf("%s,%d\n",defList->tag,defList->nChild);
        if(defList->nChild == 0) { //DefList ->empty
            break;
        } else {
            GramTree* def = defList->child[0]; //Def -> sepcifier DecList SEMI
            Type tempType = getType(def->child[0]); // sepcifier
            GramTree* decList = def->child[1]; 
            while(decList != NULL) {    //DecList -> Dec | Dec COMMA DecList
                GramTree* Dec = decList->child[0];
                SymbolElem temp_Symbol = Handle_VarDec(Dec->child[0], tempType); //获得符号定义，下一步进行插入
                if(Dec->nChild == 3) { 
                    //Dec -> VarDec ASSOGNOP EXP 结构体内不能初始化
                    printErrorOfSemantic(15,Dec->child[2]->lineNo,Dec->child[2]->val.str); //ASSIGN
                } else { 
                    //Dec -> VarDec, 进行检查后插入
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
                        insert_Symbol_Table(temp_Symbol);
                    }
                }
                if(decList->nChild == 1) {
                    decList = NULL;
                } else {
                    decList = decList->child[2];
                }
            }
        }
        if(defList->nChild == 2) {
            defList = defList->child[1]; //next deflist
        } else {
            defList = NULL;
        }
    }
}

Type getType(GramTree* root) { //返回节点的Type
    // NOTE: root is Specifier
    assert(isEqual(root->tag,"Specifier"));
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
            if(isEqual(p->child[1]->child[0]->tag,"ID") == 1) {
                strcpy(res->name, p->child[1]->child[0]->val.str); //p->child[1] means OptTag
            } else {
                printError("Why not ID of Struct");
            }
            res->u.var = temp;
            res->lineNo = p->child[1]->lineNo;
            res->right = NULL;
            res->down = NULL;
            //插入到符号表中
            insert_Symbol_Table(res);
        } else if(count_of_child == 2) { //变量的声明，需要找到变量
            SymbolElem f = findFromTable_Struct(p->child[1]->child[0]->val.str);
            if(f == NULL) { //报错
                printErrorOfSemantic(17,p->child[1]->child[0]->lineNo,p->child[1]->child[0]->val.str);
                return NULL;
            } else {
                temp = f->u.var; 
            }
        }
    } else {
        myPrintf("error"); assert(0);
    }    
    myPrintf("getType in root %s, type is %d\n",root->tag,temp->kind);
    return temp;
}

void insert_Symbol_Table(SymbolElem p) {

    if(p==NULL){
        printError("Insert NULL Pointer into Symbol Table");
    }

    myPrintf("Start insert %s into SymbolTable at Stack Index %d, kind is ",p->name,Top_of_stack);
    switch (p-> kind){
        case VAR_ELEMENT:myPrintf("VAR_ELEMENT\n");break;
        case FUNCTION:myPrintf("FUNCTION\n");break;
        case STRUCTURE_ELEMENT:myPrintf("STRUCTURE_ELEMENT\n");break;
        default:break;
    }
    SymbolElem t = symbol_Stack[Top_of_stack]; //头元素
    //插入之前需要检查重定义，也就是名字重复
    while(t != NULL) {
        if(isEqual(t->name, p->name) == 1 && p-> kind == VAR_ELEMENT) {
            printErrorOfSemantic(3, p->lineNo, p->name); //error 3 redefine var
            return;
        }
        if(isEqual(t->name, p->name) == 1 && p-> kind == FUNCTION) {
            printErrorOfSemantic(4, p->lineNo, p->name); //error 3 redefine Function
            return;
        }
        if(isEqual(t->name, p->name) == 1 && p-> kind == STRUCTURE_ELEMENT) {
            printErrorOfSemantic(16, p->lineNo, p->name); //error 3 redefine Struct
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
    myPrintf("End insert into SymbolTable at Stack %d\n",Top_of_stack);
}


FieldList Handle_VarList(GramTree* root){
    // VarList -> ParamDec COMMA VarList| ParamDec
    printPhase("Handle_VarList() Begin");
    printProduction(root);
    FieldList res = NULL;
    FieldList tail = NULL;

    while(root!=NULL){
        // ParamDec -> Specifier VarDec
        GramTree* Paramdec = root->child[0];
        //assert(isEqual(Paramdec->child[0]->tag,"Specifier"));
        Type type = getType(Paramdec->child[0]);
        SymbolElem symbol = Handle_VarDec(Paramdec->child[1],type);
        insert_Symbol_Table(symbol);
        FieldList var = malloc(sizeof(FieldListsize));
        var->type = type;
        char *s1 = malloc(sizeof(symbol->name));
        strcpy(s1,symbol->name);
        var->name = s1;
        if(res == NULL){
            res = var;
            tail = var;
        }else{
            tail->tail = var;
            tail = var;
        }
        if(root->nChild==3){
            root = root->child[2];
        }else{
            break;
        }
    }
    
    printPhase("Handle_VarList() End");
    return res;
}

SymbolElem Handle_FunDec(GramTree* root){ 
    // FunDec ->  ID LP VarList RP | ID LP RP
    printPhase("Handle_FunDec() Begin");
    printProduction(root);
    SymbolElem res = malloc(sizeof(symElemsize));

    // Initialize res
    strcpy(res->name,root->child[0]->tag);
    res->lineNo = root->lineNo;
    res->kind = FUNCTION;
    res->down = NULL;
    res->right = NULL;
    res->u.func.complete = false;
    res->u.func.retType = NULL;
    res->u.func.varList = NULL;

    if(root->nChild == 4){
        res->u.func.varList = Handle_VarList(root->child[2]);
    }

    printPhase("Handle_FunDec() End");
    return res;
}

int isTypeEqual(Type a, Type b){
    return true;
}



Type Handle_Exp(GramTree* root){
    // TODO: Return the type of Exp
    printPhase("Handle_Exp() Begin");
    printProduction(root);    
    Type res = malloc(sizeof(Typesize));
    switch (root->nChild){
    case 1:
        root = root->child[0];
        // | ID
        if(isEqual(root->tag,"ID")){
            free(res);
            SymbolElem symbol = findFromTable_Struct(root->tag);
            if(symbol == NULL){
                printErrorOfSemantic(1,root->lineNo,symbol->name);
            }else if(symbol->kind == FUNCTION){
                printErrorOfSemantic(11,root->lineNo,symbol->name);
            }else{
                res = symbol->u.var;
            }
        }
        // | INT
        else if(isEqual(root->tag,"INT")){
            res->kind = BASIC;
            res->u.basic = INT_TYPE;
        }
        // | FLOAT
        else if(isEqual(root->tag,"FLOAT")){
            res->kind = BASIC;
            res->u.basic = FLOAT_TYPE;
        }else{
            printError("Switch in Handle_Exp Case 1");
        }
        break;
    case 2:
        /* TODO:code */
        // | MINUS Exp
        // | NOT Exp

        break;
    case 3:
        /* TODO:code */
        // Exp -> Exp ASSIGNOP Exp

        // | Exp AND Exp
        // | Exp OR Exp
        // | Exp RELOP Exp
        // | Exp PLUS Exp
        // | Exp MINUS Exp
        // | Exp STAR Exp
        // | Exp DIV Exp

        // | LP Exp RP
        // | ID LP RP
        // | Exp DOT ID
        break;    
    case 4:
        /* TODO:code */
        // | ID LP Args RP
        // | Exp LB Exp RB

        break;    
    default:
        printError("Switch in Handle_Exp");
        break;
    }

    printPhase("Handle_Exp() End");
    return res;
}


void Handle_Dec(GramTree* root, Type type){
    //Dec -> VarDec | VarDec ASSIGNOP Exp
    printPhase("Handle_Dec() Begin");
    printProduction(root);
    SymbolElem symbol = NULL;
    symbol = Handle_VarDec(root->child[0], type);
    if(root->nChild == 3){
        // TODO: compare type between VarDec and Exp
        Type type_exp = malloc(sizeof(Typesize));
        type_exp = Handle_Exp(root->child[2]);
        if(isTypeEqual(type,type_exp) == false){
            printErrorOfSemantic(5, root->lineNo,"");
        }

    }else if (root->nChild == 1){
        // Do nothing
    }else{
        printError("Number conflict"); assert(0);
    }
    printPhase("Handle_Dec() End");
}

void Handle_DecList(GramTree* root, Type type){
    // DecList -> Dec| Dec COMMA DecList
    printPhase("Handle_DecList() Begin");
    printProduction(root);
    while(root != NULL){
        Handle_Dec(root->child[0],type);
        if(root->lineNo == 3){
            root = root->child[2];
        }else{
            break;
        }
    }

    printPhase("Handle_DecList() End");
}

void Handle_Def(GramTree* root){
    //Def -> Specifier DecList SEMI
    printPhase("Handle_Def() Begin");
    printProduction(root);
    assert(root->lineNo == 3);
    Type type = getType(root->child[0]);
    Handle_DecList(root->child[1],type);
    printPhase("Handle_Def() End");
}

void Handle_DefList(GramTree* root){
    //DefList -> Def DefList | empty
    printPhase("Handle_DefList() Begin");
    printProduction(root);
    if(root->nChild == 0){
        return;
    }
    while(root->nChild == 2){
        Handle_Def(root->child[0]);
        root = root->child[1];

        if(!(root->nChild == 0 || root->nChild ==2)){
            printError("Handle_DefList");assert(0);
        }
    }


    printPhase("Handle_DefList() End");
}

void Handle_Stmt(GramTree* root, Type type){
    // TODO: Complete this function
    // Stmt -> Exp SEMI
    // | CompSt
    // | RETURN Exp SEMI
    // | IF LP Exp RP Stmt
    // | IF LP Exp RP Stmt ELSE Stmt
    // | WHILE LP Exp RP Stmt
    printPhase("Handle_Stmt() Begin");
    printProduction(root);


    printPhase("Handle_Stmt() End");
}

void Handle_StmtList(GramTree* root, Type type){
    //StmtList -> Stmt StmtList | empty
    printPhase("Handle_StmtList() Begin");
    printProduction(root);
    if(root->nChild == 0){
        return;
    }
    while(root->nChild == 2){
        Handle_Stmt(root->child[0], type);
        root = root->child[1];

        if(!(root->nChild == 0 || root->nChild ==2)){
            printError("Handle_StmtList");assert(0);
        }
    }

    printPhase("Handle_StmtList() End");
}

void Handle_CompSt(GramTree* root, Type type){
    // CompSt -> LC DefList StmtList RC
    printPhase("Handle_CompSt() Begin");
    printProduction(root);
    Handle_DefList(root->child[1]);
    Handle_StmtList(root->child[2], type);
    printPhase("Handle_CompSt() End");
}

void Handle_ExtDef(GramTree* root) {
    printPhase("Handle_ExtDef() Begin");
    if (isEqual( root->tag, "ExtDef") == 1) {   //ExtDef -> Specifier ExtDeclist SEMI
        if(isEqual( root->child[1]->tag, "ExtDecList") == 1) { 
            printProduction(root);
            myPrintf("tag:%s\n",root->child[0]->tag);
            Type temp_type = getType(root->child[0]); //get type of specifier
            if(temp_type == NULL) { //不进行插入
                return; 
            }
            GramTree* t = root->child[1];      //ExtDeclist
            while(t != NULL) {
                GramTree* curVarDec = t->child[0];  //VarDec
                SymbolElem res = Handle_VarDec(curVarDec, temp_type);
                insert_Symbol_Table(res);
                int n = t->nChild;
                if(n == 1) {        //DecList -> Dec
                    break;
                } else if(n == 3) {     //Dec COMMA DecList
                    t = t->child[2];
                }
            }
        } else if(isEqual( root->child[1]->tag, "FunDec") == 1) { 
            printProduction(root);  // ExtDef -> Specifier FunDec CompSt
            // Function ,meet {} stack ++;
            Top_of_stack ++;
            symbol_Stack[Top_of_stack] = NULL;
            myPrintf("tag:%s\n",root->child[0]->tag);
            Type return_type = getType(root->child[0]); 
            if(return_type == NULL) { //感觉不应该发生的
                assert(0);
                return; 
            }
            SymbolElem res = Handle_FunDec(root->child[1]);
            if(res == NULL){
                assert(0);
            }
            res->u.func.retType = return_type;
            if(isEqual(root->child[2]->tag,"CompSt")){
                res->u.func.complete = true;
                Handle_CompSt(root->child[2],return_type);
            }else{
                res->u.func.complete = false;
            }

            insert_Symbol_Table(res);
            Clear_TopOf_Stack();
        } else if(isEqual( root->child[1]->tag, "SEMI") == 1) { //special for STRUCT
            getType(root->child[0]);
            // TODO: Complete this function
        }

    }
    printPhase("Handle_ExtDef() End");
}

void Analyse(GramTree* root) { //分析函数
    int count_of_child = root->nChild; //孩子节点个数
    if(count_of_child == 0) {
        return;
    }
    if(isEqual(root->tag, "ExtDef") == 1){ //ExtDef
        printPhase("Originally Start Insert Into Table");
        Handle_ExtDef(root);
    } else {
        for(int i = 0; i < count_of_child; i++){ //开始进行分析
            if(root->child[i] != NULL) {
                Analyse(root->child[i]);
            }
        }
    }
}


void semanticParse(GramTree * root) {
    printPhase("Strat Semantic Parse");
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
        case 3: printf("Redefined variable \" %s \".",str); break;
        case 4: printf("Redefined function \" %s \".",str); break;
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
        case 15: if (isEqual(str,"struct")==0) printf("Redefined field \" %s \".", str); else printf("Initialize a field of structure."); break;
        case 16: printf("Duplicated name \" %s \".",str); break;
        case 17: printf("Undefined structure\" %s \".",str); break;
        default: break;
    }
    printf("\n");
}