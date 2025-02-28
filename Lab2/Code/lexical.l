%{
	#include <string.h>
	#include "syntax.tab.h"
	#include "common.h"

	
	//#define LEX_DEBUG
	void debug(char *msg) {
	#ifdef YY_DEBUG
        printf("%d: %s: %s\n", yylineno, msg, yytext);
	#endif
}
%}

%option yylineno
%x CONTENT 

digit_8		[0-7]
digit_10	[0-9]
digit_16	[0-9A-Fa-f]
Dec 		[1-9]{digit_10}*|0

float 		[+-]?({digit_10}*[.]{digit_10}+|{digit_10}+[.])

INT			{Dec}
FLOAT		{float}

letter		[_A-Za-z]
ID			{letter}({letter}|{digit_10})*

TYPE		int|float
STRUCT		struct
RETURN		return
IF			if
ELSE 		else
WHILE		while

delim      	[ \n\t\f\r\v]
ws			{delim}+

SEMI		;
COMMA		,
ASSIGNOP	=
RELOP		>|<|>=|<=|==|!=
PLUS		\+
MINUS		-
STAR		\*
DIV			\/
AND			&&
OR			\|\|
DOT			\.
NOT			!

LP         	\(
RP          \)
LB          \[
RB          \]
LC          \{
RC          \}

single		\/\/
multiStart \/\*
multiEnd	\*\/


%%
{INT} 			{ 
	debug(yytext);
	yylval.node_type = newTreeNode("INT",0,yylineno);
	GramTree* node = yylval.node_type;
	// val.a is int type
	if(yytext[1] == 'x' || yytext[1] == 'X'){
		sscanf(yytext, "%x", &node->val.a);		
	}else{
		node->val.a = atoi(yytext);
	}

	return INT; 
}

{FLOAT} 		{ 
	debug(yytext);
	yylval.node_type = newTreeNode("FLOAT",0,yylineno);
	GramTree* node = yylval.node_type;
	node->val.b = atof(yytext);
	return FLOAT; 
}


{TYPE}      { 
	debug(yytext);
	yylval.node_type = newTreeNode("TYPE",0,yylineno);
	GramTree* node = yylval.node_type;
	strcpy(node->val.str, yytext);
	return TYPE;
}

{STRUCT}		{ debug(yytext); 	yylval.node_type = newTreeNode("STRUCT",0,yylineno);	return STRUCT; }
{RETURN}		{ debug(yytext); 	yylval.node_type = newTreeNode("RETURN",0,yylineno);	return RETURN; }
{IF}			{ debug(yytext); 	yylval.node_type = newTreeNode("IF",0,yylineno);	return IF; }
{ELSE} 			{ debug(yytext); 	yylval.node_type = newTreeNode("ELSE",0,yylineno);	return ELSE;}
{WHILE}			{ debug(yytext); 	yylval.node_type = newTreeNode("WHILE",0,yylineno);	return WHILE; }


{ID}      { 
	debug(yytext);
	yylval.node_type = newTreeNode("ID",0,yylineno);
	GramTree* node = yylval.node_type;
	strcpy(node->val.str, yytext);
	return ID;
}


{ws}        	{}

{SEMI}			{ debug(yytext); yylval.node_type = newTreeNode("SEMI",0,yylineno);	return SEMI; }
{COMMA}			{ debug(yytext); yylval.node_type = newTreeNode("COMMA",0,yylineno);	return COMMA; }
{ASSIGNOP}		{ debug(yytext); yylval.node_type = newTreeNode("ASSIGNOP",0,yylineno);	return ASSIGNOP; }
{RELOP}			{ debug(yytext); yylval.node_type = newTreeNode("RELOP",0,yylineno);	return RELOP; }
{PLUS}			{ debug(yytext); yylval.node_type = newTreeNode("PLUS",0,yylineno);	return PLUS; }
{MINUS}			{ debug(yytext); yylval.node_type = newTreeNode("MINUS",0,yylineno);	return MINUS; }
{STAR}			{ debug(yytext); yylval.node_type = newTreeNode("STAR",0,yylineno);	return STAR; }
{DIV}			{ debug(yytext); yylval.node_type = newTreeNode("DIV",0,yylineno);	return DIV;}
{AND}			{ debug(yytext); yylval.node_type = newTreeNode("AND",0,yylineno);	return AND;}
{OR}			{ debug(yytext); yylval.node_type = newTreeNode("OR",0,yylineno);	return OR;}
{DOT}			{ debug(yytext); yylval.node_type = newTreeNode("DOT",0,yylineno);	return DOT;}
{NOT}			{ debug(yytext); yylval.node_type = newTreeNode("NOT",0,yylineno);	return NOT;}


{LP}        	{ debug(yytext); yylval.node_type = newTreeNode("LP",0,yylineno);	return LP; }
{RP}        	{ debug(yytext); yylval.node_type = newTreeNode("RP",0,yylineno);	return RP; }
{LB}        	{ debug(yytext); yylval.node_type = newTreeNode("LB",0,yylineno);	return LB; }
{RB}        	{ debug(yytext); yylval.node_type = newTreeNode("RB",0,yylineno);	return RB; }
{LC}        	{ debug(yytext); yylval.node_type = newTreeNode("LC",0,yylineno);	return LC; }
{RC}        	{ debug(yytext); yylval.node_type = newTreeNode("RC",0,yylineno);	return RC; }

.           	{ ErrorFlag = 1; printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Myterious characters \'%s\'\n", yylineno, yytext); }
s
{single} {
	char c = input();
	while (c != '\n') c = input();
}

{multiStart} {  BEGIN CONTENT; }
<CONTENT>[^*\n]* {  }
<CONTENT>"*"+[^*/\n]* { }
<CONTENT>\n {   }
<CONTENT>"*"+"/" {  BEGIN INITIAL;}
<CONTENT><<EOF>> {
	ErrorFlag = 1;
	printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: EOF \'\'\n", yylineno);
	BEGIN INITIAL;
}

{multiEnd} {
	ErrorFlag = 1;
	printf("Error type \033[31mB\033[0m at Line \033[31m%d\033[0m: Syntax error \' multi annotation \*\/ \'\n", yylineno);
}


%%


