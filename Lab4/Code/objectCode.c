#include "objectCode.h"

FILE* fileop;

int is_iPrint_lab4 = true; //用于打印lab4
int CurTime = 0;            //用于寄存器分配，时间最早的寄存器算法
int global_offset = 0;             //用于确定在内存中的位置
Reg myReg[MAX_REGNUM];      //regNUM
// $28 $gp (Global Pointer) 指向静态数据段64K内存空间的中部
// $29 $sp (Stack Pointer) 栈顶指针
Var FuncList = NULL;//函数的
int ArgCount = 0;       //函数的参数个数
//工具人函数
void WarnMsg(char * msg){
    if(is_iPrint_lab4){
        printf("\033[31m %s \033[0m\n", msg);
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
}

void InitRegs() {
    for(int i = 0; i < MAX_REGNUM; i++) {
        myReg[i].isVaiable = true; //可获得
        myReg[i].varialbe = NULL; //空指针
        myReg[i].isModified = false;
    }
    strcpy(myReg[2].name,"v0");  strcpy(myReg[3].name,"v1");
    //A
    strcpy(myReg[4].name,"a0");  strcpy(myReg[5].name,"a1");
    strcpy(myReg[6].name,"a2");  strcpy(myReg[7].name,"a3");
    //T
    strcpy(myReg[8].name,"t0");  strcpy(myReg[9].name,"t1");
    strcpy(myReg[10].name,"t2"); strcpy(myReg[11].name,"t3");
    strcpy(myReg[12].name,"t4"); strcpy(myReg[13].name,"t5");
    strcpy(myReg[14].name,"t6"); strcpy(myReg[15].name,"t7");
    strcpy(myReg[16].name,"t8"); strcpy(myReg[17].name,"t9");
    //S
    strcpy(myReg[18].name,"s0"); strcpy(myReg[19].name,"s1");
    strcpy(myReg[20].name,"s2"); strcpy(myReg[21].name,"s3");
    strcpy(myReg[22].name,"s4"); strcpy(myReg[23].name,"s5");
    strcpy(myReg[24].name,"s6"); strcpy(myReg[25].name,"s7");
}

void InsertIntoList(Var a){
    a->next = NULL;
    if(FuncList == NULL) {
        FuncList = a;
    } else {
        Var h = FuncList;
        while(h->next != NULL) {
            h = h->next;
        }
        h->next = a;
    }
}

char * getNameFromOperand(Operand op,int opKind) {
    if(op->kind == CONSTANT) {
        int val = op->u.value;
        char *temp = malloc(sizeof(char) * 32);
		memset(temp,0,32);
		sprintf(temp, "%d", val);
        return temp;
    } else if(op->kind == VARIABLE || op->kind == TEMP) {
        char *name = getOperand(op,opKind);
        return name;
    } else if(op->kind == ADDRESS) {
        char *name = getOperand(op,opKind);
        return name;
    } else {
        assert(0);
    }
    
}

int getReg(){
    printf("Start find Reg!\n");
    for(int i = 8; i <= 25; i++) {
        if(myReg[i].isVaiable == true) {
            return i;
        }
    }
    //如果没有空闲的寻找最早没有使用的语句
    int EarlyTime = __INT_MAX__;
    int Res = -1;
    for(int i = 8; i <= 25; i++) {
        if(myReg[i].LastUsedTime < EarlyTime) {
            EarlyTime = myReg[i].LastUsedTime;
            Res = i;
        }
    }   
    Var temp = myReg[Res].varialbe;
    temp->isUsingReg = -1;
    myReg[Res].isVaiable = true;
    myReg[Res].LastUsedTime = 0;
    myReg[Res].varialbe = NULL;
    //将第Res个寄存器值写回内存中 
    fprintf(fileop,"subu $v0, $fp, %d\n",temp->offset);
    fprintf(fileop,"sw $%s, 0($v0)\n",myReg[Res].name);
    //返回index
    return Res;
}


//查看变量是否在寄存器中，不在则分配寄存器
int findReg(char *name) {
    printf("find %s is in Reg\n",name);
    //判断在不在函数列表参数内
    Var h = FuncList;
    while (h != NULL) {
        printf("temp %s,%d\n",h->name,h->isUsingReg);
        if(isEqual(h->name,name) == true) {
            break;
        }
        h = h->next;
    }
    int flag = 0; //是否在内存中
    if(h == NULL) //不在函数参数中
    {
        flag = 1;
        printf("SIZE:%ld",sizeof(VarSize));
        h = malloc(sizeof(VarSize));
        strcpy(h->name,name);
        h->isUsingReg = -1; 
        global_offset += 4; 
        h->offset = global_offset;
        h->next = NULL;
        InsertIntoList(h); //放进入函数表中
    }
    //开始使用分配寄存器
    if(h->isUsingReg == -1) {
        printf("!!!!?\n");
        int regNum = getReg(); //找寻可用的寄存器
        h->isUsingReg = regNum;
        myReg[regNum].varialbe = h; 
        myReg[regNum].isVaiable = false;
        myReg[regNum].isModified = false;
        if(flag == 0) { //内存值写到寄存器中
            fprintf(fileop,"subu $v0, $fp, %d\n",h->offset);
            fprintf(fileop,"lw $%s, 0($v0)\n",myReg[regNum].name);
        }
    }
    //更新用到值
    myReg[h->isUsingReg].LastUsedTime = CurTime;
	return h->isUsingReg;
}

void objectCode(InterCodes codes){
    fileop = fopen(compileFileName, "w");
    //TODO:清理寄存器，做好初始化准备
    InitRegs();
    //初始化先写入固定的code
    wrtieInitCode();
    //逐条翻译各语句
    InterCodes tempcode = codes;
    while (tempcode ->next != codes)
    {
        CurTime += 1; //时间加一
        TranslateInterCode(tempcode); 
        tempcode = tempcode->next;
    }
    fclose(fileop);
}

void Insert(char *name) { //将新变量插入到其中
    
}

int isInVarList(char *name) {
    Var p = FuncList;
    while (p != NULL)
    {
        if(isEqual(p->name,name) == true){
            return true;
        }
    }
    return false; //不在其中
}

void flushReg(Var t) {
    int RegIndex = t->isUsingReg;
    t->isUsingReg = -1;
    //将寄存器的值写回
    if(t->isUsingReg != -1) {
        if(myReg[RegIndex].isModified == false) return; //未被修改过 
        myReg[RegIndex].isVaiable = true;
        myReg[RegIndex].LastUsedTime = 0;
        myReg[RegIndex].varialbe = NULL;
        myReg[RegIndex].isModified = false;
        //将第Res个寄存器值写回内存中 
        fprintf(fileop,"subu $v0, $fp, %d\n",t->offset);
        fprintf(fileop,"sw $%s, 0($v0)\n",myReg[RegIndex].name);
    }
}

void TranslateInterCode(InterCodes Code) { //转化一条语句
    int codekind = Code->code->kind;
    printf("codekind:%d\n",codekind);
    switch (codekind) {
    case LABLE_IR:{ 
        //将寄存器刷回内存 ?
        // Var h = FuncList;		
		// while(h != NULL) {
		// 	if(h->isUsingReg >= 8 && h->isUsingReg <= 25) {
        //         flushReg(h);
        //     }
        //     h = h->next;
        // }
        //输出标签号
        fprintf(fileop,"label%d:\n",Code->code->labelNo);
        break;
    }

    case FUNC_IR: {
        fprintf(fileop,"%s:\n",Code->code->u.single.funcName);//输出函数名称
        FuncList = NULL; //清空使用变量
        int ArgCount = 0;    //函数的参数的个数
        InterCodes head = Code;
        while (head->code->kind == PARAM_IR)
        {
            ArgCount++;
            head = head->next;
        }
        WarnMsg("Finish FUNC\n");
        break;
    }
    case ASSIGN_IR:{ 
        Operand left = Code->code->u.assign.left;   //获取左边
        Operand right = Code->code->u.assign.right; //获取右边
        char *leftname = getOperand(left,Code->code->opKind);
        char *rightname = getOperand(right,Code->code->opKind);
        printf("assign Leftname:%s, rightName:%s\n",leftname,rightname);
        int RegIndex_Left = findReg(leftname); //对左式进行寄存器的分配
        if(right->kind == CONSTANT) { //常数
            printf("leftRegNum = %d\n",RegIndex_Left);
            fprintf(fileop,"li  $%s, %d\n", myReg[RegIndex_Left].name, right->u.value);
        } else if(right->kind == VARIABLE || right->kind == TEMP) { //地址
            int RegIndex_Right = findReg(rightname);
            fprintf(fileop,"move  $%s, $%s\n", myReg[RegIndex_Left].name, myReg[RegIndex_Right].name);
        } else if(right->kind == ADDRESS) {
            WarnMsg("ADDRESS!");
            int RegIndex_Right = findReg(rightname);
            fprintf(fileop,"lw  $%s, 0($%s)\n", myReg[RegIndex_Left].name, myReg[RegIndex_Right].name);
        } else {
            assert(0);
        }
        //修改左值
        myReg[RegIndex_Left].isModified = true;
        break;
    }
    case ARITH_IR:
        /* code */
        break;

    case GOTO_IR: { //转移控制指令
        fprintf(fileop,"j label%d\n",Code->code->labelNo);
        break;
    }
    
    case RELOP_IR: { //RELOP指令
        WarnMsg("Start Relop\n");
        Operand op_left = Code->code->u.relop.x;
        Operand op_right = Code->code->u.relop.y;
        char * leftname = getNameFromOperand(op_left, Code->code->opKind);
        char * rightname = getNameFromOperand(op_right, Code->code->opKind);
        //中间比较指令
        char comp[5];
        char * RelopType = Code->code->u.relop.relopType;
        if(isEqual(RelopType,">")) {
            strcpy(comp,"bgt");
        } else if(isEqual(RelopType,">=")) {
            strcpy(comp,"bge");
        } else if(isEqual(RelopType,"<")) {
            strcpy(comp,"blt");
        } else if(isEqual(RelopType,"<=")) {
            strcpy(comp,"ble");
        } else {
            assert(0);
        }
        fprintf(fileop,"%s ",comp);
        //打印左边
        printf("leftname:%s,rightname:%s\n",leftname,rightname);
        if(op_left->kind == CONSTANT) {
            fprintf(fileop,"%d, ",op_left->u.value);
        } else if(op_left->kind == VARIABLE || op_left->kind == TEMP) {
            int RegIndex_lf = findReg(leftname);
            fprintf(fileop,"$%s, ",myReg[RegIndex_lf].name);
        } else if(op_left->kind == ADDRESS) {
            int RegIndex_lf = findReg(leftname);
            fprintf(fileop,"0($%s), ",myReg[RegIndex_lf].name);
        } else { assert(0);}
        //打印右边
        if(op_right->kind == CONSTANT) {
             fprintf(fileop,"%d, ",op_right->u.value);
        } else if(op_right->kind == VARIABLE || op_right->kind == TEMP) {
            int RegIndex_rt = findReg(rightname);
            fprintf(fileop,"$%s, ",myReg[RegIndex_rt].name);
        } else if(op_right->kind == ADDRESS) {
            int RegIndex_rt = findReg(rightname);
            fprintf(fileop,"0($%s), ",myReg[RegIndex_rt].name);
        } else { assert(0); }
        fprintf(fileop,"label%d\n",Code->code->u.relop.label);
        WarnMsg("Finish Relop\n");
        break;
    }

    case RETURN_IR:
        /* code */
        break;

    case DEC_IR:
        /* code */
        break;

    case ARG_IR:
        /* code */
        break;

    case CALL_IR:
        /* code */
        break;

    case PARAM_IR:
        /* code */
        break;

    case READ_IR:{ //读到内存中
        fprintf(fileop,"addi $sp, $sp, -4\n");
        fprintf(fileop,"sw $ra, 0($sp)\n"); 
        fprintf(fileop,"jal read\n"); 
        fprintf(fileop,"lw $ra, 0($sp)\n"); 
        fprintf(fileop,"addi $sp, $sp, 4\n"); 
        //调用之后结果存放在 v0中
        char* name = getOperand(Code->code->u.single.op,Code->code->opKind);
        int RegIndex = findReg(name); //寻找寄存器
        fprintf(fileop,"move $%s, $v0\n",myReg[RegIndex].name); 
        break;  
    }

    case WRITE_IR:
        /* code */
        break;

    default:
        break;
    }


}