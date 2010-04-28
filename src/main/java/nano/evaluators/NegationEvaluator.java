package nano.evaluators;

public class NegationEvaluator implements IEvaluator<Integer> {

	private final IEvaluator<Integer> op1;

	public NegationEvaluator(IEvaluator<Integer> op1) {
		super();
		this.op1 = op1;
	}

	@Override
	public Integer evaluate() {
		return -op1.evaluate();
	}
	public String toTreeString(String indent) {
		return '\n' + indent + "Negation" +
			op1.toTreeString(indent + "  ");
	}
}
