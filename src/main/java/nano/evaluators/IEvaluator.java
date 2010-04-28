package nano.evaluators;

public interface IEvaluator<E> {
	public E evaluate();

	public String toTreeString(String indent);
}
