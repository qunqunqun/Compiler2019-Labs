#include "InterCode.h"

int globalLabelIndex = -1;
int globalTempIndex = -1;

int is_iPrint = false;
//工具人函数
void iPrintPhase(char * msg){
    return;
    if(is_iPrint){
        printf("---------- %s ----------\n", msg);
    }
}

void iPrintProduction(GramTree* root){
    if(is_iPrint){
        printf("%s -> ",root->tag);
        int i=0;
        while(i<root->nChild){
            printf("%s ",root->child[i]->tag);
            i++;
        }
        printf("\n");
    }
}

// 用于debug lab3
void iPrintf(const char* format, ...){
    if(is_iPrint){
        va_list vp;
        va_start(vp, format);
        vprintf (format, vp);
        va_end  (vp);
    }
}

// translate函数
void translateTree(GramTree * root){
    iPrintPhase("translateTree Begin");
    iPrintProduction(root);
    InterCodes codes = translate_Program(root);
    printInterCodes(codes);
}

InterCodes translate_Program(GramTree* root){
    iPrintPhase("translate_Program Begin");
    iPrintProduction(root);
    InterCodes codes = translate_ExtDefList(root->child[0]);
    return codes;
}

InterCodes translate_ExtDefList(GramTree* root){
    iPrintPhase("translate_ExtDefList Begin");
    iPrintProduction(root);
    if(root->nChild == 0 || root->nChild == 1){
        return NULL;
    }else{
        return link2Codes(
            translate_ExtDef(root->child[0]),
            translate_ExtDefList(root->child[1]));
    }
}

InterCodes translate_ExtDef(GramTree* root){
    iPrintPhase("translate_ExtDef Begin");
    iPrintProduction(root);
    if(root->nChild == 3){
        if(isEqual(root->child[1]->tag, "FunDec") == 1 && isEqual(root->child[2]->tag, "CompSt") == 1){
            return link2Codes(
                translate_FunDec(root->child[1]),
                translate_CompSt(root->child[2]));
        }
    }else{
        return NULL;
    }
}

InterCodes translate_FunDec(GramTree* root){
    iPrintPhase("translate_FunDec Begin");
    iPrintProduction(root);
    InterCodes funcCodes = getFuncCodes(root->child[0]);
    if(root->nChild == 3){
        return funcCodes;
    }else if(root->nChild == 4 && isEqual(root->child[2]->tag, "VarList") == 1){
        return link2Codes(funcCodes, translate_VarList(root->child[2]));
    }else{
        assert(0);
    }

}

InterCodes translate_VarList(GramTree* root){
    iPrintPhase("translate_VarList Begin");
    iPrintProduction(root);
    InterCodes paramDecCodes = translate_ParamDec(root->child[0]);
    if(root->nChild == 1){
        return paramDecCodes;
    }else if(root->nChild == 3 && isEqual(root->child[2]->tag, "VarList") == 1){
        return link2Codes(paramDecCodes, translate_VarList(root->child[2]));
    }else{
        assert(0);
    }
}

InterCodes translate_ParamDec(GramTree* root){
    iPrintPhase("translate_ParamDec Begin");
    iPrintProduction(root);
    return translate_VarDec(root->child[1]);
}

InterCodes translate_VarDec(GramTree* root){
    iPrintPhase("translate_VarDec Begin");
    iPrintProduction(root);
    while(root->nChild == 4){
        root = root->child[0];
    }
    // 此时root指向var了,root->child[0]就是ID
    int isAddr = true;
    Operand op = getVar(root->child[0]->symIndex, isAddr); //FIXME:写到这里就知道有问题了
    return getParamCode(op);
}

InterCodes translate_CompSt(GramTree* root){
    iPrintPhase("translate_CompSt Begin");
    iPrintProduction(root);
    GramTree* defList = root->child[1];
    GramTree* stmtList = root->child[2];
    return link2Codes(translate_DefList(defList),translate_StmtList(stmtList));
}

