%{
#include <stdio.h>                                                             //header file for I/O related functions
#include "y.tab.h"                                                             //header file make the token declarations accessible
void yyerror(const char *s);                                                   //displays a text string argument using fprintf
%}                                  

Knostar [^*]*                                                                 //handle single line or multiple line comments
Nostarfwd [^*/]
Pstar [\*]+
alpha [A-Za-z]                                                                //Auxiliary definitions
digit [0-9]

%%
"/*"{Knostar}{Pstar}({Nostarfwd}{Knostar}{Pstar})*"/"   ;
"//".*                                                  ;
public  						return PUBLIC;
interface						return INTERFACE;                            //Translation Rules
void							return VOID;
extends                         return EXTENDS;
int|float|char|String			return TYPE;
{alpha}({alpha}|{digit})*		return IDENTIFIER;
"{"								return CURLY_OPEN;
"}"								return CURLY_CLOSE;
"("								return ROUND_OPEN;
")"								return ROUND_CLOSE;
";"								return SEMICOLON;
[ \t\n]+						/* ignore whitespace */;
.								return *yytext;
%%


int yywrap(){                                                             //function is called by lex when input is exhausted
	return 1;                                                             //return 1 if we are done
}

