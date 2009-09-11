package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	
	public final class HashGraph implements MutableGraph
	{
		private const _edges:MutableSet = new HashSet();
		private const _vertices:MutableSet = new HashSet();
		private var edgeFactory:EdgeFactory;
		public function HashGraph(edgeFactory:EdgeFactory = null)
		{
			super();
			this.edgeFactory = edgeFactory ? edgeFactory : new EdgeFactory();
		}
		public function get connected():Boolean
		{
			for each (var u:Object in _vertices)
				for each (var v:Object in _vertices)
					if (!areConnected(u, v))
						return false;
			return true;
		}
		public function get edges():FiniteSet
		{
			return _edges;
		}
		public function get vertices():FiniteSet
		{
			return _vertices;
		}
		public function addVertex(vertex:Object):void
		{
			_vertices.add(vertex);
		}
		public function areConnected(u:Object, v:Object):Boolean
		{
			return false;
		}
		public function ball(x:Object, distance:uint):FiniteSet
		{
			return null;
		}
		
		public function distance(u:Object, v:Object):uint
		{
			return 0;
		}
		
		public function incidentEdges(u:Object):FiniteSet
		{
			return null;
		}
		
		public function prSubgraphOf(value:Graph):Boolean
		{
			return false;
		}
		
		public function getMember(index:uint):Object
		{
			return null;
		}
		
		public function subgraphOf(value:Graph):Boolean
		{
			return false;
		}
		
		public function walks(u:Object, v:Object):FiniteSet
		{
			return null;
		}
		
		public function equals(value:Object):Boolean
		{
			return false;
		}
		
		public function get singleMember():Object
		{
			return null;
		}
		
		public function get empty():Boolean
		{
			return false;
		}
		
		public function get size():uint
		{
			return 0;
		}
		
		public function has(element:Object):Boolean
		{
			return false;
		}
		
		public function every(test:Function, thisObject:*=null):Boolean
		{
			return false;
		}
		
		public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			return null;
		}
		
		public function forEach(callback:Function, thisObject:*=null):void
		{
		}
		
		public function map(mapper:Function, thisObject:*=null):FiniteCollection
		{
			return null;
		}
		
		public function some(test:Function, thisObject:*=null):Boolean
		{
			return false;
		}
		
		public function removeVertex(vertex:Object):void
		{
			if (_vertices.has(vertex))
			{
				_vertices.remove(vertex);
				// :TODO: remove incident edges
			}
		}
		
		public function toArray():Array
		{
			return null;
		}
		
		public function toVector():Vector.<Object>
		{
			return null;
		}
	}
}
import a3lbmonkeybrain.calculia.collections.graphs.AbstractGraphTraverser;
import a3lbmonkeybrain.brainstem.collections.*;
import flash.errors.IllegalOperationError;
import a3lbmonkeybrain.calculia.collections.graphs.Walk;
import a3lbmonkeybrain.calculia.collections.graphs.VectorWalk;

final class ConnectionTraverser extends AbstractGraphTraverser
{
	private var _connected:Boolean = false;
	private var target:Object;
	public function ConnectionTraverser(target:Object)
	{
		super();
		this.target = target;
	}
	public function get connected():Boolean
	{
		return _connected;
	}
	override protected function moveFrom(edge:FiniteCollection, vertex:Object) : void
	{
	}
	override protected function moveTo(edge:FiniteCollection, vertex:Object) : Boolean
	{
		if (_connected)
			return false;
		if (vertex == target)
		{
			_connected = true;
			return false;
		}
		return true;
	}
}
final class DistanceTraverser extends AbstractGraphTraverser
{
	private const distances:MutableSet = new HashSet();
	private var currentDistance:uint = 0;
	private var target:Object;
	public function DistanceTraverser(target:Object)
	{
		super();
		this.target = target;
	}
	public function get minimumDistance():uint
	{
		if (distances.empty)
			throw new IllegalOperationError("Vertices are not connected.");
		if (distances.size == 1)
			return uint(distances.singleMember);
		var d:Number = uint.MAX_VALUE;
		for each (var distance:uint in distances)
			if (distance < d)
				d = distance;
		return d;
	}
	override protected function moveFrom(edge:FiniteCollection, vertex:Object) : void
	{
		--currentDistance;
	}
	override protected function moveTo(edge:FiniteCollection, vertex:Object) : Boolean
	{
		++currentDistance;
		if (vertex == target)
		{
			distances.add(currentDistance);
			--currentDistance;
			return false;
		}
		return true;
	}
}
final class WalksTraverser extends AbstractGraphTraverser
{
	private const _walks:MutableSet = new HashSet();
	private const currentWalk:Vector.<FiniteCollection> = new Vector.<FiniteCollection>();
	private var source:Object;
	private var target:Object;
	public function WalksTraverser(source:Object, target:Object)
	{
		super();
		this.source = source;
		this.target = target;
	}
	public function get walks():FiniteSet
	{
		return _walks;
	}
	override protected function moveFrom(edge:FiniteCollection, vertex:Object) : void
	{
		currentWalk.pop();
	}
	override protected function moveTo(edge:FiniteCollection, vertex:Object) : Boolean
	{
		currentWalk.push(edge);
		if (vertex == target)
		{
			const walk:Walk = VectorWalk.createWalkFromArcs(source, currentWalk);
			_walks.add(walk);
			currentWalk.pop();
			return false;
		}
		return true;
	}
}
final class WeightedDistanceTraverser extends AbstractGraphTraverser
{
	private const distances:MutableSet = new HashSet();
	private var currentDistance:Number = 0.0;
	private var target:Object;
	public function WeightedDistanceTraverser(target:Object)
	{
		super();
		this.target = target;
	}
	public function get minimumDistance():Number
	{
		if (distances.empty)
			return NaN;
		if (distances.size == 1)
			return distances.singleMember as Number;
		var d:Number = Number.POSITIVE_INFINITY;
		for each (var distance:Number in distances)
			if (distance < d)
				d = distance;
		return d;
	}
	override protected function moveFrom(edge:FiniteCollection, vertex:Object) : void
	{
		if (edge is FiniteList)
		{
			const weight:Number = Number(FiniteList(edge).getMember(2));
			currentDistance -= weight;
		}
	}
	override protected function moveTo(edge:FiniteCollection, vertex:Object) : Boolean
	{
		if (!(edge is FiniteList))
			return false;
		const weight:Number = Number(FiniteList(edge).getMember(2));
		if (isNaN(weight))
			return false;
		if (vertex == target)
		{
			distances.add(currentDistance + weight);
			return false;
		}
		currentDistance += weight;
		return true;
	}
}
