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

prog:	stat+ {System.out.println("Reduced by rule prog");};

stat:  
	(const_decl)*  (var_decl)*   (proc_decl)* (COMMENT)* BEGIN statement (statement)* END SEMICOLON {System.out.println("Reduced by rule stat");};
	
statement:
	block | print | read | asgn | cond | forloop | call| RETURN {System.out.println("Reduced by rule statement");};

//Declarations

const_decl:
	 CONST ID (COMMA ID)* EQUALS INT_CONST SEMICOLON {System.out.println("Reduced by rule const_decl");};

var_decl:
	 VAR ID (COMMA ID)* COLON scalar_type SEMICOLON {System.out.println("Reduced by var_decl");}
	|  VAR ID LSQBRACKET INT_CONST RSQBRACKET  ( COMMA ID LSQBRACKET INT_CONST RSQBRACKET )* COLON scalar_type SEMICOLON {System.out.println("Reduced by var_decl");};

proc_decl:
	 PROCEDURE ID LPAREN (formal (SEMICOLON formal)?)* RPAREN SEMICOLON block {System.out.println("Reduced by proc_decl");};
	 
formal:
	ID ( COMMA ID )* COLON scalar_type {System.out.println("Reduced by rule formal");};
	
scalar_type:
	INTEGER | BOOLEAN {System.out.println("Reduced by rule scalar_type");};
	
block:
	BEGIN (const_decl)* (var_decl)* (statement)* END SEMICOLON {System.out.println("Reduced by rule block");};	
		
print:
	PRINT LPAREN STRING (COMMA expr)* RPAREN SEMICOLON {System.out.println("Reduced by rule print");};
	
read:
	READ LPAREN STRING (COMMA input_target)* RPAREN SEMICOLON {System.out.println("Reduced by rule read");};
	
input_target:
	ID | ID LSQBRACKET expr RSQBRACKET {System.out.println("Reduced by rule input_target");};
	
asgn:
	ID ASSIGN expr SEMICOLON | ID  LSQBRACKET expr RSQBRACKET ASSIGN expr SEMICOLON {System.out.println("Reduced by rule asgn");};

cond:
	IF expr THEN statement (LSQBRACKET ELSE statement RSQBRACKET)* {System.out.println("Reduced by rule asgn");};

forloop:
	'for' ID ASSIGN expr 'to' expr 'do' statement {System.out.println("Reduced by rule forloop");}; 	

call:
	CALL ID LPAREN (expr (COMMA expr)*)? RPAREN SEMICOLON {System.out.println("Reduced by rule call");};

expr:
	(term) (PLUS term | MINUS term | OR term)* {System.out.println("Reduced by rule expr");};

term:
	(factor) (MULTIPLY factor | DIVIDE factor | AND factor)* {System.out.println("Reduced by rule term");};

factor:
	MINUS prim | NOT prim | prim {System.out.println("Reduced by rule factor");};

prim:
	INT_CONST | (TRUE | FALSE) | value  | LPAREN expr RPAREN | LPAREN expr relop expr RPAREN {System.out.println("Reduced by rule prim");}; 

value:
	ID | ID LSQBRACKET expr RSQBRACKET {System.out.println("Reduced by rule value");};
 
relop:
	EQUALS | LESSTHAN | GREATERTHAN | LESSTHANEQUAL | GREATERTHANEQUAL | NOTEQUALS {System.out.println("Reduced by rule relop");};
	