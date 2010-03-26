grammar Nano;

options{
	 backtrack=true;
}

//Keywords
RETURN:	'return' SEMICOLON;
BEGIN: 'begin';
END: 'end';
CONST: 'const';
VAR: 'var';
TRUE: 'true';
FALSE: 'false';
PROCEDURE: 'procedure';
INTEGER: 'integer';
BOOLEAN: 'boolean';
PRINT: 'print';
READ: 'read';
IF: 'if';
THEN: 'then';
ELSE: 'else';
CALL: 'call';
AND: 'and';
OR: 'or';
NOT: 'not';

//Tokens
ID: ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
COMMENT: '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
	|    '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;};
  
WS: ( ' '| '\t' | '\r' | '\n' ) {$channel=HIDDEN;};
NEWLINE: '\r'? '\n';
INT_CONST: '0'..'9'+;
STRING: '"' (~('\\'|'"') )* '"';

COMMA : ','; 
SEMICOLON: ';';
COLON: ':'; 	
LPAREN: '(';
RPAREN: ')';
PLUS: '+';
MINUS: '-';	
MULTIPLY: '*';
DIVIDE: '/';
LSQBRACKET: '[';	
RSQBRACKET: ']';	
ASSIGN:	':=';
EQUALS: '=';
NOTEQUALS: '<>';
LESSTHAN:	'<';
LESSTHANEQUAL: '<=';
GREATERTHAN: '>';				
GREATERTHANEQUAL:  '>=';

prog:	stat+;

stat:  
	(const_decl)*  (var_decl)*   (proc_decl)* (COMMENT)* BEGIN statement (statement)* END SEMICOLON;
	
statement:
	block | print | read | asgn | cond | forloop | call| RETURN;

//Declarations

const_decl:
	 CONST ID (COMMA ID)* EQUALS INT_CONST SEMICOLON;

var_decl:
	 VAR ID (COMMA ID)* COLON scalar_type SEMICOLON
	|  VAR ID LSQBRACKET INT_CONST RSQBRACKET  ( COMMA ID LSQBRACKET INT_CONST RSQBRACKET )* COLON scalar_type SEMICOLON ;

proc_decl:
	 PROCEDURE ID LPAREN (formal (SEMICOLON formal)?)* RPAREN SEMICOLON block;
	 
formal:
	ID ( COMMA ID )* COLON scalar_type;
	
scalar_type:
	INTEGER | BOOLEAN;
	
block:
	BEGIN (const_decl)* (var_decl)* (statement)* END SEMICOLON;	
		
print:
	PRINT LPAREN STRING (COMMA expr)* RPAREN SEMICOLON;
	
read:
	READ LPAREN STRING (COMMA input_target)* RPAREN SEMICOLON;
	
input_target:
	ID | ID LSQBRACKET expr RSQBRACKET;
	
asgn:
	ID ASSIGN expr SEMICOLON | ID  LSQBRACKET expr RSQBRACKET ASSIGN expr SEMICOLON;

cond:
	IF expr THEN statement LSQBRACKET ELSE statement RSQBRACKET; 	

forloop:
	'for' ID ASSIGN expr 'to' expr 'do' statement; 	

call:
	CALL ID LPAREN (expr (COMMA expr)*)? RPAREN SEMICOLON;

expr:
	(term) (PLUS term | MINUS term | OR term)*;

term:
	(factor) (MULTIPLY factor | DIVIDE factor | AND factor)*;

factor:
	MINUS prim | NOT prim | prim;

prim:
	INT_CONST | (TRUE | FALSE) | value  | LPAREN expr RPAREN | LPAREN expr relop expr RPAREN; 

value:
	ID | ID LSQBRACKET expr RSQBRACKET ;
 
relop:
	EQUALS | LESSTHAN | GREATERTHAN | LESSTHANEQUAL | GREATERTHANEQUAL | NOTEQUALS;
	