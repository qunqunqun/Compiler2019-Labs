#ifndef OBJECT_H
#define OBJECT_H

#include"InterCode.h"
#define MAX_REGNUM 32   //寄存器的数量
#define ESP_NUM 28      //ESP指针寄存器
#define STACK_NUM 29    //栈指针寄存器

char* compileFileName; //写出的文件的名字
typedef struct Reg_ Reg; 
typedef struct Var_* Var; 
// typedef struct Var_  VarSize; 
//寄存器的定义
struct Reg_ {   
    char name[10];      //寄存器的名字
    int isVaiable;      //寄存器是否可用
    Var varialbe;       //寄存器存放的变量名字和地址
    int LastUsedTime;   //寄存器分配算法，非启发式
    int isModified;     //是否进行过修改
};

//变量的定义
struct Var_ {  
    char name[20];
    int isUsingReg; //是否在寄存器中
    int offset;     //TODO:
    Var next;       //数据结构链表结构
} VarSize;

//工具人函数
void InitRegs();                //初始化寄存器
void InsertIntoList(Var a);     //插入到链表头中
int getReg();                   //找到适合的寄存器分配
int findReg(char *name);        //找到适合的寄存器
void flushReg(Var t);           //将寄存器刷回
void wrtieInitCode();           //初始化必要的文件头
void TranslateInterCode(InterCodes code);   //转换一条语句
char* NumberToChar(int value);
int DivByType(char* name,Operand op);
//主函数
void objectCode(InterCodes codes);


#endif