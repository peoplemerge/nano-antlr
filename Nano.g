grammar Nano;

options{
	 backtrack=true;
}

prog:	stat+;

	
stat:  
	(const_decl)*  (var_decl)*  (proc_decl)*  'begin' statement (statement)* 'end' SEMICOLON;
	
statement:
	block | print | read | asgn | cond /*| for*/ | 'return' | call;

block:
	'begin' (const_decl)* (var_decl)* (statement)* 'end' SEMICOLON;
	
const_decl:
	 'const' ID (COMMA ID)* ASSIGN INT_CONST SEMICOLON;
	
var_decl:
	 'var' ID (COMMA ID)* COLON scalar_type SEMICOLON
	|  'var' ID LSQBRACKET INT_CONST RSQBRACKET  ( COMMA ID LSQBRACKET INT_CONST RSQBRACKET )* COLON scalar_type ;

proc_decl:
	 'procedure' ID LPAREN (formal (SEMICOLON formal)*)? RPAREN SEMICOLON block;

formal:
	ID ( COMMA ID )* | scalar_type;
		
print:
	'print' LPAREN STRING (COMMA expr)* RPAREN SEMICOLON;
	
read:
	'read' LPAREN STRING (COMMA input_target)* RPAREN SEMICOLON;
	
input_target:
	ID | ID LSQBRACKET expr RSQBRACKET;

//for:
	//'for' ID ASSIGN expr 'to' expr 'do' statement; 
	
cond:
	'if' LPAREN bool_expr RPAREN 'then' statement LSQBRACKET 'else' statement RSQBRACKET; 
	
		
asgn:
	ID ASSIGN expr | ID (int_expr)* ASSIGN expr SEMICOLON;

call:
	'call' ID LPAREN (expr (COMMA expr)*)? RPAREN SEMICOLON;
	
expr:
	int_expr | bool_expr;	
	
boolean_primitive:
	(bool_term) ('or' bool_term)*	;

bool_expr:
	 'not' boolean_primitive;
  
bool_term:
	(bool_factor) ('and' bool_factor)*;
	
bool_factor:
	('true' | 'false') | value * | int_expr relop int_expr | LPAREN bool_expr RPAREN;

value:
	ID (int_expr)*;
		
int_expr:
	int_prim;
	
int_prim:
	 (int_term) (PLUS int_term | MINUS int_term)*;
	
int_term:
	 (int_factor) (MULTIPLY int_factor | DIVIDE int_factor)*;
	
int_factor:
	 INT_CONST| value | LPAREN int_expr RPAREN;

ID  :
	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
	
relop:
	COMPARISON | LESSTHAN | GREATERTHAN | LESSTHANEQUAL | GREATERTHANEQUAL | NOTEQUALS;
	
scalar_type:
	'integer' | 'boolean';


//Tokens
COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;};

WS :
	 ( ' '| '\t' | '\r' | '\n' ) {$channel=HIDDEN;};

    
NEWLINE	:
	'\r'? '\n';


INT_CONST:
	'0'..'9'+;

STRING:
	'"' (~('\\'|'"') )* '"';
	
//Reserved symbols

COMMA :
	 ','; 
   
SEMICOLON:
	';';

COLON:
	 ':';
   	
LPAREN:
	 '(';
	
RPAREN:
	 ')';
	
PLUS:
	 '+';
	
MINUS:
	'-';	
	
MULTIPLY:
	'*';

DIVIDE:
	'/';

LSQBRACKET:
	'[';
	
RSQBRACKET:
	 ']';
	
ASSIGN:
	':=';

COMPARISON:
	 '=';

NOTEQUALS:
	 '<>';
	
LESSTHAN:
	 '<';
	
LESSTHANEQUAL:
	 '<=';
	
GREATERTHAN:
	 '>';				

GREATERTHANEQUAL:
	 '>=';