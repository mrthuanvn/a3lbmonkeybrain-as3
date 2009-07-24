package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	
	import flash.utils.Dictionary;
	
	public class EdgeFactory
	{
		protected const edges:Dictionary = new Dictionary();
		public function create(x:Object, y:Object):FiniteSet
		{
			var xDictionary:* = edges[x];
			var yDictionary:* = edges[y];
			var result:*;
			if (xDictionary == undefined)
			{
				edges[x] = new Dictionary();
				if (yDictionary == undefined)
					edges[y] = new Dictionary();
			}
			else if (yDictionary == undefined)
				edges[y] = new Dictionary();
			else
			{
				result = edges[x][y];
				if (result is FiniteSet)
					return result as FiniteSet;
			}
			result = new HashSet();
			MutableSet(result).add(x);
			MutableSet(result).add(y);
			edges[x][y] = edges[y][x] = result;
			return result as FiniteSet;
		}
	}
}