InterCodes translate_DefList(GramTree* root){
    iPrintPhase("translate_DefList Begin");
    iPrintProduction(root);
    if(root->nChild == 0 || root->nChild == 1){
        return NULL;
    }else if(root->nChild == 2){
        return link2Codes(
            translate_Def(root->child[0]),
            translate_DefList(root->child[1]));
    }else{
        assert(0);
    }
}

InterCodes translate_Def(GramTree* root){
    iPrintPhase("translate_Def Begin");
    iPrintProduction(root);
    return translate_DecList(root->child[1]);
}

InterCodes translate_DecList(GramTree* root){
    iPrintPhase("translate_DecList Begin");
    iPrintProduction(root);
    InterCodes decCodes = translate_Dec(root->child[0]);
    if(root->nChild == 1){
        return decCodes;
    }else{
        return link2Codes(decCodes, translate_DecList(root->child[2]));
    }
}

InterCodes translate_Dec(GramTree* root){
    iPrintPhase("translate_Dec Begin");
    iPrintProduction(root);
    GramTree* p = root->child[0];
    // 向下找到ID所在节点
    while(p->nChild == 4){
        p = p->child[0];
    }
    
    //FIXME 这的问题,把下面一行注释掉
    // p = p->child[0];    // ID所在节点 
    printf("p->symIndex = %d\n", p->symIndex);
    SymbolElem symbol = findFromList(p->symIndex);
    printSymbolElem(symbol);
    InterCodes c1 = NULL;
    InterCodes c2 = NULL;

    if(symbol->u.var->kind != BASIC){
        printError("179");
        int isAddr = true;
        Operand op = getVar(p->symIndex, isAddr);
        printError("183");
        c1 = getDecCode(op, getTypeSize(symbol->u.var));
        printError("185");
    }

    if(root->nChild == 3){
        printError("186");
        int isAddr = false;
        Operand var = getVar(p->symIndex, isAddr);
        Operand op;
        InterCodes ExpCodes = translate_Exp(root->child[2], &op);
        InterCodes ASSIGNOPCodes = getAssignopCode(var, op, VAL_OP);
        // TODO: 检查连接的顺序问题
        c2 = link2Codes(ExpCodes, ASSIGNOPCodes);
    }

    return link2Codes(c1,c2);

}

int getTypeSize(Type type){
    // printf("type->kind:%d",type->kind);
    printError("205");
    if(type == NULL){
        printError("207");
    }
    if(type->kind == BASIC){
        printError("210");
        return 4;
    }else if(type->kind == ARRAY){
        printError("213");
        return type->u.array.size * getTypeSize(type->u.array.elem);
    }else{
        printError("?");
        return getFieldListSize(type->u.structure);
        printError("?");
    }
    return 0;
}

int getFieldListSize(FieldList fieldList){
    printError("219");
    if(fieldList == NULL){
        printError("221");
        return 0;
    } else{
        printError("224");
        return getTypeSize(fieldList->type) + getFieldListSize(fieldList->tail);
    }
}


