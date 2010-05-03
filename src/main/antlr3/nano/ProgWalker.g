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
	:	^(INTEGER (ID { variables.put($ID.text, 0); })* )
			
	;
assignment
	:	^(ASSIGN ID e=expr)
			{ 
				if(variables.containsKey($ID.text)){
					variables.put($ID.text, e);
				} else {
					System.err.println("Cannot assign undefined variable: " + $ID.text);
				} 
			}
	;
	
expr returns [int result]
	:	^(PLUS op1=expr op2=expr) { result = op1 + op2; }
	|	^(MINUS op1=expr op2=expr) { result = op1 - op2; }
	|	^(MULTIPLY op1=expr op2=expr) { result = op1 * op2; }
	|	^(DIVIDE op1=expr op2=expr) { result = op1 / op2; }
	|	^(NEGATION e=expr)  { result = -e; }
	|	ID {
			if (variables.containsKey($ID.text)){ 
				result = variables.get($ID.text);
			} else {
				System.err.println("Cannot return undefined variable: \"" + $ID.text + "\" so returning 0");
				result = 0;
			} 
		}
	|	INT_CONST { result = Integer.parseInt($INT_CONST.text); }
	;


