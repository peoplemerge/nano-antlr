grammar Nano;

options{
	language = Java;
	backtrack = true;
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

*/

prog returns [String result]:	
	expr {$result = "we got: " + $expr.e.evaluate();}
	;
expr returns [IEvaluator e]:
	(op1=term {$e=$op1.e;}) 
	(
	PLUS op2=term {$e = new PlusEvaluator($e, $op2.e);}
	| MINUS op2=term {$e = new MinusEvaluator($e, $op2.e);}
	| OR op2=term {$e = new OrEvaluator($e, $op2.e);}
	)* {System.out.println("Reduced by rule expr");}
	;

term returns [IEvaluator e]:
	(op1=factor {$e=$op1.e;})
	(
		MULTIPLY op2=factor {$e = new MultiplyEvaluator($e, $op2.e);}
		| DIVIDE op2=factor {$e = new DivideEvaluator($e, $op2.e);}
		| AND op2=factor {$e = new AndEvaluator($e, $op2.e);} 
	)*
	;


factor returns [IEvaluator e]:
	MINUS op1=prim {$e = new NegationEvaluator($prim.e);}
	| NOT op1=prim {$e = new NotEvaluator($prim.e);}
	| op1=prim {$e=$prim.e;}
	;

prim returns [IEvaluator e]:
	INT_CONST {$e = new IntEvaluator(Integer.parseInt($INT_CONST.text));}
	| 	TRUE {$e = new BooleanEvaluator(true);}
	| FALSE {$e = new BooleanEvaluator(false);}
	| value  {$e=$value.e;}
	| LPAREN expr RPAREN {$e=$expr.e;}
	/*
	| LPAREN expr relop expr RPAREN {
		//todo
		$e = new BooleanEvaluator(false);	
	}
	*/
	; 


value returns [IEvaluator e]:
	ID {
	//todo
	$e = new BooleanEvaluator(false);
	}
	/*
	| ID LSQBRACKET expr RSQBRACKET {
	//todo
	$e = new BooleanEvaluator(false);
	}
	*/
	;
 
relop returns [IEvaluator e]:
	(EQUALS | LESSTHAN | GREATERTHAN | LESSTHANEQUAL | GREATERTHANEQUAL | NOTEQUALS){
	//todo
	$e = new BooleanEvaluator(false);
	}
	;
	
