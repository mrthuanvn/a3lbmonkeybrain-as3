package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;

	public interface WeightedGraph extends Graph
	{
		function weightedBall(x:Object, distance:Number):FiniteSet;
		function weightedDistance(u:Object, v:Object):Number;
	}
}