#include "objectCode.h"

FILE* fileop;

int is_iPrint_lab4 = false; //用于打印lab4

//工具人函数
void PrintMsg(char * msg){
    if(is_iPrint_lab4){
        printf("---------- %s ----------\n", msg);
    }
    return;
}

void wrtieInitCode(){
        //data
        fprintf(fileop,".data\n");
        fprintf(fileop,"_prompt: .asciiz \"Enter an interger:\"\n");
        fprintf(fileop,"_ret: .asciiz \"\\n\"\n");
        //text
        fprintf(fileop,".globl main\n");
        fprintf(fileop,".text\n");
        //read
        fprintf(fileop,"read:\n");        
        fprintf(fileop,"li $v0, 4\n");        
        fprintf(fileop,"la $a0, _prompt\n");
        fprintf(fileop,"syscall\n");        
        fprintf(fileop,"li $v0, 5\n");
        fprintf(fileop,"syscall\n");
        fprintf(fileop,"jr $ra\n\n");
        //write
        fprintf(fileop,"write:\n");        
        fprintf(fileop,"syscall\n");        
        fprintf(fileop,"li $v0, 4\n");
        fprintf(fileop,"la $a0, _ret\n");
        fprintf(fileop,"syscall\n");
        fprintf(fileop,"move $v0, $0\n");
        fprintf(fileop,"jr $ra\n\n");
        //main
        fprintf(fileop,"main:\n");
}


void objectCode(InterCodes codes){
    fileop = fopen(compileFileName, "w");
    //TODO:清理寄存器，做好初始化准备

    //初始化先写入固定的code
    wrtieInitCode();
    //逐条翻译各语句
    InterCodes tempcode = codes;
    while (tempcode != NULL)
    {
        TranslateInterCode(tempcode);
        tempcode = tempcode->next;
    }
    fclose(fileop);
}

void TranslateInterCode(InterCodes code) {
    
}