InterCodes translate_Exp(GramTree* root, Operand* place){
    iPrintPhase("translate_Exp Begin");
    iPrintProduction(root);
    //FIXME:这块太多了，慢慢写，先把框架搭一下
    int n = root->nChild;
    if(n==1){
        root = root->child[0];
        // | ID
        if(isEqual(root->tag,"ID")){
            printf("root->symIndex = %d\n", root->symIndex);
            SymbolElem symbol = findFromList(root->symIndex);
            int isAddr = false;
            if(symbol->u.var->kind != BASIC && symbol->isParam == true){
                isAddr = true;
            }
            if(place != NULL){
                *place = getVar(root->symIndex, isAddr);
                // iPrintf("op->kind = %d\n", (*place)->kind);
                // iPrintf("op->u.value = %s\n", symbol->name);
                // iPrintf("op->isAddr = %d\n", (*place)->isAddr);
            }
            
            return NULL;
        }
        // | INT
        else if(isEqual(root->tag,"INT")){
            int value = root->val.a;
            if(place != NULL){
                *place = getConst(value);
            }
            return NULL;
        }
        // | FLOAT
        else if(isEqual(root->tag,"FLOAT")){
            // Lab3假设不会出现浮点数常数
            assert(0);
        }else{
            printError("Switch in Handle_Exp Case 1");
            assert(0);
        }

    }else if( n==3 && isEqual(root->child[1]->tag,"ASSIGNOP")){
        // Exp -> Exp ASSIGNOP Exp
        // TODO: TO Be Check Here
        Operand t1 = malloc(sizeof(OperandBody));
        Operand t2 = malloc(sizeof(OperandBody));
        InterCodes ExpCodes1 = translate_Exp(root->child[0], &t1);
        InterCodes ExpCodes2 = translate_Exp(root->child[2], &t2); 
        InterCodes asCodes = getAssignopCode(t1,t2,VAL_OP);
        return link3Codes(ExpCodes1,ExpCodes2,asCodes);

    }
    else if( n==3 && (   
                isEqual(root->child[1]->tag,"PLUS")||
                isEqual(root->child[1]->tag,"MINUS")||
                isEqual(root->child[1]->tag,"STAR")||
                isEqual(root->child[1]->tag,"DIV"))){
        Operand t1;
        Operand t2;
        InterCodes ExpCodes1 = translate_Exp(root->child[0], &t1);
        InterCodes ExpCodes2 = translate_Exp(root->child[2], &t2);
        *place = getTemp(0);
        InterCodes arithCodes = getArithCodes(root->child[1]->tag, *place, t1, t2, VAL_OP);
        return link3Codes(ExpCodes1,ExpCodes2,arithCodes);

    }else if( n==2 && isEqual(root->child[0]->tag,"MINUS")){
        // Exp -> MINUS Exp
        Operand t1;
        InterCodes code1 = translate_Exp(root->child[1], &t1);

        // TODO: Check HERE
        if(t1->isAddr == CONSTANT){
            t1->u.value = 0 - t1->u.value;
            if( place != NULL){
                *place = t1;
            }
            return NULL;
        }

        *place = getTemp(false);
        Operand zero = getConst(0);
        InterCodes code2 = getArithCodes("MINUS",*place,zero,t1, VAL_OP);
        return link2Codes(code1, code2);  

    }else if(
            isEqual(root->child[1]->tag,"RELOP") || // | Exp RELOP Exp
            isEqual(root->child[0]->tag,"NOT") ||   // | NOT Exp
            isEqual(root->child[1]->tag,"AND") ||   // | Exp AND Exp
            isEqual(root->child[1]->tag,"OR")){    // | Exp OR Exp
        
        int label1 = getNewLabel();
        int label2 = getNewLabel();
        Operand t0 = getConst(0);
        Operand t1 = getConst(1);
        InterCodes code0 = getAssignopCode(*place, t0, VAL_OP);
        InterCodes code1 = translate_Cond(root, label1, label2);
        InterCodes code2 = link2Codes(
                                getLabelCode(label1), 
                                getAssignopCode(*place, t1, VAL_OP));

        return link4Codes(code0, code1, code2, getLabelCode(label2));

    }else if(
            isEqual(root->child[0]->tag,"LP")&&
            isEqual(root->child[1]->tag,"Exp")&&
            isEqual(root->child[2]->tag,"RP")){
        // LP Exp RP    
        return translate_Exp(root->child[1], place);            
    }else if(
            isEqual(root->child[0]->tag,"Exp")&& //数组的处理
            isEqual(root->child[1]->tag,"LB")&&  
            isEqual(root->child[2]->tag,"Exp")&&
            isEqual(root->child[3]->tag,"RB")){
        // Exp LB Exp RB        
        Operand base;   //基址
        Operand number; //数组大小
        InterCodes code1 = translate_Exp(root->child[0], &base);
        InterCodes code2 = translate_Exp(root->child[2], &number);

        Type type = findExpTypeFromList(root->child[0]->typeIndex);
        int size = getTypeSize(type->u.array.elem); //当作一维，数组的元素大小
        
        int isAddr = false; //临时变量代表地址还是值
        Operand offset = getTemp(isAddr);   //相对于基址的偏移量
        InterCodes code3 = getArithCodes("STAR", offset, getConst(size), number, VAL_OP);
        
        isAddr = true;
        Operand res = getTemp(isAddr);
        InterCodes code4 = getArithCodes("PLUS", res, base, offset, ADDR_OP);
        
        if(place != NULL){
            *place = res;
        }
        return link4Codes(code1, code2, code3, code4); 

    }else if(
            isEqual(root->child[0]->tag,"Exp")&& //结构体的处理
            isEqual(root->child[1]->tag,"DOT")&&
            isEqual(root->child[2]->tag,"ID")){

        Operand base;   //首地址
        InterCodes code1 = translate_Exp(root->child[0], &base);

        Type type = findExpTypeFromList(root->child[0]->typeIndex);
        FieldList filedList = type->u.structure;
        int offset = 0;
        filedList = filedList->tail;
        while(filedList != NULL && isEqual(filedList->name, root->child[2]->val.str) == false){
            offset = offset + getTypeSize(filedList->type);
            filedList = filedList->tail;
        }
        int isAddr = true;
        Operand res = getTemp(isAddr);
        InterCodes code2 = getArithCodes("PLUS", res, base, getConst(offset), ADDR_OP);

        if(place != NULL){
            *place = res;
        }

        return link2Codes(code1, code2);

    }else if(
            isEqual(root->child[0]->tag,"ID")&& //函数的处理
            isEqual(root->child[1]->tag,"LP")&&
            isEqual(root->child[2]->tag,"RP")){
        // | ID LP RP
        char * funcName = root->child[0]->val.str;
        Operand res = getTemp(0);
        InterCodes codes;
        if(isEqual(funcName,"read") == true){
            if(place != NULL){
                *place = res;
            }
            return getReadCodes(res);
        }else{
            if(place != NULL){
                *place = res;
            }
            return getCallCodes(res, funcName);
        }
        return NULL;
    }else if(
            isEqual(root->child[0]->tag,"ID")&& //函数的处理
            isEqual(root->child[1]->tag,"LP")&&
            isEqual(root->child[2]->tag,"Args")&&
            isEqual(root->child[3]->tag,"RP")){
        // | ID LP Args RP
        char * funcName = root->child[0]->val.str;
        if(place != NULL){
            *place = getTemp(0);
        }
        ArgList arglist = NULL;
        InterCodes code1 = translate_Args(root->child[2], &arglist);
        if(isEqual(funcName, "write") == true){
            if(arglist == NULL){
                printError("407");
            }
            InterCodes writeCodes = getWriteCodes(arglist->op);
            return link2Codes(code1, writeCodes);
        }
        InterCodes code2 = NULL;
        while(arglist != NULL){
            int opKind = (arglist->opType->kind == BASIC)? VAL_OP : ADDR_OP;
            InterCodes argCodes = getArgCodes(arglist->op, opKind);
            code2 = link2Codes(code2, argCodes);
            arglist = arglist->next;
        }
        InterCodes code3 = getCallCodes(*place, funcName);
        return link3Codes(code1, code2, code3);

    }else{
        printProduction(root);
        assert(0);
    }   

}

