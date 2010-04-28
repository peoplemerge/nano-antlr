package nano.evaluators;

public class IntEvaluator implements IEvaluator<Integer> {

	private Integer value;

	@Override
	public Integer evaluate() {
		return value;
	}
	public IntEvaluator(Integer value) {
		this.value = value;
	}
	public String toTreeString(String indent) {
		return '\n' + indent + "Int: " + value;
	}
}
