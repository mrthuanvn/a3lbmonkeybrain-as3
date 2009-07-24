package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;

	public interface UndirectedGraph extends Graph
	{
		function get edges():FiniteSet /* .<FiniteSet>*/;
		function ball(x:Object, distance:uint):FiniteSet /* .<Object> */;
		function distance(u:Object, v:Object):uint;
		function incidentEdges(u:Object):FiniteSet /* .<FiniteSet>*/;
		function walks(u:Object, v:Object):FiniteSet /* .<Walk>*/;
		function weightedBall(v:Object, d:Number, weight:GraphWeight):FiniteSet /* .<Object> */;
		function weightedDistance(u:Object, v:Object, weight:GraphWeight):Number;
	}
}