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

single		\/\/.*
multiStart \/\*
multiEnd	\*\/

WrongOct 	0{digit_8}*[89]{digit_10}*
WrongHex	0[Xx]{digit_16}*[g-zG-Z]{digit_16}*
exphd		{Dec}|{float}
WrongFloat	([Ee][+-]?{exphd})|({exphd}[Ee][+-]?)|({exphd}[Ee][+-]?{float})

%%
{INT} 			{ printf("Recognize Interger : %s\n",yytext); return INT; }
{FLOAT} 		{ printf("Recognize FLOAT : %s\n",yytext); return FLOAT; }


{STRUCT}		{ printf("Recognize STRUCT : %s\n",yytext); return STRUCT; }
{RETURN}		{ printf("Recognize RETURN : %s\n",yytext); return RETURN; }
{IF}			{ printf("Recognize IF : %s\n",yytext); return IF; }
{ELSE} 			{ printf("Recognize ELSE : %s\n",yytext); return ELSE;}
{WHILE}			{ printf("Recognize WHILE : %s\n",yytext); return WHILE; }

{ID}			{ printf("Recognize ID : %s\n",yytext); return ID;}

{ws}        	{}

{SEMI}			{ printf("Recognize ; : %s \n",yytext); return SEMI; }
{COMMA}			{ printf("Recognize , : %s \n",yytext); return COMMA; }
{ASSIGNOP}		{ printf("Recognize = : %s \n",yytext); return ASSIGNOP; }
{RELOP}			{ printf("Recognize RELOP:%s\n",yytext); return RELOP; }
{PLUS}			{ printf("Recognize + : %s \n",yytext); return PLUS; }
{MINUS}			{ printf("Recognize - : %s \n",yytext); return MINUS; }
{STAR}			{ printf("Recognize * : %s \n",yytext); return STAR; }
{DIV}			{ printf("Recognize / : %s \n",yytext); return DIV;}
{AND}			{ printf("Recognize && : %s \n",yytext); return AND;}
{OR}			{ printf("Recognize || : %s \n",yytext); return OR;}
{DOT}			{ printf("Recognize . : %s \n",yytext); return DOT;}


{LP}        	{ printf("Recognize %s \n",yytext); return LP; }
{RP}        	{ printf("Recognize %s \n",yytext); return RP; }
{LB}        	{ printf("Recognize %s \n",yytext); return LB; }
{RB}        	{ printf("Recognize %s \n",yytext); return RB; }
{LC}        	{ printf("Recognize %s \n",yytext); return LC; }
{RC}        	{ printf("Recognize %s \n",yytext); return RC; }

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


