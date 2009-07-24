package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	
	import flash.utils.Dictionary;
	
	public class ArcFactory
	{
		protected const arcs:Dictionary = new Dictionary();
		public function create(head:Object, tail:Object):Arc
		{
			var headDictionary:* = arcs[head];
			if (headDictionary == undefined)
				arcs[head] = headDictionary = new Dictionary();
			var result:* = headDictionary[tail];
			if (result is Arc)
				return result as Arc;
			headDictionary[tail] = result = new Arc(head, tail);
			return result as Arc;
		}
	}
}