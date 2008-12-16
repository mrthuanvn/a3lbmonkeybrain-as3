package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.Set;
	
	public interface Graph extends FiniteList
	{
		function get complement():Graph;
		function get connected():Boolean;
		function get cyclic():Boolean;
		function get directed():Boolean;
		function get edges():Set;
		function get maxMultiplicity():uint;
		function get simple():Boolean;
		function get vertices():Set;
		function get weighted():Boolean;
		function distance(u:Object, v:Object):uint;
		function multiplicity(edge:FiniteList):uint;
		function subgraphOf(value:Graph):Boolean;
		function walks(u:Object, v:Object):Set;
		function weightedDistance(u:Object, v:Object):Number;
	}
}