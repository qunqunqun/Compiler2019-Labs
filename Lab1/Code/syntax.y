%{

#include "GramTree.h"
#include "common.h"
#include "lex.yy.c"

extern int yylex();
extern int yylineno;

%}

%union {
    struct GramTree* node_type;
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
%type <type_ast> CompSt StmtList Stmt                       /* Statements */
%type <type_ast> DefList Def DecList Dec                    /* Loacal Definitions */
%type <type_ast> Exp Args                                   /* Expressions */

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
Program: ExtDefList                 {}
    ;

ExtDefList: ExtDef ExtDefList       {}
    | /*empty*/                     {}
    ;

ExtDef: Specifier ExtDecList SEMI  {}
    | Specifier SEMI               {}
    | Specifier FunDec CompSt      {}
    ;

ExtDecList: VarDec                  {}
    | VarDec COMMA ExtDecList       {}
    ;

/* Specifiers */
Specifier: TYPE                                 { }
    | StructSpecifier                           { }
    ;

StructSpecifier: STRUCT OptTag LC DefList RC    { }
    | STRUCT Tag                                { }
    ;

OptTag: ID                                      { }
    | /*empty*/                                 { }
    ;

Tag: ID                                         { }
    ;

/* Declarators */
VarDec: ID                                      { }
    | VarDec LB INT RB                          { }
    ;

FunDec: ID LP VarList RP                        { }
    | ID LP RP                                  { }
    ;

VarList: ParamDec COMMA VarList                 { }
    | ParamDec                                  { }
    ;

ParamDec: Specifier VarDec                      { }
    ;

/* Statements */
CompSt: LC DefList StmtList RC                  { }
    ;

StmtList: Stmt StmtList                         { }
    | /* empty */                               { }
    ;

Stmt: Exp SEMI                                  { }
    | CompSt                                    { }
    | RETURN Exp SEMI                           { }
    | IF LP Exp RP Stmt                         { }
    | IF LP Exp RP Stmt ELSE Stmt               { }
    ;

/* Local Definitions */
DefList: Def DefList                            { }
    | /* empty */                               { }
    ;

Def: Specifier DecList SEMI                     { }
    | Specifier error SEMI                      { }
    | Specifier DecList error                   { }
    | Specifier Dec error                       { }
    ;

DecList: Dec                                    { }
    | Dec COMMA DecList                         { }
    ;

Dec:  VarDec                                    { }
    | VarDec ASSIGNOP Exp                       { }
    ;

/* Expressions */
Exp:  Exp ASSIGNOP Exp                          { }
    | Exp AND Exp                               { }
    | Exp OR Exp                                { }
    | Exp RELOP Exp                             { }
    | Exp PLUS Exp                              { }
    | Exp MINUS Exp                             { }
    | Exp STAR Exp                              { }
    | Exp DIV Exp                               { }
    | LP Exp RP                                 { }
    | MINUS Exp                                 { }
    | NOT Exp                                   { }
    | ID LP Args RP                             { }
    | ID LP RP                                  { }
    | Exp LB Exp RB                             { }
    | Exp DOT ID                                { }
    | ID                                        { }
    | INT                                       { }
    | FLOAT                                     { }
    | ID LP error RP                            { }
    | Exp LB error RB                           {  }
    ;

Args: Exp COMMA Args                            { }
    | Exp                                       { }
    ;


%%

void yyerror(char *msg) {
    // TODO: rewrite report error
}
