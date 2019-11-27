#include "InterCode.h"


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

InterCodes translate_CompSt(GramTree* root){

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
    return translate_VarDec(root->child[0]);
}

InterCodes translate_VarDec(GramTree* root){
    while(root->nChild == 4){
        root = root->child[0];
    }
    // 此时Root指向var了
    Operand op = getVar(root->child[0]->symbolIndex); //FIXME:写到这里就知道有问题了
    // TODO: 当前进度到这里
}





// get函数
InterCodes getFuncCodes(GramTree* root){
    // TODO:
    return NULL;
}

// TODO:还不知道怎么写才好，先随便写一个
Operand getVar(int value){
    Operand op = malloc(sizeof(OperandBody));
    op->kind = VARIABLE;
    op->u.value = value;
    return op;
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

// TODO:函数需要完善
char* getOperand(Operand op, int opKind){
    char* opName = "opName"; // = =随便写个虚假的
    return opName;
}

// TODO: 后期可以定向到文件流中输出文件，目前先打印调试
void printInterCode(InterCode code){
    switch (code->kind) {
        case LABLE_IR:
            printf("LABEL label%d :\n", code->labelNo);
            break;
        case FUNC_IR:
            printf("FUNCTION %s :\n", code->funcName);
            break;
        case ASSIGN_IR:
            printf("%s := %s\n", getOp(code->u.assign.left, code->opKind), getOp(code->u.assign.right, code->opKind));
            break;
        case ARITH_IR:
            printf("%s := %s %c %s\n", getOp(code->u.binop.result, code->opKind), getOp(code->u.binop.op1, code->opKind), code->u.binop.arithType, getOp(code->u.binop.op2, VAL_OP));
            break;
        case RELOP_IR:
            printf("IF %s %s %s ", getOp(code->u.relop.x, code->opKind), code->u.relop.relopType, getOp(code->u.relop.y, code->opKind));
        case GOTO_IR:
            printf("GOTO label%d\n", code->labelNo);
            break;
        case RETURN_IR:
            printf("RETURN %s\n", getOp(code->u.single.op, code->opKind));
            break;
        case DEC_IR:
            printf("DEC %s %d\n", getOp(code->u.dec.op, code->opKind), code->u.dec.decSize);
            break;
        case ARG_IR:
            printf("ARG %s\n", getOp(code->u.single.op, code->opKind));
            break;
        case CALL_IR:
            printf("%s := CALL %s\n", getOp(code->u.single.op, code->opKind), code->u.single.funcName);
            break;
        case PARAM_IR:
            printf("PARAM %s\n", getOpName(code->u.single.op));
            break;
        case READ_IR:
            printf("READ %s\n", getOp(code->u.single.op, code->opKind));
            break;
        case WRITE_IR:
            printf("WRITE %s\n", getOp(code->u.single.op, code->opKind));
            break;
        default:
            break;
    }
}