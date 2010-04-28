package nano.evaluators;

public class BooleanEvaluator implements IEvaluator<Boolean> {

	private Boolean value;

	@Override
	public Boolean evaluate() {
		return value;
	}
	public BooleanEvaluator(Boolean value) {
		this.value = value;
	}
	public String toTreeString(String indent) {
		return '\n' + indent + "Boolean: " + value;
	}
}
