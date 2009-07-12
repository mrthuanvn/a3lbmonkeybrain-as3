package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	
	import flash.utils.Dictionary;
	
	public class ArcFactory
	{
		protected const arcs:Dictionary = new Dictionary();
		public function create(head:Object, tail:Object, weight:Number = NaN):FiniteList
		{
			var headDictionary:* = arcs[head];
			if (headDictionary == undefined)
				arcs[head] = headDictionary = new Dictionary();
			var tailDictionary:* = headDictionary[tail];
			if (tailDictionary == undefined)
				headDictionary[tail] = tailDictionary = new Dictionary();
			var result:* = tailDictionary[weight];
			if (!(result is FiniteList))
			{
				tailDictionary[weight] = result = isNaN(weight)
					? new Arc(head, tail)
					: new WeightedArc(head, tail, weight);
			}
			return result as FiniteList;
		}
	}
}