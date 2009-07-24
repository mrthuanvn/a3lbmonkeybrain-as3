package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	
	public interface MutableGraph extends Graph
	{
		function addVertex(v:Object):void;
		function removeVertex(v:Object):void;
	}
}