grammar calculator;

prog	:	stat+;

stat	:	expr NEWLINE
	|	ID '=' expr NEWLINE
	|	NEWLINE;

expr	:	multExpr(('+'|'-') multExpr)*;

multExpr:	atom('*' atom)*;

atom	:	INT|ID|'(' expr ')';

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;

NEWLINE	:	'\r'? '\n';

INT :	'0'..'9'+ ;

WS	:	(' ' | '\t' | '\n' | '\r')+ {skip();} ;