InterCodes translate_Args(GramTree* root, ArgList* arglist){
    iPrintPhase("translate_Args Begin");
    iPrintProduction(root);
    Operand t1 = getTemp(false);
    InterCodes code1 = translate_Exp(root->child[0], &t1);

    ArgList p = malloc(sizeof(ArgListBody));
    p->op = t1;
    p->opType = findExpTypeFromList(root->child[0]->typeIndex);
    p->next = *arglist;
    *arglist = p;

    if(root->nChild == 1){
        return code1;
    }else{
        InterCodes code2 = translate_Args(root->child[2], arglist);
        return link2Codes(code1, code2);
    }
    
}



InterCodes translate_StmtList(GramTree* root){
    iPrintPhase("translate_StmtList Begin");
    iPrintProduction(root);
    if(root->nChild == 0 || root->nChild == 1){
        return NULL;
    }else{
        return link2Codes(
            translate_Stmt(root->child[0]),
            translate_StmtList(root->child[1]));
    }
}

InterCodes translate_Stmt(GramTree* root){
    iPrintPhase("translate_Stmt Begin");
    iPrintProduction(root);
    if(root-> nChild == 1) { //Stmt -> CompSt
        return translate_CompSt(root->child[0]);
    } else if(root->nChild == 2) { //Stmt -> Exp SEMI
        return translate_Exp(root->child[0],  NULL);
    } else if(root->nChild == 3) { //Stmt -> RETURN Exp SEMI
        Operand op;
        InterCodes ExpCodes = translate_Exp(root->child[1], &op);
        InterCodes returnCodes = getReturnCode(op);
        return link2Codes(ExpCodes, returnCodes);
    } else if(root->nChild == 5) {
        if(isEqual(root->child[0]->tag, "IF") == true) {// Stmt -> IF LP Exp RP Stmt
            int label1 = getNewLabel();
            int label2 = getNewLabel();
            InterCodes condCodes = translate_Cond(root->child[2], label1, label2);
            InterCodes labelCodes1 = getLabelCode(label1);
            InterCodes labelCodes2 = getLabelCode(label2);
            InterCodes StmtCodes = translate_Stmt(root->child[4]);
            return link4Codes(
                condCodes,
                labelCodes1,
                StmtCodes,
                labelCodes2
            );

        } else if(isEqual(root->child[0]->tag, "WHILE") == true) { // Stmt -> WHILE LP Exp RP Stmt
            int label1 = getNewLabel();
            int label2 = getNewLabel();
            int label3 = getNewLabel();
            InterCodes condCodes = translate_Cond(root->child[2], label2, label3);
            InterCodes StmtCodes = translate_Stmt(root->child[4]);
            InterCodes labelCodes1 = getLabelCode(label1);
            InterCodes labelCodes2 = getLabelCode(label2);
            InterCodes labelCodes3 = getLabelCode(label3);
            InterCodes gotoCodes = getGotoCode(label1);
            return link6Codes(
                labelCodes1,
                condCodes,
                labelCodes2,
                StmtCodes,
                gotoCodes,
                labelCodes3
            );
        }else{
            assert(0);
        }
    } else if(root->nChild == 7) { //Stmt -> IF LP Exp RP Stmt ELSE Stmt
            int label1 = getNewLabel();
            int label2 = getNewLabel();
            int label3 = getNewLabel();
            InterCodes condCodes = translate_Cond(root->child[2], label1, label2);
            InterCodes StmtCodes1 = translate_Stmt(root->child[4]);
            InterCodes StmtCodes2 = translate_Stmt(root->child[6]);
            InterCodes labelCodes1 = getLabelCode(label1);
            InterCodes labelCodes2 = getLabelCode(label2);
            InterCodes labelCodes3 = getLabelCode(label3);
            InterCodes gotoCodes = getGotoCode(label3);
            return link7Codes(
                condCodes,
                labelCodes1,
                StmtCodes1,
                gotoCodes,
                labelCodes2,
                StmtCodes2,
                labelCodes3
            );
    } else {
        assert(0);
    }
}

