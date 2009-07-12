package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.AbstractProxyCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.MutableList;
	import a3lbmonkeybrain.brainstem.collections.VectorList;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.utils.flash_proxy;

	use namespace flash_proxy;

	public final class VectorWalk extends AbstractProxyCollection implements Walk
	{
		private const _edges:MutableList = new VectorList();
		private const _vertices:MutableList = new VectorList();
		public function VectorWalk()
		{
			super();
		}
		public static function prependArc(walk:Walk, arc:FiniteList):VectorWalk
		{
			const newWalk:VectorWalk = new VectorWalk();
			newWalk._edges.addMembers(walk.edges);
			newWalk._vertices.addMembers(walk.vertices);
			const firstVertex:Object = walk.vertices.getMember(0);
			if (Equality.equal(arc.getMember(0), firstVertex))
				newWalk._vertices.addToStart(arc.getMember(1));
			else
				newWalk._vertices.addToStart(arc.getMember(0));
			newWalk._edges.addToStart(arc);
			return newWalk;
		}
		public static function createPathFromArcs(arcs:Object):VectorWalk
		{
			const walk:VectorWalk = new VectorWalk();
			var lastArc:FiniteList;
			for each (var arc:FiniteList in arcs)
			{
				if (lastArc)
					if (!Equality.equal(lastArc.getMember(1), arc.getMember(0)))
						throw new ArgumentError("Argument does not represent a series of ordered, adjacent arcs.");
				walk._vertices.add(arc[0]);
				walk._edges.add(arc);
				lastArc = arc;
			}
			walk._vertices.add(arc[1]);
			return walk;
		}
		public static function createWalkFromArcs(start:Object, arcs:Object):VectorWalk
		{
			const walk:VectorWalk = new VectorWalk();
			walk._vertices.add(start);
			var lastVertex:Object = start;
			for each (var arc:FiniteList in arcs)
			{
				walk._edges.add(arc);
				if (arc.getMember(0) == lastVertex)
					lastVertex = arc.getMember(1);
				else if (arc.getMember(1) == lastVertex)
					lastVertex = arc.getMember(0);
				else
					throw new ArgumentError("Argument does not represent a series of adjacent arcs.");
				walk._vertices.add(lastVertex);
			}
			return walk;
		}
		public function get edges():FiniteList
		{
			return _edges;
		}
		public function get vertices():FiniteList
		{
			return _vertices;
		}
		public function getMember(index:uint):Object
		{
			if ((index >> 1) << 1 != index)
				return _vertices.getMember(index >> 1);
			return _edges.getMember((index - 1) >> 1);
		}
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
				return Equality.arraysEqual(toArray(), FiniteList(value).toArray());
			return false;
		}
		public function get singleMember():Object
		{
			return _vertices.singleMember;
		}
		public function get empty():Boolean
		{
			return _vertices.empty;
		}
		public function get size():uint
		{
			if (_vertices.empty)
				return 0;
			return (_vertices.size << 1) - 1;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (isNaN(name))
				return undefined;
			return getMember(name as uint);
		}
		public function has(element:Object):Boolean
		{
			return _vertices.has(element) || _edges.has(element);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return !isNaN(name) && name >= 0 && name < size;
		}
		public function every(test:Function, thisObject:*=null):Boolean
		{
			return _vertices.every(test, thisObject) && _edges.every(test, thisObject);
		}
		public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			return VectorList.fromObject(toVector().filter(test, thisObject));
		}
		public function forEach(callback:Function, thisObject:*=null):void
		{
			_vertices.forEach(callback, thisObject);
			_edges.forEach(callback, thisObject);
		}
		public function map(mapper:Function, thisObject:*=null):FiniteCollection
		{
			return VectorList.fromObject(toVector().map(mapper, thisObject));
		}
		public function some(test:Function, thisObject:*=null):Boolean
		{
			return _vertices.some(test, thisObject) || _edges.some(test, thisObject);
		}
		public function toArray():Array
		{
			const s:uint = size;
			const a:Array = new Array(s);
			const n:uint = _vertices.size;
			for (var i:uint = 0; i < n; ++i)
			{
				a[i << 1] = _vertices[i];
				a[(i << 1) + 1] = _edges[i];
			}
			a[s] = _vertices[n - 1];
			return a;
		}
		override public function toVector():Vector.<Object>
		{
			const s:uint = size;
			const v:Vector.<Object> = new Vector.<Object>(s);
			const n:uint = _vertices.size;
			for (var i:uint = 0; i < n; ++i)
			{
				v[i << 1] = _vertices[i];
				v[(i << 1) + 1] = _edges[i];
			}
			v[s] = _vertices[n - 1];
			return v;
		}
	}
}