#include "objectCode.h"

FILE* fileop;

int is_iPrint_lab4 = true; //用于打印lab4
int CurTime = 0;            //用于寄存器分配，时间最早的寄存器算法
int global_offset = 0;             //用于确定在内存中的位置
Reg myReg[MAX_REGNUM];      //regNUM
// $28 $gp (Global Pointer) 指向静态数据段64K内存空间的中部
// $29 $sp (Stack Pointer) 栈顶指针
Var FuncList = NULL;//函数的
int ArgCnt = 0;       //函数的参数个数
int ADDRcount = 0;      //这个变量主要用于地址转换得寄存器寻址名称
int NumberCount = 0;    //这个变量主要用于数字转换得寄存器寻址名称
//工具人函数
void WarnMsg(char * msg){
    if(is_iPrint_lab4){
        printf("\033[31m %s \033[0m\n", msg);
    }
    return;
}

int ConutOfInterCode(InterCodes Code) { //一个函数的多少语句
    int t = 0;
    Code = Code->next;
    while(Code->code->kind != FUNC_IR) {
        t++;
        Code = Code->next;
    }
    return t;
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
        fprintf(fileop,"li $v0, 1\n");    
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

int getReg() {
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
    if(RegIndex != -1) { 
        myReg[RegIndex].isVaiable = true;
        myReg[RegIndex].LastUsedTime = 0;
        myReg[RegIndex].varialbe = NULL;
        myReg[RegIndex].isModified = false;
        //将第Res个寄存器值写回内存中 
        fprintf(fileop,"subu $v0, $fp, %d\n",t->offset);
        fprintf(fileop,"sw $%s, 0($v0)\n",myReg[RegIndex].name);
    }
}

void objectCode(InterCodes codes){
    fileop = fopen(compileFileName, "w");
    //TODO:清理寄存器，做好初始化准备
    InitRegs();
    //初始化先写入固定的code
    wrtieInitCode();
    //逐条翻译各语句
    InterCodes tempcode = codes;
    TranslateInterCode(tempcode);
    tempcode = tempcode->next;
    while (tempcode != codes)
    {
        CurTime += 1; //时间加一
        printf("\nCurTime:%d\n",CurTime);
        TranslateInterCode(tempcode); 
        tempcode = tempcode->next;
    }
    fclose(fileop);
}

void TranslateInterCode(InterCodes Code) { //转化一条语句
    int codekind = Code->code->kind;
    printf("codekind:%d\n",codekind);
    switch (codekind) {
    case LABLE_IR:{ 
        //将寄存器刷回内存 ?
        Var h = FuncList;		
		while(h != NULL) {
			if(h->isUsingReg >= 8 && h->isUsingReg <= 25) {
                flushReg(h);
            }
            h = h->next;
        }
        //输出标签号
        fprintf(fileop,"label%d:\n",Code->code->labelNo);
        break;
    }

    case FUNC_IR: {
        //TODO:栈的管理
        WarnMsg("Finish FUNC\n");
        fprintf(fileop,"\n%s:\n",Code->code->u.single.funcName);//输出函数名称
        FuncList = NULL;   //TODO:不能直接NULL,记得释放变量熬
        global_offset = 8; //预先是8，因为有两个固定
        //进入函数首先需要保存好这两个东西
        fprintf(fileop,"subu $sp, $sp, 4\n"); 
		fprintf(fileop,"sw $ra, 0($sp)\n");
		fprintf(fileop,"subu $sp, $sp, 4\n");
		fprintf(fileop,"sw $fp, 0($sp)\n");
		fprintf(fileop,"addi $fp, $sp, 8\n");
        //栈的预分配空间，除了数组和Struct需要额外分配空间
        int t = ConutOfInterCode(Code);
        printf("this func's number code:%d\n",t);
        int size = t * 4 * 3;
        fprintf(fileop,"subu $sp, $sp, %d\n",size);
        //进行处理参数
        InterCodes pa = Code->next;
        int ArgCount = 0;      //函数的参数的个数
        while (pa->code->kind == PARAM_IR && ArgCount < 4) {//小于4的时候进行处理，从ax加载
            WarnMsg("PARAM_IR\n");
            Operand op = pa->code->u.single.op;
            char* name = getName(op);
            printf("!!!%s,%d\n",name,op->kind);
            int ArgIndex = findReg(name);
            if(ArgCount == 0) {
                fprintf(fileop,"move $%s, $a0\n",myReg[ArgIndex].name);
            } else if(ArgCount == 1){
                fprintf(fileop,"move $%s, $a1\n",myReg[ArgIndex].name);
            } else if(ArgCount == 2){
                fprintf(fileop,"move $%s, $a2\n",myReg[ArgIndex].name);
            } else if(ArgCount == 3){
                fprintf(fileop,"move $%s, $a3\n",myReg[ArgIndex].name);
            }
            ArgCount++;
            pa = pa->next;
        }
        while (pa->code->kind == PARAM_IR) {
            char* name = getOperand(pa->code->u.single.op,pa->code->opKind);
            int ArgIndex = findReg(name);
            int of = (ArgCount - 4) * 4;
            fprintf(fileop,"lw $%s, %d($fp)\n",myReg[ArgIndex].name,of);
            ArgCount++;
            pa = pa->next;
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
        if(left->kind == VARIABLE || left->kind == TEMP) {
            if(right->kind == CONSTANT) { //常数
                printf("leftRegNum = %d\n",RegIndex_Left);
                fprintf(fileop,"li  $%s, %d\n", myReg[RegIndex_Left].name, right->u.value);
            } else if(right->kind == VARIABLE || right->kind == TEMP) { //地址
                int RegIndex_Right = findReg(rightname);
                fprintf(fileop,"move $%s, $%s\n", myReg[RegIndex_Left].name, myReg[RegIndex_Right].name);
            } else if(right->kind == ADDRESS) {
                WarnMsg("ADDRESS!");
                int RegIndex_Right = findReg(rightname);
                fprintf(fileop,"lw  $%s, 0($%s)\n", myReg[RegIndex_Left].name, myReg[RegIndex_Right].name);
            } else {
                assert(0);
            }
        } else if(left->kind == ADDRESS) {
            if(right->kind == CONSTANT) { //常数
                printf("leftRegNum = %d\n",RegIndex_Left);
                fprintf(fileop,"sw %d, 0($%s)\n", right->u.value, myReg[RegIndex_Left].name);
            } else if(right->kind == VARIABLE || right->kind == TEMP) { //地址
                int RegIndex_Right = findReg(rightname);
                fprintf(fileop,"sw $%s, 0($%s)\n", myReg[RegIndex_Right].name, myReg[RegIndex_Left].name);
            } else if(right->kind == ADDRESS) {
                WarnMsg("ADDRESS!"); assert(0);
                int RegIndex_Right = findReg(rightname);
                fprintf(fileop,"sw $%s, 0($%s)\n",  myReg[RegIndex_Right].name, myReg[RegIndex_Left].name);
            } else {
                assert(0);
            }
        } else { assert(0); }
        //修改左值
        myReg[RegIndex_Left].isModified = true;
        break;
    }
    case ARITH_IR:{ //算术指令 x := y + z 加减乘除操作
        Operand op_result = Code->code->u.binop.result;
        Operand op_left = Code->code->u.binop.op1;
        Operand op_right = Code->code->u.binop.op2;
        int isNeg = false; //用于记录翻转加号
        //首先获取算术指令集
        char temp[10]; char operation = Code->code->u.binop.arithType;
        if(operation == '+') {
            strcpy(temp,"add");
        } else if(operation == '-') {
            strcpy(temp,"sub");
        } else if(operation == '*') {
            strcpy(temp,"mul");
        } else if(operation == '/') {
            strcpy(temp,"div");
        }
        if(op_left->kind == CONSTANT || op_right->kind == CONSTANT) { //i
            strcat(temp,"i");
        }
        WarnMsg("please test if i can be appended!\n");
        printf("temp:%s\n",temp);
        if(op_right->kind == CONSTANT && isEqual(temp,"subi") == true) { //改变一下特殊处理
            isNeg = true;   
            strcpy(temp,"addi");
        }
        //进行判断
        char* result_name = getOperand(op_result,Code->code->kind);
        char* left_name = getOperand(op_left,Code->code->kind);
        char* right_name = getOperand(op_right,Code->code->kind);
        int reg_left,reg_right,reg_result;
        //首先判断结果寄存器，不可能为常数，如果是地址需要改变
        reg_result = DivByType(result_name,op_result);
        if(reg_result == -1) { assert(0); }
        //左边结果寄存器
        reg_left = DivByType(left_name,op_left);
        //右边结果寄存器
        reg_right = DivByType(right_name,op_right);
        fprintf(fileop,"%s $%s, ",temp,myReg[reg_result].name);
        if(reg_left == -1) {
            fprintf(fileop,"%d, ",op_left->u.value);
        } else {
            fprintf(fileop,"$%s, ",myReg[reg_left].name);
        }
        if(reg_right == -1) {
            if(isNeg == true) {
                fprintf(fileop,"-");
            }
            fprintf(fileop,"%d\n",op_right->u.value);
        } else {
            fprintf(fileop,"$%s\n",myReg[reg_right].name);
        }
        break;
    }

    case GOTO_IR: { //转移控制指令
        //将寄存器刷回内存 ?
        Var h = FuncList;		
		while(h != NULL) {
			if(h->isUsingReg >= 8 && h->isUsingReg <= 25) {
                flushReg(h);
            }
            h = h->next;
        }
        fprintf(fileop,"j label%d\n",Code->code->labelNo);
        break;
    }
    
    case RELOP_IR: { //RELOP指令
        WarnMsg("Start Relop\n");
        //首先收回内存，清空寄存器收回内存
        Var h = FuncList;		
		while(h != NULL) {
			if(h->isUsingReg >= 8 && h->isUsingReg <= 25) {
                flushReg(h);
            }
            h = h->next;
        }
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
        } else if(isEqual(RelopType,"==")) {
            strcpy(comp,"beq");
        }  else if(isEqual(RelopType,"!=")) {
            strcpy(comp,"bne");
        }  else {
            printf("Relop type:%s\n",RelopType);
            assert(0);
        }
        //打印左边
        printf("leftname:%s,rightname:%s\n",leftname,rightname);
        char left_toprint[10],right_toprint[10];
        if(op_left->kind == CONSTANT) {
            strcpy(left_toprint,NumberToChar(op_left->u.value));
        } else if(op_left->kind == VARIABLE || op_left->kind == TEMP) {
            int RegIndex_lf = findReg(leftname);
            strcpy(left_toprint,"$");
            strcat(left_toprint,myReg[RegIndex_lf].name);
        } else if(op_left->kind == ADDRESS) {
            int RegIndex_lf = findReg(leftname);
            strcpy(left_toprint,"0($");
            strcat(left_toprint,myReg[RegIndex_lf].name);
            strcat(left_toprint,")");
            //fprintf(fileop,"0($%s), ",myReg[RegIndex_lf].name);
        } else { assert(0);}
        //打印右边
        if(op_right->kind == CONSTANT) {
            strcpy(right_toprint,NumberToChar(op_right->u.value));
        } else if(op_right->kind == VARIABLE || op_right->kind == TEMP) {
            int RegIndex_rt = findReg(rightname);
            strcpy(right_toprint,"$");
            strcat(right_toprint,myReg[RegIndex_rt].name);
        } else if(op_right->kind == ADDRESS) {
            int RegIndex_rt = findReg(rightname);
            strcpy(right_toprint,"0($");
            strcat(right_toprint,myReg[RegIndex_rt].name);
            strcat(right_toprint,")");
        } else { assert(0); }
        fprintf(fileop,"%s %s %s ",comp,left_toprint,right_toprint);
        fprintf(fileop,"label%d\n",Code->code->u.relop.label);
        WarnMsg("Finish Relop\n");
        break;
    }

    case RETURN_IR: { //返回指令
        WarnMsg("RETURN IR\n");
        //栈管理
        Operand op = Code->code->u.single.op;
        char* name = getOperand(op,Code->code->kind);
        int regIndex = DivByType(name,op);
		fprintf(fileop,"subu $sp, $fp, 8\n");
		fprintf(fileop,"lw $fp, 0($sp)\n");
		fprintf(fileop,"addi $sp, $sp, 4\n");
		fprintf(fileop,"lw $ra, 0($sp)\n");
		fprintf(fileop,"addi $sp, $sp, 4\n");
        if(regIndex == -1) {
            fprintf(fileop,"li $v0, ");
            fprintf(fileop,"%d\n",op->u.value);
        } else {
            fprintf(fileop,"move $v0, ");
            fprintf(fileop,"$%s\n",myReg[regIndex].name);
        }
        fprintf(fileop,"jr $ra\n");
        break;
    }

    case DEC_IR: { 
        Operand op = Code->code->u.dec.op;
        int decSize = Code->code->u.dec.decSize;
        char* name = getOperand(op,Code->code->opKind);
        int index = findReg(name);
        //拓展栈的大小
        fprintf(fileop,"subu $sp, $sp, %d\n",decSize * 4);
        //offset需要加 (decsize - 1) * 4
        global_offset += (decSize - 1) * 4; 
        break;
    }

    case ARG_IR:{ //参数声明,开始遍历所有的参数
        ArgCnt++;
        break;
    }

    case CALL_IR:{ //最复杂
        //开始找参数
        InterCodes Arg = Code->prev;
        int i = 0;
        while (i < ArgCnt && i < 4 && Arg->code->kind == ARG_IR) { //参数
            Operand op = Arg->code->u.single.op;
            char* name = getOperand(op, Arg->code->opKind);
            int ArgIndex = DivByType(name,op);
            if(ArgIndex == -1) { //数字给新的寄存器
                ArgIndex = newArgToNum(op);
            }
            if(i == 0) {
                fprintf(fileop,"move $a0, $%s\n",myReg[ArgIndex].name);
            } else if(i == 1) {
                fprintf(fileop,"move $a1, $%s\n",myReg[ArgIndex].name);
            } else if(i == 2) {
                fprintf(fileop,"move $a2, $%s\n",myReg[ArgIndex].name);
            } else if(i == 3) {
                fprintf(fileop,"move $a3, $%s\n",myReg[ArgIndex].name);
            }
            i++; 
            Arg = Arg->prev;
        }
        if(ArgCnt > 4) { //溢出，写到内存中
            //首先开辟内存块
            int size = (ArgCnt - i) * 4;
            fprintf(fileop,"subu $sp, %d\n",size);
            while(i < ArgCnt) { 
                Operand op = Arg->code->u.single.op;
                char* name = getOperand(op, Arg->code->opKind);
                int ArgIndex = DivByType(name,op);
                if(ArgIndex == -1) { //数字给新的寄存器
                    ArgIndex = newArgToNum(op);
                }
                fprintf(fileop,"sw $%s, %d($sp)\n",myReg[ArgIndex].name,(i - 4) * 4);
                i++;
                Arg = Arg->prev;
            }
        }
        //首先收回内存，清空寄存器收回内存
        Var h = FuncList;		
		while(h != NULL) {
			if(h->isUsingReg >= 8 && h->isUsingReg <= 25) {
                flushReg(h);
            }
            h = h->next;
        }
        ArgCnt = 0; //清空参数
        Operand x = Code->code->u.single.op;
        fprintf(fileop,"jal %s\n",Code->code->u.single.funcName); //跳转函数
        //栈管理
        if(i > 4) {
            fprintf(fileop,"addi $sp, $sp, %d\n",(i - 4) * 4); //参数的要加上
        }
        //返回值赋值
        if(x != NULL) {
            WarnMsg("x := CALL f");
            char* n = getOperand(x,Code->code->opKind);
            int RegIndex = DivByType(n,x);
            assert(RegIndex != -1);
            fprintf(fileop,"move $%s, $v0\n",myReg[RegIndex].name);
        }
        break;
    }
    case PARAM_IR:{
        //函数声明的时候已经处理过
        break;
    }

    case READ_IR:{ //读寄存器
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

    case WRITE_IR: { //写寄存器
        Operand op = Code->code->u.single.op;
        char* name = getOperand(op,Code->code->opKind);
        int RegIndex = DivByType(name,op);
        fprintf(fileop,"move $a0, $%s\n",myReg[RegIndex].name);
        fprintf(fileop,"addi $sp, $sp, -4\n");
        fprintf(fileop,"sw $ra, 0($sp)\n"); 
        fprintf(fileop,"jal write\n"); 
        fprintf(fileop,"lw $ra, 0($sp)\n"); 
        fprintf(fileop,"addi $sp, $sp, 4\n"); 
        //TODO: if necessary do sth
        break;  
    }
    default:
        assert(0);
        break;
    }
}

char* NumberToChar(int value) {
    char* t = malloc(sizeof(char) * 32);
    sprintf(t,"%d",value);
    return t;
} 

int DivByType(char* name,Operand op) {
    if(op->kind == CONSTANT) {
        return -1;              
    } else if(op->kind == VARIABLE || op->kind == TEMP) {
        int index = findReg(name);
        return index; 
    } else if(op->kind == ADDRESS) {
        ADDRcount++;
        int TempIndex = findReg(name); //获得地址值
        char temp[32];
        strcpy(temp,"ADDR_");
        strcat(temp,NumberToChar(ADDRcount));
        int DestReg = findReg(temp);   //获得下一个寄存器，移动
        fprintf(fileop,"move $%s, 0($%s)\n",myReg[DestReg].name, myReg[TempIndex].name);
        return DestReg; //返回地址得值
    }
}

int newArgToNum(Operand op) { //给数字，数字首先加载到寄存器中
    assert(op->kind == CONSTANT);
    NumberCount++;
    char temp[32];
    strcpy(temp,"NUMB_");
    strcat(temp,NumberToChar(NumberCount));
    int DestReg = findReg(temp);   //获得下一个寄存器，移动
    fprintf(fileop,"lw $%s, %d\n",myReg[DestReg].name, op->u.value);
    return DestReg; //返回地址得值
}