InterCodes translate_Cond(GramTree*root, int label_true, int label_false){
    iPrintPhase("translate_Cond Begin");
    iPrintProduction(root);
    if(root->nChild ==  3){
        if(isEqual(root->child[1]->tag, "RELOP")){
            // Exp RELOP Exp
            Operand t1;
            Operand t2;
            InterCodes ExpCodes1 =  translate_Exp(root->child[0], &t1);
            InterCodes ExpCodes2 =  translate_Exp(root->child[2], &t2);
            InterCodes relopCodes = getRelopCode(root->child[1]->val.str, t1, t2, label_true);
            InterCodes gotoCodes = getGotoCode(label_false);
            return link4Codes(
                ExpCodes1,
                ExpCodes2,
                relopCodes,
                gotoCodes
            );

        }else if(isEqual(root->child[1]->tag, "AND")){
            // Exp AND Exp
            int label1 = getNewLabel();
            InterCodes condCodes1 = translate_Cond(root->child[0],  label1, label_false);
            InterCodes condCodes2 = translate_Cond(root->child[2],  label_true, label_false);
            InterCodes labelCodes = getLabelCode(label1);
            return link3Codes(
                condCodes1,
                labelCodes,
                condCodes2
            );

        }else if(isEqual(root->child[1]->tag, "OR")){
            // Exp OR Exp
            int label1 = getNewLabel();
            InterCodes condCodes1 = translate_Cond(root->child[0],  label_true, label1 );
            InterCodes condCodes2 = translate_Cond(root->child[2],  label_true, label_false);
            InterCodes labelCodes = getLabelCode(label1);
            return link3Codes(
                condCodes1,
                labelCodes,
                condCodes2
            );

        }else{
            //到最后面
        }
    }else if(root->nChild == 2 && isEqual(root->child[0]->tag, "NOT")){
        // NOT Exp
        return translate_Cond(root->child[0], label_false, label_true);
    }else{
        //到最后面
    }
    Operand t1;
    InterCodes code1 = translate_Exp(root, &t1);
    InterCodes relopCodes = getRelopCode("!=", t1, getConst(0), label_true);
    InterCodes gotoCodes = getGotoCode(label_false);
    return link3Codes(
        code1,
        relopCodes,
        gotoCodes
    );
}

