#include "semantic.h"

// 址操作与值操作
enum { ADDR_OP, VAL_OP } ;

// 操作数
typedef struct Operand_* Operand; 
typedef struct Operand_ {
    enum { VARIABLE, CONSTANT, ADDRESS } kind;
    union {
        int var_no;
        int value;
    } u;
}OperandBody;


// 中间代码
typedef struct InterCode_* InterCode;
typedef struct InterCode_{
    enum { 
        LABLE_IR,   //  LABEL x :定义标号x。
        FUNC_IR,    //  FUNCTION f :定义函数f。
        ASSIGN_IR,  //  x := y x := &y x := *y *x := y 赋值操作
        ARITH_IR,   //  x := y + z 加减乘除操作。
        GOTO_IR,    //  GOTO x 无条件跳转至标号x
        RELOP_IR,   //  IF x [relop] y GOTO z 如果x与y满足[relop]关系则跳转至标号z。
        RETURN_IR,  //  RETURN x 退出当前函数并返回x值。
        DEC_IR,     //  DEC x [size] 内存空间申请，大小为4的倍数。
        ARG_IR,     //  ARG x 传实参x。
        CALL_IR,    //  x := CALL f 调用函数，并将其返回值赋给x。
        PARAM_IR,   //  PARAM x 函数参数声明
        READ_IR,    //  READ x 从控制台读取x的值
        WRITE_IR    //  WRITE x 向控制台打印x的值。
    } kind; 
    union {
        //  赋值操作：x := y,x := &y,x := *y,*x := y
        struct { Operand right, left; } assign;
        //  算术操作 x := y + z，x := y - z，x := y * z，x := y / z
        struct { Operand result, op1, op2; char arithType; } binop;
        //  LABEL x :，FUNCTION f :，GOTO x，RETURN x，ARG x， x := CALL f，PARAM x，READ x，WRITE x
        struct { 
            Operand op;
            union {
                char *funcName;
            };
        } single; 
        //  DEC x [size]
        struct { Operand op; int decSize;} dec;  
        //  好像只有这个：IF x [relop] y GOTO z
        struct { Operand x,y; char* relopType;} relop;
    } u;
    int labelNo;    //有label，才有这个    
    int opKind;
}InterCodeBody;


// 线性IR的Linked list形式
typedef struct InterCodes_* InterCodes;
typedef struct InterCodes_ { 
    InterCode code; 
    InterCodes prev, next; 
}InterCodesBody;


// 参数列表
typedef struct ArgList_* ArgList;
typedef struct ArgList_ {
    Operand op;
    Type opType;
    ArgList next;
}ArgListBody;

// translate 函数
void translateTree(GramTree * root);
InterCodes translate_Program(GramTree* root);
InterCodes translate_ExtDefList(GramTree* root);
InterCodes translate_ExtDef(GramTree* root);
InterCodes translate_FunDec(GramTree* root);
InterCodes translate_CompSt(GramTree* root);
InterCodes translate_VarList(GramTree* root);
InterCodes translate_ParamDec(GramTree* root);
InterCodes translate_VarDec(GramTree* root);

// get函数
InterCodes getFuncCodes(GramTree* root);
Operand getVar(int value); 
// 工具人函数
void printInterCodes(InterCodes codes);
void printInterCode(InterCode code);
char* getOperand(Operand op, int opKind);
char* getName(Operand op);

// 中间代码的连接
InterCodes link2Codes(InterCodes c1, InterCodes c2);
InterCodes link3Codes(InterCodes c1, InterCodes c2, InterCodes c3);
InterCodes link4Codes(InterCodes c1, InterCodes c2, InterCodes c3, InterCodes c4);