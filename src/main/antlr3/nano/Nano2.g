grammar Nano2;

options{
	language = Java;
	backtrack = true;
	output = AST;
	ASTLabelType = CommonTree;
}

@header{
	package nano;
	import nano.evaluators.*;
}

@lexer::header{
	package nano;
	import nano.evaluators.*;
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
FOR: 'for';
TO: 'to';
DO: 'do';

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

/*

prog:	stat+ {System.out.println("Reduced by rule prog");};

stat:  
	(const_decl)*  (var_decl)*   (proc_decl)* (COMMENT)* BEGIN statement (statement)* END SEMICOLON {System.out.println("Reduced by rule stat");};
	
statement:
	block | print | read | asgn | cond | forloop | call| RETURN {System.out.println("Reduced by rule statement");};

//Declarations

const_decl:
	 CONST ID (COMMA ID)* EQUALS INT_CONST SEMICOLON {System.out.println("Reduced by rule const_decl");};

proc_decl:
	 PROCEDURE ID LPAREN (formal (SEMICOLON formal)?)* RPAREN SEMICOLON block {System.out.println("Reduced by proc_decl");};
	 
formal:
	ID ( COMMA ID )* COLON scalar_type {System.out.println("Reduced by rule formal");};
	
block:
	BEGIN (const_decl)* (var_decl)* (statement)* END SEMICOLON {System.out.println("Reduced by rule block");};	
		
print:
	PRINT LPAREN STRING (COMMA expr)* RPAREN SEMICOLON {System.out.println("Reduced by rule print");};
	
read:
	READ LPAREN STRING (COMMA input_target)* RPAREN SEMICOLON {System.out.println("Reduced by rule read");};
	
input_target:
	ID | ID LSQBRACKET expr RSQBRACKET {System.out.println("Reduced by rule input_target");};
	
cond:
	IF expr THEN statement (LSQBRACKET ELSE statement RSQBRACKET)* {System.out.println("Reduced by rule asgn");};

forloop:
	'for' ID ASSIGN expr 'to' expr 'do' statement {System.out.println("Reduced by rule forloop");}; 	

call:
	CALL ID LPAREN (expr (COMMA expr)*)? RPAREN SEMICOLON {System.out.println("Reduced by rule call");};

*/

prog :	
	(var_decl)*
	expr 
;

var_decl:
	 VAR ID (COMMA ID)* COLON scalar_type SEMICOLON 
//	|  VAR ID LSQBRACKET INT_CONST RSQBRACKET  ( COMMA ID LSQBRACKET INT_CONST RSQBRACKET )* COLON scalar_type SEMICOLON 
;

scalar_type:
	INTEGER | BOOLEAN 
;
	

asgn:
	ID ASSIGN expr SEMICOLON 
	| ID  LSQBRACKET expr RSQBRACKET ASSIGN expr SEMICOLON
;

expr:
	(term) (PLUS^ term | MINUS^ term | OR^ term)* 
;

term:
	(factor) (MULTIPLY^ factor | DIVIDE^ factor | AND^ factor)* 
;
	
factor:
	MINUS^ prim | NOT^ prim | prim 
;

prim:
	INT_CONST | (TRUE | FALSE) | value  | LPAREN expr RPAREN | LPAREN expr relop^ expr RPAREN 
; 

value:
	ID | ID LSQBRACKET expr RSQBRACKET 
;
 
relop:
	EQUALS | LESSTHAN | GREATERTHAN | LESSTHANEQUAL | GREATERTHANEQUAL | NOTEQUALS 
;
	
