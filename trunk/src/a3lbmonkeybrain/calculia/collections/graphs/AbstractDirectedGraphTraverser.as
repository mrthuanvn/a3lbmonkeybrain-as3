package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;

	public class AbstractDirectedGraphTraverser
	{
		private const traversed:MutableSet = new HashSet();
		public function AbstractDirectedGraphTraverser()
		{
			super();
		}
		protected function moveFrom(arc:FiniteList, vertex:Object):void
		{
			throw new AbstractMethodError();
		}
		protected function moveTo(arc:FiniteList, vertex:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		public function traverseArcs(graph:DirectedGraph, start:Object):void
		{
			var arc:FiniteList;
			var next:Object;
			for each (arc in graph.arcsFrom(start).diff(traversed))
			{
				next = arc.getMember(1);
				if (moveTo(arc, next))
				{
					traversed.add(arc);
					traverseArcs(graph, next);
					moveFrom(arc, next);
					traversed.remove(arc);
				}
			}
			for each (arc in graph.arcsTo(start).diff(traversed))
			{
				next = arc.getMember(0);
				if (moveTo(arc, next))
				{
					traversed.add(arc);
					traverseArcs(graph, next);
					moveFrom(arc, next);
					traversed.remove(arc);
				}
			}
		}
	}
}