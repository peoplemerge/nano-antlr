grammar Nanob;

prog:	stat+;

	stat: 
	
	{CONST_DECL}* | {VAR_DECL}* | {PROC_DECL}* | BEGIN STATEMENT {STATEMENT}* END SEMICOLON;
	
STATEMENT
	:  BLOCK | PRINT | READ | ASSIGN | CONDITIONAL | FOR | RETURN | CALL;
	
BLOCK
	:	BEGIN {CONST_DECL}*  {VAR_DECL}* {STATEMENT}* END;
	
CONST_DECL
	: 'const' ID {COMMA ID}* = 'int_const';
	
VAR_DECL
	: 'var' ID {COMMA ID}* SEMICOLON SCALAR_TYPE
	| 'var' ID {INT}? {COMMA ID {INT}?}}* SCALAR_TYPE;
	
PROC_DECL
	: PROCEDURE ID LPAREN {FORMAL {SEMICOLON FORMAL}*}? RPAREN SEMICOLON BLOCK;
	
SCALAR_TYPE
	: INTEGER | BOOLEAN;

	
CONDITIONAL
	:	'if' LPAREN BOOL_EXPR RPAREN 'then' STATEMENT {else <STATEMENT}?;
	
PRINT
	: 'print' LPAREN STRING RPAREN SEMICOLON | 'print' LPAREN STRING RPAREN SEMICOLON;
	
READ
	: 'read' LPAREN STRING {COMMA INPUT_TARGET}* RPAREN SEMICOLON;
	
INPUT_TARGET
	:	ID | ID {INT_EXPR}? SEMICOLON;

ASGN
	:	ID ASSIGN EXPR | ID {INT_EXPR}* ASSIGN EXPR;
	
EXPR
	: INT_EXPR | BOOL_EXPR;
	
COND
	:	'if' LPAREN BOOL_EXPR RPAREN 'then' STATEMENT {'else' STATEMENT}*;

FOR
	:	'for' ID ASSIGN INT_EXPR 'to' INT_EXPR 'do' STATEMENT;
	
	
BOOLEAN_PRIMITIVE
	: BOOLEAN_PRIMITIVE 'or' BOOL_TERM | BOOL_TERM	;

BOOL_EXPR
  :	 'not' BOOLEAN_PRIMITIVE;
  
BOOL_TERM
	: BOOL_TERM 'and' BOOL_FACTOR | BOOL_FACTOR;
	
BOOL_FACTOR
	: BOOL_CONST | VALUE | INT_EXPR RELOP INT_EXPR | LPAREN BOOL_EXPR RPAREN;
	
CALL
	:	'call' ID LPAREN {EXPR {COMMA EXPR}*}? RPAREN;

INT_EXPR
	: INT_PRIM;
	
INT_PRIM
	: INT_PRIM PLUS INT_TERM |  INT_PRIM MINUS INT_TERM | INT_TERM;
	
INT_TERM
	:  INT_TERM MULTIPLY INT_FACTOR | INT_TERM DIVIDE INT_FACTOR  | INT_FACTOR;
	
INT_FACTOR
	: 'int_const'| VALUE | LPAREN INT_EXPR RPAREN;  


NEWLINE	:	'\r'? '\n';


BOOLEAN_CONST :	
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

//Keywords

BEGIN
	:	'begin';
	
END
	: 'end';

INTEGER
	:	'integer';
	
BOOLEAN
	: 'boolean';

PROCEDURE
	:	'procedure';

RETURN
	:	 'return';

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
	