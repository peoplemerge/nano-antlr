grammar Nano;

prog	:	stat+;

	stat: BEGIN END
	| BEGIN PRINT END
	;
	
BEGIN 
	:	'begin' | 'begin' NEWLINE;
	
END
	: 'end' SEMICOLON | 'end' SEMICOLON NEWLINE ;
	
PRINT
	: 'print' LPAREN STRING RPAREN SEMICOLON | 'print' LPAREN STRING RPAREN SEMICOLON NEWLINE;
	

NEWLINE	:	'\r'? '\n';


BOOLEAN :	
	('true' | 'false');

ID  :	('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
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
	: ','; 
   
 SEMICOLON
	:	';';

COLON
	: ':';
   	
LPAREN
	: '(';
	
RPAREN
	: ')';
	
PLUS
	: '+';
	
MINUS
	:	'-';	
	
MULTIPLY
	:	'*';

DIVIDE
	:	'/';

LSQUAREBRACKET
	:	'[';
	
RSQUAREBRACKET
	: ']';
	
ASSIGN
	:	':=';

COMPARISON
	: '=';

NOTEQUALS
	: '<>';
	
LESSTHAN
	: '<';
	
LESSTHANEQUAL
	: '<=';
	
GREATERTHAN
	: '>';				

GREATERTHANEQUAL
	: '>=';