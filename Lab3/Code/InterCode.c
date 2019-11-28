#include "InterCode.h"

int globalLabelIndex = -1;

// translate函数
void translateTree(GramTree * root){
    InterCodes codes = translate_Program(root);
    printInterCodes(codes);
}

InterCodes translate_Program(GramTree* root){
    InterCodes codes = translate_ExtDefList(root->child[0]);
    return codes;
}

InterCodes translate_ExtDefList(GramTree* root){
    // TODO:empty的话会有几个子节点？
    if(root->nChild == 0 || root->nChild == 1){
        printf("translate_ExtDefList nChild= %d\n",root->nChild);
        return NULL;
    }else{
        return link2Codes(
            translate_ExtDef(root->child[0]),
            translate_ExtDefList(root->child[1]));
    }
}

InterCodes translate_ExtDef(GramTree* root){
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
    return translate_VarDec(root->child[1]);
}

InterCodes translate_VarDec(GramTree* root){
    while(root->nChild == 4){
        root = root->child[0];
    }
    // 此时root指向var了,root->child[0]就是ID
    int isAddr = true;
    Operand op = getVar(root->child[0]->symIndex, isAddr); //FIXME:写到这里就知道有问题了
    return getParamCode(op);
}

InterCodes translate_CompSt(GramTree* root){
    GramTree* defList = root->child[1];
    GramTree* stmtList = root->child[2];
    return link2Codes(translate_DefList(defList),translate_StmtList(stmtList));
}

