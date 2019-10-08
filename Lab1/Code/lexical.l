%option yylineno

%{


%}

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

WrongOct 	0{digit_8}*[89]{digit_10}*
WrongHex	0[Xx]{digit_16}*[g-zG-Z]{digit_16}*
exphd		{Dec}|{float}
WrongFloat	([Ee][+-]?{exphd})|({exphd}[Ee][+-]?)|({exphd}[Ee][+-]?{float})

%%
{INT} 			{ printf("Recognize Interger : %s\n",yytext); }
{FLOAT} 		{ printf("Recognize FLOAT : %s\n",yytext); }


{STRUCT}		{ printf("Recognize STRUCT : %s\n",yytext); }
{RETURN}		{ printf("Recognize RETURN : %s\n",yytext); }
{IF}			{ printf("Recognize IF : %s\n",yytext); }
{ELSE} 			{ printf("Recognize ELSE : %s\n",yytext); }
{WHILE}			{ printf("Recognize WHILE : %s\n",yytext); }

{ID}			{ printf("Recognize ID : %s\n",yytext);}

{ws}        	{ /* take no action */ }

{SEMI}			{ printf("Recognize ; : %s \n",yytext); }
{COMMA}			{ printf("Recognize , : %s \n",yytext); }
{ASSIGNOP}		{ printf("Recognize = : %s \n",yytext); }
{RELOP}			{ printf("Recognize RELOP:%s\n",yytext); }
{PLUS}			{ printf("Recognize + : %s \n",yytext); }
{MINUS}			{ printf("Recognize - : %s \n",yytext); }
{STAR}			{ printf("Recognize * : %s \n",yytext); }
{DIV}			{ printf("Recognize / : %s \n",yytext); }
{AND}			{ printf("Recognize && : %s \n",yytext); }
{OR}			{ printf("Recognize || : %s \n",yytext); }
{DOT}			{ printf("Recognize \. : %s \n",yytext); }
{NOT}			{ printf("Recognize !  : %s \n",yytext); }
{LP}        		{ printf("Recognize \( : %s \n",yytext); }
{RP}        		{ printf("Recognize \) : %s \n",yytext); }
{LB}        		{ printf("Recognize \[ : %s \n",yytext); }
{RB}        		{ printf("Recognize \] : %s \n",yytext); }
{LC}        		{ printf("Recognize \{ : %s \n",yytext); }
{RC}        		{ printf("Recognize \} : %s \n",yytext); }

{WrongOct}		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Octal \'%s\'\n", yylineno, yytext); }
{WrongHex}		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Hexadecimal \'%s\'\n", yylineno, yytext); }
{WrongFloat}		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Wrong Float \'%s\'\n", yylineno, yytext); }
.           		{ printf("Error type \033[31mA\033[0m at Line \033[31m%d\033[0m: Myterious characters \'%s\'\n", yylineno, yytext); }
%%