// get函数
InterCodes getNewInterCodes(){
    InterCodes codes = malloc(sizeof(InterCodesBody));
    codes->code = malloc(sizeof(InterCodeBody));
    codes->prev = codes->next = codes;
    return codes;
}

InterCodes getFuncCodes(GramTree* root){
    InterCodes funID = getNewInterCodes();
    funID->code->kind = FUNC_IR;
    funID->code->u.single.funcName = root->val.str;
    funID->code->opKind = VAL_OP;
    return funID;
}

InterCodes getParamCode(Operand op){
    // ParamDec -> Specifier VarDec
    // VarDec -> ID，此时的op指向ID
    InterCodes paramID = getNewInterCodes();
    paramID->code->kind = PARAM_IR;
    paramID->code->u.single.op = op;
    paramID->code->opKind = VAL_OP;
    return paramID;
}

InterCodes getDecCode(Operand op, int decSize){
    // Dec -> VarDec
    // VarDec -> ID，此时的op指向ID
    InterCodes decID = getNewInterCodes();
    decID->code->kind = DEC_IR;
    decID->code->u.dec.op = op;
    decID->code->u.dec.decSize = decSize;
    decID->code->opKind = VAL_OP;
    return decID;
}

InterCodes getAssignopCode(Operand op1, Operand op2, int opKind){
    
    if(op1 == NULL){
        assert(0);
    }

    if(op2 == NULL){
        assert(0);
    }

    InterCodes assignCodes = getNewInterCodes();
    assignCodes->code->kind = ASSIGN_IR;
    assignCodes->code->u.assign.left = op1;
    assignCodes->code->u.assign.right = op2;
    assignCodes->code->opKind = opKind;
    return assignCodes;
}

InterCodes getReturnCode(Operand op){
    InterCodes retCodes = getNewInterCodes();
    retCodes->code->kind = RETURN_IR;
    retCodes->code->u.single.op = op;
    retCodes->code->opKind = VAL_OP;
    return retCodes;
}

InterCodes getLabelCode(int label){
    InterCodes labelCodes = getNewInterCodes();
    labelCodes->code->kind = LABLE_IR;
    labelCodes->code->labelNo = label;
    labelCodes->code->opKind = VAL_OP;
    return labelCodes;
}

InterCodes getGotoCode(int label){
    InterCodes gotoCodes = getNewInterCodes();
    gotoCodes->code->kind = GOTO_IR;
    gotoCodes->code->labelNo = label;
    gotoCodes->code->opKind = VAL_OP;
    return gotoCodes;
}

InterCodes getRelopCode(char* relopType, Operand op1, Operand op2, int label){
    InterCodes relopCodes = getNewInterCodes();
    relopCodes->code->kind = RELOP_IR;
    relopCodes->code->u.relop.relopType = relopType;
    relopCodes->code->u.relop.x = op1;
    relopCodes->code->u.relop.y = op2;
    relopCodes->code->u.relop.label = label;
    relopCodes->code->labelNo = label;
    relopCodes->code->opKind = VAL_OP;
    return relopCodes;
}

