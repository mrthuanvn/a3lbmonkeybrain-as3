package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;

	public interface MutableUndirectedGraph extends MutableGraph, UndirectedGraph
	{
		function addEdge(edge:FiniteSet):void;
		function createEdge(u:Object, v:Object):FiniteSet;
		function removeEdge(edge:FiniteSet):void;
	}
}