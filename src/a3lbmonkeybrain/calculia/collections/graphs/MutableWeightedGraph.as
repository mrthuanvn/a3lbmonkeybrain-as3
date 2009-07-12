package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;

	public interface MutableWeightedGraph extends MutableGraph, WeightedGraph
	{
		function createWeightedEdge(u:Object, v:Object, weight:Number):FiniteList;
	}
}