InterCodes getArithCodes(char* arithType, Operand result, Operand op1, Operand op2, int opKind){
    //getArithCodes
    char opType;
    if(isEqual(arithType, "PLUS")){
        opType = '+';
    }else if(isEqual(arithType, "MINUS")){
        opType = '-';
    }else if(isEqual(arithType, "STAR")){
        opType = '*';
    }else if(isEqual(arithType, "DIV")){
        opType = '/';
    }else{
        printf("arithType = %s\n", arithType);
        assert(0);
    }
    InterCodes arithCodes = getNewInterCodes();
    arithCodes->code->kind = ARITH_IR;
    arithCodes->code->u.binop.arithType = opType;
    arithCodes->code->u.binop.result = result;
    arithCodes->code->u.binop.op1 = op1;
    arithCodes->code->u.binop.op2 = op2;
    arithCodes->code->opKind = opKind;
    return arithCodes;  
}

InterCodes getReadCodes(Operand op){
    InterCodes readCodes = getNewInterCodes();
    readCodes->code->kind = READ_IR;
    readCodes->code->u.single.op = op;
    readCodes->code->opKind = VAL_OP;
    return readCodes;  
}

InterCodes getCallCodes(Operand op, char* funcName){
    InterCodes callCodes = getNewInterCodes();
    callCodes->code->kind = CALL_IR;
    callCodes->code->u.single.op = op;
    callCodes->code->u.single.funcName = funcName;
    callCodes->code->opKind = VAL_OP;
    return callCodes;
}

InterCodes getWriteCodes(Operand op){
    InterCodes writeCodes = getNewInterCodes();
    writeCodes->code->kind = WRITE_IR;
    writeCodes->code->u.single.op = op;
    writeCodes->code->opKind = VAL_OP;
    return writeCodes;  
}

InterCodes getArgCodes(Operand op, int opKind){
    InterCodes argCodes = getNewInterCodes();
    argCodes->code->kind = ARG_IR;
    argCodes->code->u.single.op = op;
    argCodes->code->opKind = opKind;
    return argCodes;       
}


// 中间代码的连接
InterCodes link2Codes(InterCodes c1, InterCodes c2){
    if(c1 == NULL) return c2;
    if(c2 == NULL) return c1;

    // e.g. ca1<-c1->cb1 , c1->cb1->..->ca1
    // e.g. ca2<-c2->cb2 , c2->cb2->..->ca2
    InterCodes t1 = c1->prev;
    InterCodes t2 = c2->prev;
    c1->prev = t2;
    t2->next = c1;
    c2->prev = t1;
    t1->next = c2;

    return c1;
}

InterCodes link3Codes(InterCodes c1, InterCodes c2, InterCodes c3){
    return link2Codes(c1, link2Codes(c2, c3));
}

InterCodes link4Codes(InterCodes c1, InterCodes c2, InterCodes c3, InterCodes c4){
    return link2Codes(c1, link3Codes(c2, c3, c4));
}

InterCodes link5Codes(InterCodes c1, InterCodes c2, InterCodes c3, InterCodes c4, InterCodes c5){
    return link2Codes( link2Codes(c1, c2), link3Codes(c3, c4, c5));
}

InterCodes link6Codes(InterCodes c1, InterCodes c2, InterCodes c3, InterCodes c4, InterCodes c5, InterCodes c6){
    return link2Codes( link3Codes(c1, c2, c3), link3Codes(c4, c5, c6));
}

InterCodes link7Codes(InterCodes c1, InterCodes c2, InterCodes c3, InterCodes c4, InterCodes c5, InterCodes c6, InterCodes c7){
    return link2Codes( link3Codes(c1, c2, c3), link4Codes(c4, c5, c6, c7));
}

// 工具人函数
// FIXME: 双向循环链表头尾实现的时候接起来吗,如果首尾相接，则需要防止死循环——回答，是的。
void printInterCodes(InterCodes codes){
    InterCodes p = codes;
    if(p != NULL){
        printInterCode(p->code);
        p = p->next;
        while(p != codes){
            printInterCode(p->code);
            p = p->next;
        }
    }
    iPrintf("---------------------------------------------\n");
}

Operand getVar(int value, int isAddr){
    Operand op = malloc(sizeof(OperandBody));
    op->kind = VARIABLE;
    op->u.value = value;
    op->isAddr = isAddr;
    return op;
} 

