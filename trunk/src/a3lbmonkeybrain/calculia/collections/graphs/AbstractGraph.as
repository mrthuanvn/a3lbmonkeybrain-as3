package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.AbstractProxyCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableCollection;
	import a3lbmonkeybrain.brainstem.collections.VectorList;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.flash_proxy;

	use namespace flash_proxy;
	
	public class AbstractGraph extends AbstractProxyCollection implements Graph
	{
		public function AbstractGraph()
		{
			super();
		}
		public function get connected():Boolean
		{
			throw new AbstractMethodError();
		}
		public function get edges():FiniteSet
		{
			throw new AbstractMethodError();
		}
		public function get vertices():FiniteSet
		{
			throw new AbstractMethodError();
		}
		public function areConnected(u:Object, v:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		public function ball(v:Object, d:uint):FiniteSet
		{
			throw new AbstractMethodError();
		}
		public function distance(u:Object, v:Object):uint
		{
			throw new AbstractMethodError();
		}
		public function incidentEdges(u:Object):FiniteSet
		{
			throw new AbstractMethodError();
		}
		public function prSubgraphOf(value:Graph):Boolean
		{
			return vertices.prSubsetOf(value.vertices) && edges.prSubsetOf(value.edges);
		}
		public function subgraphOf(value:Graph):Boolean
		{
			return vertices.subsetOf(value.vertices) && edges.subsetOf(value.edges);
		}
		public function walks(u:Object, v:Object):FiniteSet
		{
			throw new AbstractMethodError();
		}
		public final function getMember(index:uint):Object
		{
			if (index == 0)
				return vertices;
			if (index == 1)
				return edges;
			throw new RangeError("A graph only has two members.");
		}
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			throw new IllegalOperationError("Cannot delete a member of a graph.");
		}
		public final function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
			{
				const l:FiniteList = value as FiniteList;
				if (l.size != 2)
					return false;
				return vertices.equals(l.getMember(0)) && edges.equals(l.getMember(1));
			}
			return false;
		}
		public final function get singleMember():Object
		{
			throw new IllegalOperationError("All graphs have two members.");
		}
		public final function get empty():Boolean
		{
			return false;
		}
		public final function get size():uint
		{
			return 2;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (isNaN(name))
				return undefined;
			return getMember(uint(name));
		}
		public final function has(element:Object):Boolean
		{
			return vertices.equals(element) || edges.equals(element);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return name == 0 || name == 1;
		}
		public final function every(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [vertices]) && test.apply(thisObject, [edges]);
		}
		public final function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			const collection:MutableCollection = new HashSet();
			if (test.apply(thisObject, [vertices]))
				collection.add(vertices);
			if (test.apply(thisObject, [edges]))
				collection.add(edges);
			return collection;
		}
		public final function forEach(callback:Function, thisObject:*=null):void
		{
			callback.apply(thisObject, [vertices]);
			callback.apply(thisObject, [edges]);
		}
		public final function map(mapper:Function, thisObject:*=null):FiniteCollection
		{
			const collection:MutableCollection = new VectorList();
			collection.add(mapper.apply(thisObject, [vertices]));
			collection.add(mapper.apply(thisObject, [edges]));
			return collection;
		}
		public final function some(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [vertices]) || test.apply(thisObject, [edges]);
		}
		public final function toArray():Array
		{
			return [vertices, edges];
		}
		public function toString():String
		{
			return "(" + vertices + ", " + edges + ")";
		}
		override public final function toVector():Vector.<Object>
		{
			return Vector.<Object>([vertices, edges]);
		}
		public function weightedBall(v:Object, d:Number, weight:GraphWeight):FiniteSet
		{
			throw new AbstractMethodError();
		}
		public function weightedDistance(u:Object, v:Object, weight:GraphWeight):Number
		{
			throw new AbstractMethodError();
		}
	}
}