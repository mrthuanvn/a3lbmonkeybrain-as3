package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.Set;

	public interface DirectedGraph extends Graph
	{
		function allPredecessors(vertices:FiniteSet):FiniteSet;
		function allSuccessors(vertices:FiniteSet):FiniteSet;
		function arcsFrom(v:Object):FiniteSet;
		function arcsTo(v:Object):FiniteSet;
		function commonPredecessors(vertices:FiniteSet):FiniteSet;
		function commonSuccessors(vertices:FiniteSet):FiniteSet;
		function directPredecessors(v:Object):FiniteSet
		function directSuccessors(v:Object):FiniteSet;
		function paths(u:Object, v:Object):FiniteSet;
		function precedes(u:Object, v:Object):Boolean;
		function precedesOrEquals(u:Object, v:Object):Boolean;
		function predecessors(v:Object):FiniteSet;
		function succeeds(u:Object, v:Object):Boolean;
		function succeedsOrEquals(u:Object, v:Object):Boolean;
		function successors(v:Object):FiniteSet;
	}
}