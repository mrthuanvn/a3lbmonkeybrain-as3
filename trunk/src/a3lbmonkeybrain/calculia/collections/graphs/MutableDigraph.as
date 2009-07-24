package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;

	public interface MutableDigraph extends MutableGraph, Digraph
	{
		function addArc(arc:FiniteList):void;
		function createArc(head:Object, tail:Object):FiniteList;
		function removeArc(arc:FiniteList):void;
	}
}