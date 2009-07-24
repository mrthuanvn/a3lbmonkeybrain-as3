package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.calculia.collections.operations.Operation;

	public interface GraphWeight extends Operation
	{
		function getWeight(edge:FiniteCollection):Number;
	}
}