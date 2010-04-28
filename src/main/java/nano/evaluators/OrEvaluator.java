package nano.evaluators;

public class OrEvaluator implements IEvaluator<Boolean> {

	private final IEvaluator<Boolean> op1,op2;

	public OrEvaluator(IEvaluator<Boolean> op1, IEvaluator<Boolean> op2) {
		super();
		this.op1 = op1;
		this.op2 = op2;
	}

	@Override
	public Boolean evaluate() {
		return op1.evaluate() || op2.evaluate();
	}
	
	public String toTreeString(String indent) {
		return '\n' + indent + "Or" + op1.toTreeString(indent + "  ")
				+ op2.toTreeString(indent + "  ");
	}
}
