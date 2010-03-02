grammar nano;



prog	:	stat+;

stat	:	ID '=' BOOLEAN ';' NEWLINE
	|	ID '=' expr ';' NEWLINE
	|	ID '=' STRING ';' NEWLINE
	|	NEWLINE;

NEWLINE	:	'\r'? '\n';

expr	:	multExpr(('+'|'-') multExpr)*;

multExpr:	atom('*' atom)*;

atom	:	INT|ID|'(' expr ')';


BOOLEAN :	('true'
	|	'false');

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

INT :	'0'..'9'+
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;

STRING
    :  '"' (~('\\'|'"') )* '"'
    ;

COMMA 
	:','
	; 
   
 SEMICOLON
	:
	';'
	;

COLON
	:
	':'
	;
   	
LPAREN
	:
	'('
	;
	
RPAREN
	:
	')'
	;
	
PLUS
	:
	'+'
	;
	
MINUS
	:
	'-'
	;	
	
MULTIPLY
	:
	'*'
	;

DIVIDE
	:
	'/'
	;

LSQUAREBRACKET
	:
	'['
	;
	
RSQUAREBRACKET
	:
	']'
	;
	
ASSIGN
	:
	':='
	;

COMPARISON
	:'='
	;

NOTEQUALS
	:'<>'
	;
	
LESSTHAN
	:'<'
	;
	
LESSTHANEQUAL
	:'<='
	;
	
GREATERTHAN
	:'>'
	;
				

GREATERTHANEQUAL
	:'>='
	;
