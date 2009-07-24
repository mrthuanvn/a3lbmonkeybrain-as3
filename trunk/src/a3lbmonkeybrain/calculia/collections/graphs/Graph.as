package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	
	public interface Graph extends FiniteList
	{
		function get connected():Boolean;
		function get vertices():FiniteSet;
		function areConnected(u:Object, v:Object):Boolean;
		function prSubgraphOf(value:Graph):Boolean;
		function subgraphOf(value:Graph):Boolean;
	}
}