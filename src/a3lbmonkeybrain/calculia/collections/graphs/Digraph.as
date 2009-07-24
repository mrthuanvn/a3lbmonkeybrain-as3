package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;

	public interface Digraph extends Graph
	{
		function get arcs():FiniteSet /* .<FiniteList>*/;
		function get cyclic():Boolean;
		function arcsFrom(v:Object):FiniteSet /* .<FiniteList>*/;
		function arcsTo(v:Object):FiniteSet /* .<FiniteList>*/;
		function commonPredecessors(vertices:FiniteSet):FiniteSet /*.<Object>*/;
		function commonSuccessors(vertices:FiniteSet):FiniteSet /*.<Object>*/;
		function immediatePredecessors(v:Object):FiniteSet /*.<Object>*/;
		function immediateSuccessors(v:Object):FiniteSet /*.<Object>*/;
		function incidentArcs(v:Object):FiniteSet /* .<FiniteList>*/;
		function paths(u:Object, v:Object):FiniteSet /*.<Walk>*/;
		function precedes(u:Object, v:Object):Boolean;
		function precedesOrEquals(u:Object, v:Object):Boolean;
		function predecessors(v:Object):FiniteSet /*.<Object>*/;
		function succeeds(u:Object, v:Object):Boolean;
		function succeedsOrEquals(u:Object, v:Object):Boolean;
		function successors(v:Object):FiniteSet /*.<Object>*/;
	}
}