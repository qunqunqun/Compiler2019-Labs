#include "semantic.h"

SymbolElem symbol_HashTable[MAX_HASHNUM]; //define hash table

SymbolElem symbol_Stack[MAX_STACKNUM]; //define symelem stack
int Top_of_stack = -1;  //the top of stack

SymbolElem symbol_List[MAX_STACKNUM];
int global_Symbol_Index = -1;         //glbal symbol list

Type type_List[MAX_STACKNUM];
int global_Type_Index = -1;        //global type list

int isPrint = false;

//工具人函数
void printPhase(char * msg){
    if(isPrint){
        printf("---------- %s ----------\n", msg);
    }
}

void printError(char * msg){
    printf("\033[31mError %s \033[0m \n", msg);
}

void printProduction(GramTree* root){
    if(isPrint){
        printf("%s -> ",root->tag);
        int i=0;
        while(i<root->nChild){
            printf("%s ",root->child[i]->tag);
            i++;
        }
        printf("\n");
    }
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
    if(isPrint){
        va_list vp;
        va_start(vp, format);
        vprintf (format, vp);
        va_end  (vp);
    }
}

void semantic_Init(){ //初始化函数
    assert(Top_of_stack == -1);
    for (int i = 0; i < MAX_HASHNUM; i++) {
        symbol_HashTable[i] = NULL;
    }
    for (int i = 0; i < MAX_STACKNUM; i++) {
        symbol_Stack[i] = NULL;
    }
    for (int i = 0; i < MAX_STACKNUM; i++) {
        symbol_List[i] = NULL;
        type_List[i] = NULL;
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
    printProduction(root);
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
    myPrintf("find name: %s\n",name);
    for(int i = Top_of_stack; i >= 0; i--) {
        SymbolElem temp = symbol_Stack[i];
        int cnts =0;
        while(temp != NULL) {
            myPrintf("round %d,Symbol in Stack: StackIndex:%d, Name:%s, Type:%d\n",cnts,i,temp->name,temp->kind);
            temp = temp->down;
            cnts++;
        }
    }

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
    printPhase("getFieldList");
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
                        temp_F->type = temp_Symbol->u.var;
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
    return head;
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
            // NOTE: have fixed here, Name
            temp->u.structure = malloc(sizeof(FieldListsize));
            temp->u.structure->name = malloc(sizeof(p->child[1]->child[0]->val.str));
            strcpy(temp->u.structure->name,p->child[1]->child[0]->val.str);
            temp->u.structure->type = NULL;
            temp->u.structure->tail = getFieldList(p->child[3]);    //得到域
            // temp->u.structure = getFieldList(p->child[3]);    //得到域
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
        // myPrintf("in stack, symbol.Name = %s\n",t->name);
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
    t = symbol_HashTable[hashIndex];
    while(t != NULL) {
        if(isEqual(t->name, p->name) == 1 && p-> kind == VAR_ELEMENT && t->kind != VAR_ELEMENT) {
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

    if(p->kind == VAR_ELEMENT){
        p->symIndex = insert_symbol_List(p);
    }

    myPrintf("End insert into SymbolTable at Stack %d\n",Top_of_stack);
}

int insert_symbol_List(SymbolElem p){
    global_Symbol_Index++;
    symbol_List[global_Symbol_Index] = p;
    return global_Symbol_Index;
}

SymbolElem findFromList(int index){
    return symbol_List[index];    
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

        // FIXME: 这里可能有问题
        GramTree* varDec = Paramdec->child[1];
        while(varDec->nChild == 4){
            varDec = varDec->child[0];
        }
        varDec->child[0]->symIndex = symbol->symIndex;

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
    strcpy(res->name,root->child[0]->val.str);
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

void CheckLeftAssign(GramTree* root){ //check exp if left assign
    printPhase("start Check Left Assign");
    printProduction(root);
    if(isEqual(root->tag, "Exp") == false){ //why
        assert(0);
    }
    if(root->nChild == 1) {
        if(isEqual(root->child[0]->tag, "ID") == true) {
            return;//correct; Exp->ID
        }
    } else if(root->nChild == 3) {
        if(isEqual(root->child[1]->tag,"DOT") && isEqual(root->child[2]->tag,"ID")) {
            return;//correct; Exp->Exp DOT ID
        }
    } else if(root->nChild == 4) {
        if(isEqual(root->child[1]->tag,"LB") && isEqual(root->child[2]->tag,"Exp") && isEqual(root->child[3]->tag,"RB")) {
            return;//correct; Exp->Exp LB Exp RB
        }
    }
    printPhase("start Check Left Assign");
    printErrorOfSemantic(6,root->lineNo,NULL);
}

int isFiledListEqual(FieldList a, FieldList b){
    while(a != NULL && b != NULL){
        if(isTypeEqual(a->type, b->type) == false) {
            return false;
        } else {
            a = a->tail;
            b = b->tail;
        }
    }
    if(a != NULL || b != NULL) {
        return false;
    } else {
        return true;
    }
}

int isTypeEqual(Type a, Type b){    //decide if Type is Equal
    if(a == NULL || b == NULL){    
        return false;
    }
    if(a->kind != b->kind){
        return false;
    }
    //Basic Type
    if(a->kind == BASIC) {
        if(a->u.basic != b->u.basic){
            return false;
        } else {
            return true;
        }
    }
    //Array Type
    if(a->kind == ARRAY) {
        if(a->u.array.size != b->u.array.size){
            return false;
        } else if(isTypeEqual(a->u.array.elem, b->u.array.elem) == false){
            return false;
        } else {
            return true;
        }
    }
    //Struct Type
    if(a->kind == STRUCTURE) {
        // FIXME: 选做2.3 结构体域相同，但是名字不同的话，也当做不同,会段错误
        // printError("1");
        myPrintf("struct a.Name= %s,struct b.Name= %s\n",a->u.structure->name,b->u.structure->name);
        // printError("2");
        // TODO: Check whether this method is OK 
        if(isEqual(a->u.structure->name,b->u.structure->name)){
            return true;
        }else{
            return false;
        }
        // if(isFiledListEqual(a->u.structure, b->u.structure) == false){
        //     return false;
        // } else {
        //     return true;
        // }
    }
    assert(0);
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
            SymbolElem symbol = findFromTable_Struct(root->val.str);
            if(symbol == NULL){
                //1)  错误类型1：变量在使用时未经定义。
                printErrorOfSemantic(1,root->lineNo,root->val.str);
                return NULL;
            }else if(symbol->kind == FUNCTION){
                //11)  错误类型11：对普通变量使用“(…)”或“()”（函数调用）操作符。
                printErrorOfSemantic(11,root->lineNo,symbol->name);
                return NULL;
            }else{
                res = symbol->u.var;
            }
            insert_Type_List(res);
            root->symIndex = symbol->symIndex;
            return res;
        }
        // | INT
        else if(isEqual(root->tag,"INT")){
            res->kind = BASIC;
            res->u.basic = INT_TYPE;
            insert_Type_List(res);
            return res;
        }
        // | FLOAT
        else if(isEqual(root->tag,"FLOAT")){
            res->kind = BASIC;
            res->u.basic = FLOAT_TYPE;
            insert_Type_List(res);
            return res;
        }else{
            printError("Switch in Handle_Exp Case 1");
            return NULL;
        }
        break;
    case 2:{
        /* TODO:code Maybe Finished ???*/
        // | MINUS Exp : -5,-(a+b)
        // | NOT Exp : !
        GramTree* Exp = root->child[1];
        GramTree* Operand = root->child[0];
        assert(isEqual(Exp->tag,"Exp"));
        assert(isEqual(Operand->tag,"MINUS")||isEqual(Operand->tag,"NOT"));
        Type exp_type = Handle_Exp(Exp);
        if(exp_type == NULL){
            printErrorOfSemantic(7,root->lineNo,Exp->tag);
            return NULL;
        }
    
        // 7)  错误类型7：操作数类型不匹配或操作数类型与操作符不匹配（例如整型变量与数组变量相加减，或数组（或结构体）变量与数组（或结构体）变量相加减）。
        if(exp_type->kind != BASIC){
            printErrorOfSemantic(7,root->lineNo,Exp->tag);
            return NULL;
        }else{
            if(isEqual(Operand->tag,"NOT") && exp_type->u.basic != INT_TYPE){
                printErrorOfSemantic(7,root->lineNo,Exp->tag);
                return NULL;
            } else { //如果是基本类型直接返回
                insert_Type_List(exp_type);
                return exp_type;
            }
        }
        break;
    }
    case 3:{
        /* TODO:code */
        GramTree* Operand = root->child[1];
        // NOTE:a and b only suitable for Exp Operand Exp
        GramTree* a = root->child[0];
        GramTree* b = root->child[2];
        // Exp -> Exp ASSIGNOP Exp
        if(isEqual(Operand->tag,"ASSIGNOP")){
            // 5)  错误类型5：赋值号两边的表达式类型不匹配。
            // 6)  错误类型6：赋值号左边出现一个只有右值的表达式。
            //check error Type 6
            Type ta = Handle_Exp(a);
            Type tb = Handle_Exp(b);
            if(ta == NULL || tb == NULL) {
                printErrorOfSemantic(5, Operand->lineNo, "");
            } else if(isTypeEqual(ta, tb) == false){ 
                printErrorOfSemantic(5, Operand->lineNo, "");
            }
            CheckLeftAssign(a);
            return NULL;
        }
        // | Exp AND Exp
        // | Exp OR Exp
        else if(isEqual(Operand->tag,"AND") || isEqual(Operand->tag,"OR")){
            Type ta = Handle_Exp(a);
            Type tb = Handle_Exp(b);
            if(isTypeEqual(ta, tb) == false) {
                printErrorOfSemantic(7, Operand->lineNo, "");
                return NULL; 
            } else {
                insert_Type_List(ta);
                return ta;
            }
        }
        // | Exp RELOP Exp
        else if(isEqual(Operand->tag,"RELOP")){
            Type ta = Handle_Exp(a);
            Type tb = Handle_Exp(b);
            if(isTypeEqual(ta, tb) == false) {
                printErrorOfSemantic(7, Operand->lineNo, "");
                return NULL;
            } else {
                insert_Type_List(ta);
                return ta;
            }
        }
        // | Exp PLUS Exp
        // | Exp MINUS Exp
        // | Exp STAR Exp
        // | Exp DIV Exp
        else if(isEqual(Operand->tag,"PLUS")
                ||isEqual(Operand->tag,"MINUS")
                ||isEqual(Operand->tag,"STAR")
                ||isEqual(Operand->tag,"DIV")){
            Type ta = Handle_Exp(a);
            Type tb = Handle_Exp(b);
            if(isTypeEqual(ta, tb) == false) {
                printErrorOfSemantic(7, Operand->lineNo, "");
                return NULL;
            } else {
                insert_Type_List(ta);
                return ta;
            }
        }
        // | LP Exp RP
        else if(isEqual(root->child[0]->tag,"LP")
                &&isEqual(root->child[1]->tag,"Exp")
                &&isEqual(root->child[2]->tag,"RP")){
            res = Handle_Exp(root->child[1]);
            insert_Type_List(res);
            return res;
        }
        // | ID LP RP
        else if(isEqual(root->child[0]->tag,"ID")
                &&isEqual(root->child[1]->tag,"LP")
                &&isEqual(root->child[2]->tag,"RP")){
            SymbolElem funcDec = findFromTable_Struct(root->child[0]->val.str); //此处调用函数
            if(funcDec == NULL) {
                printErrorOfSemantic(2, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            } else if(funcDec->kind != FUNCTION){ //error Type 11
                printErrorOfSemantic(11, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            } else {
                res = funcDec->u.func.retType;
                insert_Type_List(res);
                return res;
            }
        }
        // | Exp DOT ID
        else if(isEqual(root->child[0]->tag,"Exp")
                &&isEqual(root->child[1]->tag,"DOT")
                &&isEqual(root->child[2]->tag,"ID")){
            Type ta = Handle_Exp(root->child[0]);
            if(ta == NULL) {    //非结构体变量
                printErrorOfSemantic(13, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            } else if(ta->kind != STRUCTURE) { //非结构体变量
                printErrorOfSemantic(13, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            } else { //查找ID是否再域中
                FieldList tempField = ta->u.structure;
                myPrintf("EXP DOT ,ID = %s\n", root->child[2]->val.str);
                while(tempField != NULL){
                    myPrintf("tempField->name = %s\n", tempField->name);
                    if(isEqual(tempField->name, root->child[2]->val.str) == true) {
                        break;
                    }
                    tempField = tempField->tail;
                }
                if(tempField == NULL) { //cannt find
                    printErrorOfSemantic(14, root->child[2]->lineNo, root->child[2]->val.str);
                    return NULL;
                } else {
                    res = tempField->type;
                    insert_Type_List(res);
                    return res;
                }
            }
        }else{
            printError("Exp type not Found");assert(0);
        }
        break;
    }    
    case 4:
        /* TODO:code */
        // | ID LP Args RP
        if(isEqual(root->child[0]->tag,"ID") //function
            &&isEqual(root->child[1]->tag,"LP")
            &&isEqual(root->child[2]->tag,"Args")
            &&isEqual(root->child[3]->tag,"RP")){
            SymbolElem t = findFromTable_Struct(root->child[0]->val.str); //find Name
            if(t == NULL) {
                printErrorOfSemantic(2, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            } else if(t->kind != FUNCTION) {
                printErrorOfSemantic(11, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            }
            FieldList funcField = t->u.func.varList;
            FieldList fieldFromArgs = Handle_Args(root->child[2]);
            if(isFiledListEqual(funcField, fieldFromArgs) == false) {
                printErrorOfSemantic(9, root->child[0]->lineNo, root->child[0]->val.str);
                return NULL;
            }
            res = t->u.var;
            return res; //没有问题进行返回
        }
        // | Exp LB Exp RB
        else if(isEqual(root->child[0]->tag,"Exp")
                &&isEqual(root->child[1]->tag,"LB")
                &&isEqual(root->child[2]->tag,"Exp")
                &&isEqual(root->child[3]->tag,"RB")){
            Type ta = Handle_Exp(root->child[0]);
            if(ta == NULL){
                printErrorOfSemantic(10, root->child[0]->lineNo,root->child[0]->child[0]->val.str);
                return NULL;
            }
            if(ta->kind != ARRAY) { //非类型数组
                printErrorOfSemantic(10, root->child[0]->lineNo,root->child[0]->child[0]->val.str);
                return NULL;
            } else{
                Type tb = Handle_Exp(root->child[2]);
                if(tb == NULL) {
                    printErrorOfSemantic(12, root->child[2]->lineNo,root->child[2]->val.str);
                    return NULL;
                } else {
                    if(tb->kind != BASIC) {
                        printErrorOfSemantic(12, root->child[2]->lineNo,root->child[2]->val.str);
                        return NULL;
                    } else if(tb->u.basic != INT_TYPE) {
                        printErrorOfSemantic(12, root->child[2]->lineNo,root->child[2]->val.str);
                        return NULL;
                    } else {
                        res = ta->u.array.elem;
                        insert_Type_List(res);
                        return res;
                    }
                }
            }

        }else{
            printError("Exp type not Found");assert(0);
        }
        break;    
    default:
        printError("Switch in Handle_Exp");
        break;
    }
    assert(0);
    printPhase("Handle_Exp() End");
    return res;
}

void insert_Type_List(Type type){
    global_Type_Index++;
    type_List[global_Type_Index] = type;
    return global_Type_Index;
}

Type findExpTypeFromList(int index){
    return type_List[index];
}

FieldList Handle_Args(GramTree* root) {
    GramTree* p = root;
    FieldList varList = NULL, tail;
    while (p != NULL) {
        FieldList cur = malloc(sizeof(FieldListsize));
        cur->tail = NULL;
        cur->type = Handle_Exp(p->child[0]);
        cur->name = malloc(sizeof(char) * 30);
        strcpy(cur->name, p->val.str);
        if (varList == NULL){
            varList = cur;
        }else{
            tail->tail = cur;
        }
        tail = cur;
        if (p->nChild == 3)
            p = p->child[2];
        else
            p = NULL;
    }
    return varList;
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
            return; //Error and Cannt insert
        }
    }else if (root->nChild == 1){
        // Do nothing
    }else{
        printError("Number conflict"); assert(0);
    }
    //insert_Into_TABLE
    insert_Symbol_Table(symbol);
    GramTree* varDec = root->child[0];
    while(varDec->nChild == 4){
        varDec = varDec->child[0];
    }
    varDec->child[0]->symIndex = symbol->symIndex; //ID

    printPhase("Handle_Dec() End");
}

void Handle_DecList(GramTree* root, Type type){
    // DecList -> Dec| Dec COMMA DecList
    printPhase("Handle_DecList() Begin");
    printProduction(root);
    while(root != NULL){
        Handle_Dec(root->child[0],type);
        if(root->nChild == 3){
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
    //assert(root->lineNo == 3);
    Type type = getType(root->child[0]);
    Handle_DecList(root->child[1],type);
    printPhase("Handle_Def() End");
}

void Handle_DefList(GramTree* root){
    //DefList -> Def DefList | empty
    printPhase("Handle_DefList() Begin");
    printProduction(root);
    if(root->nChild == 0){ //Empty
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
    if(root-> nChild == 1) { //Stmt -> CompSt
        Handle_CompSt(root->child[0], type);
    } else if(root->nChild == 2) { //Stmt -> Exp SEMI
        Type temp = Handle_Exp(root->child[0]);
        return;
    } else if(root->nChild == 3) { //Stmt -> RETURN Exp SEMI
        Type temp = Handle_Exp(root->child[1]);
        if(isTypeEqual(type, temp) == false) {
            printErrorOfSemantic(8,root->child[0]->lineNo, "");
        }
    } else if(root->nChild == 5) {
        if(isEqual(root->child[0]->tag, "IF") == true) {// Stmt -> IF LP Exp RP Stmt
            //判断 EXP 类型是否是 INT 型变量
            Type temp = Handle_Exp(root->child[2]);
            if(temp==NULL){
                //TODO : return error,segmentation fault
                return;
            }
            if(temp->kind == BASIC && temp->u.basic == INT_TYPE) {
                //Right
            } else {
                printErrorOfSemantic(7 ,root->child[2]->lineNo, "");
            }
            Top_of_stack++;
            symbol_Stack[Top_of_stack] = NULL;
            Handle_Stmt(root->child[4], type);
            Clear_TopOf_Stack();
        } else if(isEqual(root->child[0]->tag, "WHILE") == true) { // Stmt -> WHILE LP Exp RP Stmt
            Type temp = Handle_Exp(root->child[2]);
            if(temp->kind == BASIC && temp->u.basic == INT_TYPE) {
                //Right
            } else {
                printErrorOfSemantic(7 ,root->child[2]->lineNo, "");
            }
            Top_of_stack++;
            symbol_Stack[Top_of_stack] = NULL;
            Handle_Stmt(root->child[4], type);
            Clear_TopOf_Stack();
        }
    } else if(root->nChild == 7) { //Stmt -> IF LP Exp RP Stmt ELSE Stmt
            Type temp = Handle_Exp(root->child[2]);
            if(temp->kind == BASIC && temp->u.basic == INT_TYPE) {
                //Right
            } else {
                printErrorOfSemantic(7 ,root->child[2]->lineNo, "");
            }
            Top_of_stack++;
            symbol_Stack[Top_of_stack] = NULL;
            Handle_Stmt(root->child[4], type);
            Clear_TopOf_Stack();
            Top_of_stack++;
            symbol_Stack[Top_of_stack] = NULL;
            Handle_Stmt(root->child[6], type);
            Clear_TopOf_Stack();

    } else {
        assert(0);
    }
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
            Clear_TopOf_Stack();
            insert_Symbol_Table(res);
        
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
        case 1: printf("Undefined variable \"%s\"." , str); break;
        case 2: printf("Undefined function \" %s \".", str); break;
        case 3: printf("Redefined variable \" %s \".",str); break;
        case 4: printf("Redefined function \" %s \".",str); break;
        case 5: printf("Type mismatched for assignment."); break;
        case 6: printf("The left-hand side of an assignment must be a variable."); break;
        case 7: printf("Type mismatched for operands."); break;
        case 8: printf("Type mismathced for return."); break;
        case 9: printf("Function \" %s \" is not applicable for arguments.",str); break;
        case 10: printf("\"%s\" is not an array.",str); break;
        case 11: printf("\" %s \" is not a function.",str); break;
        case 12: printf("\" %s \" is not an integer.",str); break;
        case 13: printf("Illegal use of \".\" ."); break;
        case 14: printf("Non-existent field \" %s \" .",str); break;
        case 15: if (isEqual(str,"struct")==0) printf("Redefined field \" %s \".", str); else printf("Initialize a field of structure."); break;
        case 16: printf("Duplicated name \" %s \".",str); break;
        case 17: printf("Undefined structure\" %s \".",str); break;
        default: break;
    }
    printf("\n");
}