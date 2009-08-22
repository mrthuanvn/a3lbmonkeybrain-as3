package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;

	public class AbstractGraphTraverser
	{
		private const traversed:MutableSet = new HashSet();
		public function AbstractGraphTraverser()
		{
			super();
		}
		protected function moveFrom(edge:FiniteCollection, vertex:Object):void
		{
			throw new AbstractMethodError();
		}
		protected function moveTo(edge:FiniteCollection, vertex:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		public function traverseEdges(graph:UndirectedGraph, start:Object):void
		{
			var edge:FiniteSet;
			var next:Object;
			for each (edge in graph.incidentEdges(start).diff(traversed))
			{
				next = FiniteSet(edge.diff([start])).singleMember;
				if (moveTo(edge, next))
				{
					traversed.add(edge);
					traverseEdges(graph, next);
					moveFrom(edge, next);
					traversed.remove(edge);
				}
			}
		}
	}
}