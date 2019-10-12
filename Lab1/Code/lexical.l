%{
	#include <string.h>
	#include "syntax.tab.h"
	#include "common.h"
%}

%option yylineno
%x CONTENT 

digit_8		[0-7]
digit_10	[0-9]
digit_16	[0-9A-Fa-f]
Oct			0{digit_8}+
Dec 		[1-9]{digit_10}*|0
Hex 		0[Xx]{digit_16}+

float 		[+-]?({digit_10}*[.]{digit_10}+|{digit_10}+[.])
exp 		({float})[Ee][+-]?{digit_10}+

INT			{Oct}|{Dec}|{Hex}
FLOAT		{float}|{exp}

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

WrongOct 	0{digit_8}*[89]{digit_10}*
WrongHex	0[Xx]{digit_16}*[g-zG-Z]{digit_16}*
exphd		{Dec}|{float}
WrongFloat	([Ee][+-]?{exphd})|({exphd}[Ee][+-]?)|({exphd}[Ee][+-]?{float})

%%
{INT} 			{ 
	printf("Match Interger : %s\n",yytext);
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
	printf("Match FLOAT : %s\n",yytext); 
	yylval.node_type = newTreeNode("FLOAT",0,yylineno);
	GramTree* node = yylval.node_type;
	node->val.b = atof(yytext);
	return FLOAT; 
}


{TYPE}      { 
	printf("Match TYPE : %s\n",yytext);
	yylval.node_type = newTreeNode("TYPE",0,yylineno);
	GramTree* node = yylval.node_type;
	strcpy(node->val.str, yytext);
	return TYPE;
}

{STRUCT}		{ printf("Match STRUCT : %s\n",yytext); yylval.node_type = newTreeNode("STRUCT",0,yylineno);	return STRUCT; }
{RETURN}		{ printf("Match RETURN : %s\n",yytext); yylval.node_type = newTreeNode("RETURN",0,yylineno);	return RETURN; }
{IF}			{ printf("Match IF : %s\n",yytext); 	yylval.node_type = newTreeNode("IF",0,yylineno);	return IF; }
{ELSE} 			{ printf("Match ELSE : %s\n",yytext); 	yylval.node_type = newTreeNode("ELSE",0,yylineno);	return ELSE;}
{WHILE}			{ printf("Match WHILE : %s\n",yytext); 	yylval.node_type = newTreeNode("WHILE",0,yylineno);	return WHILE; }


{ID}      { 
	printf("Match ID : %s\n",yytext);
	yylval.node_type = newTreeNode("ID",0,yylineno);
	GramTree* node = yylval.node_type;
	strcpy(node->val.str, yytext);
	return ID;
}


{ws}        	{}

{SEMI}			{ printf("Match ; : %s \n",yytext); yylval.node_type = newTreeNode("SEMI",0,yylineno);	return SEMI; }
{COMMA}			{ printf("Match , : %s \n",yytext); yylval.node_type = newTreeNode("COMMA",0,yylineno);	return COMMA; }
{ASSIGNOP}		{ printf("Match = : %s \n",yytext); yylval.node_type = newTreeNode("ASSIGNOP",0,yylineno);	return ASSIGNOP; }
{RELOP}			{ printf("Match RELOP:%s\n",yytext); yylval.node_type = newTreeNode("RELOP",0,yylineno);	return RELOP; }
{PLUS}			{ printf("Match + : %s \n",yytext); yylval.node_type = newTreeNode("PLUS",0,yylineno);	return PLUS; }
{MINUS}			{ printf("Match - : %s \n",yytext); yylval.node_type = newTreeNode("MINUS",0,yylineno);	return MINUS; }
{STAR}			{ printf("Match * : %s \n",yytext); yylval.node_type = newTreeNode("STAR",0,yylineno);	return STAR; }
{DIV}			{ printf("Match / : %s \n",yytext); yylval.node_type = newTreeNode("DIV",0,yylineno);	return DIV;}
{AND}			{ printf("Match && : %s \n",yytext); yylval.node_type = newTreeNode("AND",0,yylineno);	return AND;}
{OR}			{ printf("Match || : %s \n",yytext); yylval.node_type = newTreeNode("OR",0,yylineno);	return OR;}
{DOT}			{ printf("Match . : %s \n",yytext); yylval.node_type = newTreeNode("DOT",0,yylineno);	return DOT;}


{LP}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("LP",0,yylineno);	return LP; }
{RP}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("RP",0,yylineno);	return RP; }
{LB}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("LB",0,yylineno);	return LB; }
{RB}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("RB",0,yylineno);	return RB; }
{LC}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("LC",0,yylineno);	return LC; }
{RC}        	{ printf("Match %s \n",yytext); yylval.node_type = newTreeNode("RC",0,yylineno);	return RC; }

{WrongOct}		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Octal \'%s\'\n", yylineno, yytext); }
{WrongHex}		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Hexadecimal \'%s\'\n", yylineno, yytext); }
{WrongFloat}	{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Float \'%s\'\n", yylineno, yytext); }
.           	{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Myterious characters \'%s\'\n", yylineno, yytext); }

{single} {
	char c = input();
	while (c != '\n') c = input();
}

{multiStart} { BEGIN CONTENT; }
<CONTENT>[^*\n]* {}
<CONTENT>"*"+[^*/\n]* {}
<*>\n {}
<CONTENT>"*/" { BEGIN INITIAL;}
<CONTENT><<EOF>> {
	printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: EOF \'\'\n", yylineno);
	BEGIN INITIAL;
}

{multiEnd} {
	printf("Error type \033[31mB\033[0m at Line \033[31m%d\033[0m: Syntax error \'\'\n", yylineno);
}


%%


