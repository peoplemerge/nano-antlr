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
	:	assignment* e=expr EOF { result = e; }
	;
	
declaration
	:	^('var' ID)
			{ variables.put($ID.text, 0); }
	;
	
assignment
	:	^(':=' ID e=expr)
			{ variables.put($ID.text, e); }
	;
	
expr returns [int result]
	:	^('+' op1=expr op2=expr) { result = op1 + op2; }
	|	^('-' op1=expr op2=expr) { result = op1 - op2; }
	|	^('*' op1=expr op2=expr) { result = op1 * op2; }
	|	^('/' op1=expr op2=expr) { result = op1 / op2; }
	|	^(MINUS e=expr)  { result = -e; }
	|	ID { result = variables.get($ID.text); }
	|	INT_CONST { result = Integer.parseInt($INT_CONST.text); }
	;