Operand getConst(int value){
    Operand op = malloc(sizeof(OperandBody));
    op->kind = CONSTANT;
    op->u.value = value;
    op->isAddr = false;
    return op;
}

Operand getTemp(int isAddr){
    Operand op = malloc(sizeof(OperandBody));
    op->kind = TEMP;
    globalTempIndex++;
    op->u.value = globalTempIndex;
    op->isAddr = isAddr;
    return op;
}


// TODO:函数需要完善
/*
    变量 v
    立即数 #
    临时变量 t1
*/
char* getOperand(Operand op, int opKind){
    if(op == NULL){
        printError("getOperand:op == NULL");
    }
    char* opName = getName(op);
    // printError(opName);
    char* ret = malloc(30);
    switch (opKind)
    {
    case ADDR_OP:
        if(op->kind == VARIABLE && op->isAddr == ADDR_OP){
            char tmp[20] = "&";
            strcat(tmp, opName);
            strcpy(ret, tmp);
            return ret;
        }
        break;
    case VAL_OP:
        if(op->isAddr == VAL_OP){
            char tmp[20] = "*";
            strcat(tmp, opName);
            strcpy(ret, tmp);
            return ret;
        }
        break;
    default:
        printError("Error");
        break;
    }

    return opName;
}

// FIXME:函数需要Check
char* getName(Operand op){
   if(op == NULL){
        printError("getName:op == NULL");
    }    
    char* opName = malloc(20);  //开足够的空间，不然strcat段错误
    switch (op->kind){
        case VARIABLE: strcpy(opName,"v"); break;
        case TEMP: opName = strcpy(opName,"t"); break;
        case CONSTANT: opName = strcpy(opName,"#"); break;
    default:
        break;
    }
    char index[30];
    sprintf(index, "%d" , op->u.value);
    strcat(opName, index);
    return opName;
}

int getNewLabel(){
    globalLabelIndex++;
    return globalLabelIndex;
}


// TODO: 后期可以定向到文件流中输出文件，目前先打印调试
void printInterCode(InterCode code){
    switch (code->kind) {
        case LABLE_IR:
            printf("LABEL label%d :\n", code->labelNo);
            break;
        case FUNC_IR:
            printf("FUNCTION %s :\n", code->u.single.funcName);
            break;
        case ASSIGN_IR:
            if(code->u.assign.left == NULL){
                assert(0);
            }
            if(code->u.assign.right == NULL){
                assert(0);
            }
            printf("%s := %s\n", getOperand(code->u.assign.left, code->opKind), getOperand(code->u.assign.right, code->opKind));
            break;
        case ARITH_IR:
            printf("%s := %s %c %s\n", getOperand(code->u.binop.result, code->opKind), getOperand(code->u.binop.op1, code->opKind), code->u.binop.arithType, getOperand(code->u.binop.op2, VAL_OP));
            break;
        case RELOP_IR:
            printf("IF %s %s %s ", getOperand(code->u.relop.x, code->opKind), code->u.relop.relopType, getOperand(code->u.relop.y, code->opKind));
        case GOTO_IR:
            printf("GOTO label%d\n", code->labelNo);
            break;
        case RETURN_IR:
            printf("RETURN %s\n", getOperand(code->u.single.op, code->opKind));
            break;
        case DEC_IR:
            printf("DEC %s %d\n", getOperand(code->u.dec.op, code->opKind), code->u.dec.decSize);
            break;
        case ARG_IR:
            printf("ARG %s\n", getOperand(code->u.single.op, code->opKind));
            break;
        case CALL_IR:
            printf("%s := CALL %s\n", getOperand(code->u.single.op, code->opKind), code->u.single.funcName);
            break;
        case PARAM_IR:
            printf("PARAM %s\n", getName(code->u.single.op));
            break;
        case READ_IR:
            printf("READ %s\n", getOperand(code->u.single.op, code->opKind));
            break;
        case WRITE_IR:
            printf("WRITE %s\n", getOperand(code->u.single.op, code->opKind));
            break;
        default:
            break;
    }
}