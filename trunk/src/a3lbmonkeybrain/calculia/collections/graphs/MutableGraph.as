package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	
	public interface MutableGraph extends Graph
	{
		function addEdge(edge:FiniteCollection):void;
		function removeEdge(edge:FiniteCollection):void;
	}
}