#ifndef OBJECT_H
#define OBJECT_H

#include"InterCode.h"
#define MAX_REGNUM 26   //寄存器的数量

char* compileFileName; //写出的文件的名字
typedef struct Reg_* Reg; 
typedef struct Var_* Var; 

//寄存器的定义
struct Reg_ {   
    char name[10];  //寄存器的名字
    int isVaiable;  //寄存器是否可用
    Var varialbe;   //寄存器存放的变量名字和地址
};

//变量的定义
struct Var_ {  
    char name[20];
    int isUsingReg; //是否在寄存器中
    int offset;     //TODO:
};


void wrtieInitCode();    //初始化必要的文件头
void TranslateInterCode(InterCodes code);   //转换一条语句


//主函数
void objectCode(InterCodes codes);


#endif