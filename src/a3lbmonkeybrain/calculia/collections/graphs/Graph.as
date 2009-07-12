package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	
	public interface Graph extends FiniteList
	{
		function get connected():Boolean;
		function get edges():FiniteSet;
		function get vertices():FiniteSet;
		function areConnected(u:Object, v:Object):Boolean;
		function ball(x:Object, distance:uint):FiniteSet;
		function distance(u:Object, v:Object):uint;
		function incidentEdges(u:Object):FiniteSet;
		function prSubgraphOf(value:Graph):Boolean;
		function subgraphOf(value:Graph):Boolean;
		function walks(u:Object, v:Object):FiniteSet;
	}
}