%{

#include "common.h"
#include "GramTree.h"
#include "lex.yy.c"

extern int yylex();
extern int yylineno;

%}

%union {
    GramTree* node_type;
}

/* Tokens */
%token <node_type> INT FLOAT ID
%token <node_type> SEMI COMMA ASSIGNOP RELOP
%token <node_type> PLUS MINUS STAR DIV AND OR NOT
%token <node_type> DOT TYPE LP RP LB RB LC RC 
%token <node_type> STRUCT RETURN IF ELSE WHILE error
/* 上面的error哪来的 */

%type <node_type> Program ExtDefList ExtDef ExtDecList      /* High-level Definitions*/
%type <node_type> Specifier StructSpecifier OptTag Tag    /* Specifiers */
%type <node_type> VarDec FunDec VarList ParamDec           /* Declarators */
%type <node_type> CompSt StmtList Stmt                       /* Statements */
%type <node_type> DefList Def DecList Dec                    /* Loacal Definitions */
%type <node_type> Exp Args                                   /* Expressions */

//TODO: give rules of priority
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT
%left LP RP LB RB DOT

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

/* High-level Definitions*/
Program: ExtDefList                 { $$ = treeRoot = newTreeNode("Program",1,$1); }
    ;

ExtDefList: ExtDef ExtDefList       { $$ = newTreeNode("ExtDefList", 2, $1, $2); }
    | /*empty*/                     { $$ = newTreeNode("EMPTY", 0); }
    ;

ExtDef: Specifier ExtDecList SEMI  { $$ = newTreeNode("ExtDef", 3, $1, $2, $3); }
    | Specifier SEMI               { $$ = newTreeNode("ExtDef", 2, $1, $2);}
    | Specifier FunDec CompSt      { $$ = newTreeNode("ExtDef", 3, $1, $2, $3);}
    ;

ExtDecList: VarDec                  { $$ = newTreeNode("ExtDecList", 1, $1);}
    | VarDec COMMA ExtDecList       { $$ = newTreeNode("ExtDecList", 3, $1, $2, $3);}
    ;

/* Specifiers */
Specifier: TYPE                                 { $$ = newTreeNode("Specifier", 1, $1);}
    | StructSpecifier                           { $$ = newTreeNode("Specifier", 1, $1);}
    ;

StructSpecifier: STRUCT OptTag LC DefList RC    { $$ = newTreeNode("StructSpecifier", 5, $1, $2, $3, $4, $5);}
    | STRUCT Tag                                { $$ = newTreeNode("StructSpecifier", 2, $1, $2);}
    ;

OptTag: ID                                      { $$ = newTreeNode("OptTag", 1, $1 );}
    | /*empty*/                                 { $$ = newTreeNode("EMPTY", 0);}
    ;

Tag: ID                                         { $$ = newTreeNode("TAG", 1, $1 );}
    ;

