package nano.evaluators;

public class NotEvaluator implements IEvaluator<Boolean> {

	private final IEvaluator<Boolean> op1;

	public NotEvaluator(IEvaluator<Boolean> op1) {
		super();
		this.op1 = op1;
	}

	@Override
	public Boolean evaluate() {
		return ! op1.evaluate();
	}
	public String toTreeString(String indent) {
		return '\n' + indent + "Not" +
			op1.toTreeString(indent + "  ");
	}
}
