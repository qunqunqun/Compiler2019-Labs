#ifndef SEMANTIC_H
#define SEMANTIC_H

#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "GramTree.h" 

#define MAX_STACKNUM 100  //max areas 最大嵌套层数
#define MAX_HASHNUM 16384  //max ids and funcs 最大符号表的个数

typedef struct Type_* Type;             //类型
typedef struct FieldList_* FieldList;   //域定义
typedef struct SymbolElem_* SymbolElem; //符号
//三个struct的大小
typedef struct Type_ Typesize;
typedef struct FieldList_ FieldListsize;
typedef struct SymbolElem_ symElemsize;

enum { INT_TYPE, FLOAT_TYPE };          

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

SymbolElem symbol_HashTable[MAX_HASHNUM]; //define hash table

SymbolElem symbol_Stack[MAX_STACKNUM]; //define symelem stack
int Top_of_stack = -1;  //the top of stack

SymbolElem symList[MAX_STACKNUM];
int global_Symbol_Index = 0;         //global sym  index,符号表
Type typeList[MAX_STACKNUM];
int global_Type_Index = 0;        //global type index，类型定义


void semantic_Init();
FieldList getFieldList(GramTree* root); //得到节点的域
Type getType(GramTree* root);         //得到树节点的Type
SymbolElem Handle_VarDec(GramTree* h, Type type); //进行处理变量的符号表定义
void Insert_Into_Table(GramTree* root);
void semanticParse(GramTree* root);     //semantic parser
void insert_Symbol_Table(SymbolElem p, int stackIndex); // stackIndex
void printErrorOfSemantic(int error_type, int line_no, char* str);

#endif