InterCodes translate_DefList(GramTree* root){
    // TODO:empty的话会有几个子节点？
    if(root->nChild == 0 || root->nChild == 1){
        printf("translate_DefList nChild= %d\n",root->nChild);
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
    return translate_DecList(root->child[1]);
}

InterCodes translate_DecList(GramTree* root){
    InterCodes decCodes = translate_Dec(root->child[0]);
    if(root->nChild == 1){
        return decCodes;
    }else{
        return link2Codes(decCodes, translate_DecList(root->child[2]));
    }
}

InterCodes translate_Dec(GramTree* root){
    GramTree* p = root->child[0];
    // 向下找到ID所在节点
    while(p->nChild == 4){
        p = p->child[0];
    }
    
    SymbolElem symbol = findFromList(p->symIndex);

    InterCodes c1 = NULL;
    InterCodes c2 = NULL;

    if(symbol->u.var->kind != BASIC){
        int isAddr = true;
        Operand op = getVar(p->symIndex, isAddr);
        c1 = getDecCode(op, getTypeSize(symbol->u.var));
    }

    // TODO: 读懂这里什么意思
    if(root->nChild == 3){
        int isAddr = false;
        Operand var = getVar(p->symIndex, isAddr);
        Operand op;
        InterCodes ExpCodes = translate_Exp(root->child[2], &op);
        InterCodes ASSIGNOPCodes = getASSIGNOPCode(var, op, VAL_OP);
        // TODO: 检查连接的顺序问题
        c2 = link2Codes(ExpCodes, ASSIGNOPCodes);
    }

    return link2Codes(c1,c2);

}

int getTypeSize(Type type){
    //TODO
    if(type->kind == BASIC){
        return 4;
    }else if(type->kind == ARRAY){
        return type->u.array.size * getTypeSize(type->u.array.elem);
    }else{
        return getFieldListSize(type->u.structure);
    }
    return 0;
}

int getFieldListSize(FieldList fieldList){
    if(fieldList == NULL){
        return 0;
    } else{
        return getTypeSize(fieldList->type) + getFieldListSize(fieldList->tail);
    }
}


InterCodes translate_Exp(GramTree* root, Operand* place){
    //FIXME:这块太多了，慢慢写，先把框架搭一下
    int n = root->nChild;
    if(n==1){
        root = root->child[0];
        // | ID
        if(isEqual(root->tag,"ID")){
        SymbolElem symbol = findFromList(root->symIndex);
        int isAddr = false;
        if(symbol->u.var->kind != BASIC && symbol->isParam == true){
            isAddr = true;
        }
            if(place != NULL){
                *place = getVar(root->symIndex, isAddr);
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
        // TODO:
        return NULL;
    }else if( n==3 && isEqual(root->child[1]->tag,"PLUS")){
        // Exp -> Exp PLUS Exp
        // TODO:
        return NULL;        
    }else if( n==2 && isEqual(root->child[0]->tag,"MINUS")){
        // Exp -> MINUS Exp
        // TODO:
        return NULL;        
    }else if(
            isEqual(root->child[1]->tag,"RELOP") || // | Exp RELOP Exp
            isEqual(root->child[0]->tag,"NOT") ||   // | NOT Exp
            isEqual(root->child[1]->tag,"AND") ||   // | Exp AND Exp
            isEqual(root->child[1]->tag,"OR")){    // | Exp OR Exp
        
        // TODO:
        return NULL;  

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
        // TODO:
        return NULL; 
    }else if(
            isEqual(root->child[0]->tag,"Exp")&& //结构体的处理
            isEqual(root->child[1]->tag,"DOT")&&
            isEqual(root->child[2]->tag,"ID")){
        // TODO:
        return NULL;
    }else if(
            isEqual(root->child[0]->tag,"ID")&& //函数的处理
            isEqual(root->child[1]->tag,"LP")&&
            isEqual(root->child[2]->tag,"RP")){
        // | ID LP RP
        // TODO:
        return NULL;
    }else if(
            isEqual(root->child[0]->tag,"ID")&& //函数的处理
            isEqual(root->child[1]->tag,"LP")&&
            isEqual(root->child[2]->tag,"Args")&&
            isEqual(root->child[3]->tag,"RP")){
        // | ID LP Args RP
        // TODO:
        return NULL;
    }else{
        printProduction(root);
        assert(0);
    }   

}



InterCodes translate_StmtList(GramTree* root){
    // TODO:empty的话会有几个子节点？
    if(root->nChild == 0 || root->nChild == 1){
        printf("translate_StmtList nChild= %d\n",root->nChild);
        return NULL;
    }else{
        return link2Codes(
            translate_Stmt(root->child[0]),
            translate_StmtList(root->child[1]));
    }
}

InterCodes translate_Stmt(GramTree* root){
    // TODO: Complete this function
    if(root-> nChild == 1) { //Stmt -> CompSt
        return translate_CompSt(root->child[0]);
    } else if(root->nChild == 2) { //Stmt -> Exp SEMI
        return translate_Exp(root->child[0],  NULL);
    } else if(root->nChild == 3) { //Stmt -> RETURN Exp SEMI
        Operand op;
        InterCodes ExpCodes = translate_Exp(root->child[0], &op);
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
                labelCodes2,
                StmtCodes
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
            return link6Codes(
                condCodes,
                labelCodes1,
                StmtCodes1,
                gotoCodes,
                StmtCodes2,
                labelCodes3
            );
    } else {
        assert(0);
    }
}

InterCodes translate_Cond(GramTree*root, int label_true, int label_false){
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
InterCodes getFuncCodes(GramTree* root){
    // TODO:
    return NULL;
}

InterCodes getParamCode(Operand op){
    // TODO:
    return NULL;
}

InterCodes getDecCode(Operand op, int decSize){
    // TODO:
    return NULL;
}

InterCodes getASSIGNOPCode(Operand op1, Operand op2, int opKind){
    // TODO:
    return NULL;
}

InterCodes getReturnCode(Operand op){
    // TODO:
    return NULL;
}

InterCodes getLabelCode(int label){
    // TODO:
    return NULL;
}

InterCodes getGotoCode(int label){
    // TODO:
    return NULL;
}

InterCodes getRelopCode(char* relopType, Operand op1, Operand op2, int label){
    //TODO
    return NULL;
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


// 工具人函数
// TODO: 双向循环链表头尾实现的时候接起来吗,如果首尾相接，则需要防止死循环——回答，是的。
void printInterCodes(InterCodes codes){
    InterCodes p = codes;
    if(p != NULL){
        printInterCode(p->code);
        p = p->next;
        while(p != NULL){
            printInterCode(p->code);
            p = p->next;
        }
    }

}

// TODO:还不知道怎么写才好，先随便写一个
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

// TODO:函数需要完善
char* getOperand(Operand op, int opKind){
    char* opName = "fakeOpName_in_getOperand"; // = =随便写个虚假的
    return opName;
}

// TODO:函数需要完善
char* getName(Operand op){
    char* opName = "fakeName_in_getName()"; // = =随便写个虚假的
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