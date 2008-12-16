package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.calculia.collections.graphs.SimpleArc;
	import a3lbmonkeybrain.calculia.collections.graphs.WeightedArc;
	
	import flash.utils.Dictionary;
	
	public final class ArcFactory
	{
		private static const arcs:Dictionary = new Dictionary();
		public static function create(head:Object, tail:Object, weight:Number = NaN):FiniteList
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
					? new SimpleArc(head, tail)
					: new WeightedArc(head, tail, weight);
			}
			return result as FiniteList;
		}
	}
}