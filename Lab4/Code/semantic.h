#ifndef SEMANTIC_H
#define SEMANTIC_H

#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "GramTree.h" 

#define MAX_STACKNUM 100  //max areas 最大嵌套层数
#define MAX_HASHNUM 16384  //max ids and funcs 最大符号表的个数
#define MAX_TYPENUM 1000

typedef struct Type_* Type;             //类型
typedef struct FieldList_* FieldList;   //域定义
typedef struct SymbolElem_* SymbolElem; //符号
//三个struct的大小
typedef struct Type_ Typesize;
typedef struct FieldList_ FieldListsize;
typedef struct SymbolElem_ symElemsize;

enum { INT_TYPE, FLOAT_TYPE };          
enum { false, true} bool;

struct Type_ {
    enum { BASIC, ARRAY, STRUCTURE } kind;
    union{
        int basic;  // 基本类型
        struct { Type elem; int size; } array;  // 数组类型信息包括元素类型与数组大小构成
        FieldList structure;               // 结构体类型信息是一个链表
    } u;
};

struct FieldList_ {
    char* name;     // 域的名字
    Type  type;     // 域的类型
    FieldList tail; //下一个域
};

struct SymbolElem_ {
    char name[30]; 
    int lineNo;
    enum { VAR_ELEMENT, FUNCTION, STRUCTURE_ELEMENT } kind; //三种类型定义
    int symIndex;
    int isParam;
    union {
        Type var;   //存储 VAR 和 STRUCTURE
        struct { 
            Type retType; 
            FieldList varList; 
            int complete;   //complete代表函数是否被定义完整
        } func;     //存储函数
    } u;
    SymbolElem right;    //open hashing
    SymbolElem down;     //local GrammarTree chain
};

//分析入口
void semantic_Init();
void semanticParse(GramTree* root);     //semantic parser

//处理函数

SymbolElem Handle_VarDec(GramTree* h, Type type); //进行处理变量的符号表定义
void Handle_ExtDef(GramTree* root);
SymbolElem Handle_FunDec(GramTree* root);
void Handle_CompSt(GramTree* root, Type type);
FieldList Handle_Args(GramTree* root);
FieldList Handle_VarList(GramTree* root);
void Handle_DefList(GramTree* root);
void Handle_Def(GramTree* root);
void Handle_DecList(GramTree* root, Type type);
void Handle_Dec(GramTree* root, Type type);
void Handle_StmtList(GramTree* root, Type type);
void Handle_Stmt(GramTree* root, Type type);
Type Handle_Exp(GramTree* root);
//工具人函数
FieldList getFieldList(GramTree* root); //得到节点的域
Type getType(GramTree* root);         //得到树节点的Type
void printPhase(char * msg);
void printError(char * msg);
void printProduction(GramTree* root);
void printSymbolElem(SymbolElem sym);
void myPrintf(const char* format, ...);
int isEqual(char *a, char *b);

// SymbolElem_ findFromSymbolTable();
void Clear_TopOf_Stack();   //跳出嵌套
void insert_Symbol_Table(SymbolElem p); // stackIndex
int insert_symbol_List(SymbolElem p);
SymbolElem findFromTable_Struct(char *name);
SymbolElem findFromTable(char *name);
SymbolElem findFromList(int index);
void CheckLeftAssign(GramTree* root); //检查是否是左值表达式

// Lab3 对于Code和符号支持
void defineReadWriteFunc();
int insert_Type_List(Type type);
Type findExpTypeFromList(int index);

// 判断函数
int isTypeEqual(Type a, Type b);
int isFiledListEqual(FieldList a, FieldList b);
//报错
void printErrorOfSemantic(int error_type, int line_no, char* str);

//进行符号表的打印
void printSymbolList();

#endif