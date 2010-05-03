tree grammar ProgWalker;

options {
  language = Java;
  tokenVocab = Nano2;
  ASTLabelType = CommonTree;
}

@header {
  package nano;
  import java.util.Map;
  import java.util.HashMap;
}

@members {
  private Map<String, Integer> variables = new HashMap<String, Integer>();
}

evaluator returns [int result]
	: declaration* assignment* e=expr { result = e; }
	;
	
declaration
	:	^(INTEGER ID )
			{ variables.put($ID.text, 0); }
	;
assignment
	:	^(ASSIGN ID e=expr)
			{ variables.put($ID.text, e); }
	;
	
expr returns [int result]
	:	^(PLUS op1=expr op2=expr) { result = op1 + op2; }
	|	^(MINUS op1=expr op2=expr) { result = op1 - op2; }
	|	^(MULTIPLY op1=expr op2=expr) { result = op1 * op2; }
	|	^(DIVIDE op1=expr op2=expr) { result = op1 / op2; }
	|	^(NEGATION e=expr)  { result = -e; }
	|	ID { result = variables.get($ID.text); }
	|	INT_CONST { result = Integer.parseInt($INT_CONST.text); }
	;


