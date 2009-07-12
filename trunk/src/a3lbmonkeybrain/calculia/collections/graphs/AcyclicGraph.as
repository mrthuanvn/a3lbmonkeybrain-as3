package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;

	public interface AcyclicGraph extends DirectedGraph
	{
		function branchAncestor(internalSet:FiniteSet, externalSet:FiniteSet):FiniteSet;
		function branchClade(internalSet:FiniteSet, externalSet:FiniteSet):FiniteSet;
		function clade(ancestor:FiniteSet):FiniteSet;
		function comemberPredecessors(comembers:FiniteSet, successors:FiniteSet):FiniteSet;
		function crown(successors:FiniteSet, sufficientlyMaximal:FiniteSet):FiniteSet;
		function isIndependent(s:FiniteSet):Boolean;
		function maximal(vertices:FiniteSet):FiniteSet;
		function minimal(vertices:FiniteSet):FiniteSet;
		function nodeAncestor(successors:FiniteSet):FiniteSet;
		function nodeClade(successors:FiniteSet):FiniteSet;
		function total(successors:FiniteSet, sufficientlyMaximal:FiniteSet):FiniteSet;
	}
}