/* Declarators */
VarDec: ID                                      { $$ = newTreeNode("VarDec", 1, $1 );}
    | VarDec LB INT RB                          { $$ = newTreeNode("VarDec", 4, $1, $2, $3, $4);}
    | VarDec LB error RB                        { $$ = newTreeNode("VarDec", 4, $1, $2, $3, $4); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    ;

FunDec: ID LP VarList RP                        { $$ = newTreeNode("FunDec", 4, $1, $2, $3, $4);}
    | ID LP RP                                  { $$ = newTreeNode("FunDec", 3, $1, $2, $3);}
    ;

VarList: ParamDec COMMA VarList                 { $$ = newTreeNode("VarList", 3, $1, $2, $3);}
    | ParamDec                                  { $$ = newTreeNode("VarList", 1, $1);}
    ;

ParamDec: Specifier VarDec                      { $$ = newTreeNode("ParamDec", 2, $1, $2);}
    ;

/* Statements */
CompSt: LC DefList StmtList RC                  { $$ = newTreeNode("CompSt", 4, $1, $2, $3, $4);}
    | error RC                                  { $$ = newTreeNode("CompSt", 2, $1, $2); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    ;

StmtList: Stmt StmtList                         { $$ = newTreeNode("StmtList", 2, $1, $2);}
    | /* empty */                               { $$ = newTreeNode("EMPTY", 0);}
    ;

Stmt: Exp SEMI                                  { $$ = newTreeNode("Stmt", 2, $1, $2);}
    | CompSt                                    { $$ = newTreeNode("Stmt", 1, $1);}
    | RETURN Exp SEMI                           { $$ = newTreeNode("Stmt", 3, $1, $2, $3);}
    | IF LP Exp RP Stmt                         { $$ = newTreeNode("Stmt", 4, $1, $2, $3, $4 );}
    | IF LP Exp RP Stmt ELSE Stmt               { $$ = newTreeNode("Stmt", 7, $1, $2, $3, $4, $5, $6, $7);}
    | WHILE LP Exp RP Stmt                      { $$ = newTreeNode("Stmt", 5, $1, $2, $3, $4, $5);}
    | error SEMI                                { $$ = newTreeNode("Stmt", 2, $1, $2);  ErrorFlag = 1; /*errorTypeB("Syntax error");*/} 
    ;

/* Local Definitions */
DefList: Def DefList                            { $$ = newTreeNode("DefList", 2, $1, $2);}
    | /* empty */                               { $$ = newTreeNode("EMPTY", 0);}
    ;

Def: Specifier DecList SEMI                     { $$ = newTreeNode("Def", 3, $1, $2, $3);}
    | Specifier error SEMI                      { $$ = newTreeNode("Def", 3, $1, $2, $3); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    | Specifier DecList error                   { $$ = newTreeNode("Def", 3, $1, $2, $3); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    | Specifier Dec error                       { $$ = newTreeNode("Def", 3, $1, $2, $3); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    ;

DecList: Dec                                    { $$ = newTreeNode("DecList", 1, $1);}
    | Dec COMMA DecList                         { $$ = newTreeNode("DecList", 3, $1, $2, $3);}
    ;

Dec:  VarDec                                    { $$ = newTreeNode("Dec", 1, $1);}
    | VarDec ASSIGNOP Exp                       { $$ = newTreeNode("Dec", 3, $1, $2, $3);}
    ;

/* Expressions */
Exp:  Exp ASSIGNOP Exp                          { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp AND Exp                               { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp OR Exp                                { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp RELOP Exp                             { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp PLUS Exp                              { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp MINUS Exp                             { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp STAR Exp                              { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp DIV Exp                               { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | LP Exp RP                                 { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | MINUS Exp                                 { $$ = newTreeNode("Exp", 2, $1, $2);}
    | NOT Exp                                   { $$ = newTreeNode("Exp", 2, $1, $2);}
    | ID LP Args RP                             { $$ = newTreeNode("Exp", 4, $1, $2, $3, $4);}
    | ID LP RP                                  { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | Exp LB Exp RB                             { $$ = newTreeNode("Exp", 4, $1, $2, $3, $4);}
    | Exp DOT ID                                { $$ = newTreeNode("Exp", 3, $1, $2, $3);}
    | ID                                        { $$ = newTreeNode("Exp", 1, $1);}
    | INT                                       { $$ = newTreeNode("Exp", 1, $1);}
    | FLOAT                                     { $$ = newTreeNode("Exp", 1, $1);}
    | ID LP error RP                            { $$ = newTreeNode("Exp", 4, $1, $2, $3, $4); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    | Exp LB error RB                           { $$ = newTreeNode("Exp", 4, $1, $2, $3, $4); ErrorFlag = 1; /*errorTypeB("Missing \"[\"");*/}
    | error RP                                  { $$ = newTreeNode("Exp", 2, $1, $2); ErrorFlag = 1; /*errorTypeB("Syntax error");*/}
    ;

Args: Exp COMMA Args                            { $$ = newTreeNode("Args", 3, $1, $2, $3);}
    | Exp                                       { $$ = newTreeNode("Args", 1, $1); }
    ;


%%

void yyerror(char *msg) {
    errorTypeB(msg);
}

void errorTypeB(char * msg) {
    printf("Error type \033[31mB\033[0m at Line \033[31m%d\033[0m: %s\n", yylineno, msg);
}
