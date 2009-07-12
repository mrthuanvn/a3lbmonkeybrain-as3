package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.calculia.core.CalcTable;
	
	import flash.errors.IllegalOperationError;

	public class HashNetwork extends AbstractGraph implements MutableNetwork
	{
		protected const _vertices:MutableSet = new HashSet();
		protected const arcs:MutableSet = new HashSet();
		protected const calcTable:CalcTable = new CalcTable();
		protected var arcFactory:ArcFactory;
		public function HashNetwork(arcFactory:ArcFactory = null)
		{
			super();
			this.arcFactory = arcFactory ? arcFactory : new ArcFactory();
		}
		public static function createFromArcs(arcs:Object, arcFactory:ArcFactory = null):HashNetwork
		{
			const network:HashNetwork = new HashNetwork(arcFactory);
			for each (var arc:Object in arcs)
				network.createWeightedEdge(arc[0], arc[1], arc.hasOwnProperty(2) ? (arc[2] as Number) : NaN);
			return network;
		}
		public function weightedBall(v:Object, d:Number):FiniteSet
		{
			// :TODO: Use calcTable?
			if (isNaN(d))
				return null;
			if (d <= 0)
				return EmptySet.INSTANCE;
			if (d == Number.POSITIVE_INFINITY)
				return _vertices;
			const ball:MutableSet = new HashSet();
			for each (var u:Object in _vertices)
			{
				if (weightedDistance(u, v) < d)
					ball.add(u);
			}
			return ball;
		}
		public function createWeightedEdge(u:Object, v:Object, weight:Number):FiniteList
		{
			if (u == v)
				throw new ArgumentError("Loops are not allowed in this type of graph.");
			const edge:FiniteList = arcFactory.create(u, v, weight);
			if (!arcs.has(edge))
			{
				calcTable.reset();
				_vertices.add(u);
				_vertices.add(v);
				arcs.add(edge);
			}
			return edge;
		}
		override public function get connected():Boolean
		{
			if (_vertices.size <= 1)
				return true;
			// :TODO: Use calcTable?
			for each (var u:Object in _vertices)
				for each (var v:Object in _vertices)
					if (u != v && !areConnected(u, v))
						return false;
			return true;
		}
		public function weightedDistance(u:Object, v:Object):Number
		{
			if (u == v)
				return 0.0;
			if (!_vertices.has(u) || !_vertices.has(v) || !areConnected(u, v))
				return NaN;
			const args:Array = [u, v];
			const r:* = calcTable.getResult(weightedDistance, args);
			if (r is Number)
				return r as Number;
			const traverser:WeightedDistanceTraverser = new WeightedDistanceTraverser(v);
			traverser.traverseArcs(this, u);
			const result:Number = traverser.minimumDistance;
			calcTable.setResult(weightedDistance, args, result);
			calcTable.setResult(weightedDistance, [v, u], result);
			return result;
		}
		protected function convertToArc(edge:FiniteCollection):FiniteList
		{
			if (!(edge is FiniteList))
				throw new ArgumentError("Directed graphs can only have finite lists for edges (arcs).");
			const l:FiniteList = edge as FiniteList;
			if (l.size == 3)
				return arcFactory.create(l.getMember(0), l.getMember(1), l.getMember(2) as Number);
			if (l.size == 2)
				return arcFactory.create(l.getMember(0), l.getMember(1), NaN);
			throw new ArgumentError("Weighted graphs must have arcs with two or three elements (source, target, weight [optional]).");
		}
		public function addEdge(edge:FiniteCollection):void
		{
			const arc:FiniteList = convertToArc(edge);
			if (arc.getMember(0) == arc.getMember(1))
				throw new ArgumentError("Loops are not allowed in this type of graph.");
			if (!arcs.has(arc))
			{
				calcTable.reset();
				_vertices.add(arc.getMember(0));
				_vertices.add(arc.getMember(1));
				arcs.add(arc);
			}
		}
		public function allPredecessors(s:FiniteSet):FiniteSet
		{
			if (s.empty)
				return EmptySet.INSTANCE;
			const result:MutableSet = new HashSet();
			for each (var v:Object in s)
				result.addMembers(predecessors(v));
			return result;
		}
		public function allSuccessors(s:FiniteSet):FiniteSet
		{
			if (s.empty)
				return EmptySet.INSTANCE;
			const result:MutableSet = new HashSet();
			for each (var v:Object in s)
				result.addMembers(successors(v));
			return result;
		}
		public function createEdge(u:Object, v:Object):FiniteCollection
		{
			if (u == v)
				throw new ArgumentError("Loops are not allowed in this type of graph.");
			return createWeightedEdge(u, v, NaN);
		}
		override public function get edges():FiniteSet
		{
			return arcs;
		}
		override public function get vertices():FiniteSet
		{
			return _vertices;
		}
		public function addVertex(v:Object):void
		{
			if (!_vertices.has(v))
			{
				calcTable.reset();
				_vertices.add(v);
			}
		}
		public function removeVertex(v:Object):void
		{
			if (_vertices.has(v))
			{
				calcTable.reset();
				for each (var arc:FiniteList in incidentEdges(v))
					arcs.remove(arc);
				_vertices.remove(v);
			}
		}
		public function removeEdge(edge:FiniteCollection):void
		{
			const arc:FiniteList = convertToArc(edge);
			if (arcs.has(arc))
			{
				arcs.remove(arc);
				calcTable.reset();
			}
		}
		override public function areConnected(u:Object, v:Object):Boolean
		{
			const args:Array = [u, v];
			const r:* = calcTable.getResult(areConnected, args);
			if (r is Boolean)
				return r as Boolean;
			const traverser:ConnectionTraverser = new ConnectionTraverser(v);
			traverser.traverseArcs(this, u);
			const result:Boolean = traverser.connected;
			calcTable.setResult(areConnected, args, result);
			return result;
		}
		override public function ball(v:Object, d:uint):FiniteSet
		{
			const ball:MutableSet = HashSet.createSingleton(v);
			if (_vertices.size > 1 && !arcs.empty)
			{
				for each (var u:Object in _vertices)
				{
					if (u != v)
						if (areConnected(u, v))
							if (distance(u, v) < d)
								ball.add(u);
				}
			}
			return ball;
		}
		override public function distance(u:Object, v:Object):uint
		{
			if (u == v)
				return 0;
			if (!_vertices.has(u) || !_vertices.has(v))
				throw new IllegalOperationError("A vertex is not in this graph's vertex set.");
			if (!areConnected(u, v))
				throw new IllegalOperationError("Vertices are not connected.");
			const args:Array = [u, v];
			const r:* = calcTable.getResult(distance, args);
			if (r is Number)
				return r as Number;
			const traverser:DistanceTraverser = new DistanceTraverser(v);
			traverser.traverseArcs(this, u);
			const result:uint = traverser.minimumDistance;
			calcTable.setResult(distance, args, result);
			calcTable.setResult(distance, [v, u], result);
			return result;
		}
		override public function incidentEdges(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(incidentEdges, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
				if (arc.getMember(0) == v || arc.getMember(1) == v)
					result.add(arc);
			calcTable.setResult(incidentEdges, args, result);
			return result;
		}
		override public function walks(u:Object, v:Object):FiniteSet
		{
			if (u == v)
				return EmptySet.INSTANCE;
			if (!_vertices.has(u) || !_vertices.has(v))
				throw new IllegalOperationError("A vertex is not a member of this graph's vertex set.");
			if (!areConnected(u, v))
				return EmptySet.INSTANCE;
			const args:Array = [u, v];
			const r:* = calcTable.getResult(walks, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const traverser:WalksTraverser = new WalksTraverser(u, v);
			traverser.traverseArcs(this, u);
			const result:FiniteSet = traverser.walks;
			calcTable.setResult(walks, args, result);
			return result;
		}
		public function arcsFrom(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(arcsFrom, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
				if (arc.getMember(0) == v)
					result.add(arc);
			calcTable.setResult(arcsFrom, args, result);
			return result;
		}
		public function arcsTo(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(arcsTo, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
				if (arc.getMember(1) == v)
					result.add(arc);
			calcTable.setResult(arcsTo, args, result);
			return result;
		}
		public function commonPredecessors(vertices:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(vertices.toArray())];
			const r:* = calcTable.getResult(commonPredecessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet;
			for each (var v:Object in vertices)
			{
				if (result == null)
					result = predecessors(v);
				else
					result = result.intersect(predecessors(v)) as FiniteSet;
				if (result.empty)
					return EmptySet.INSTANCE;
			}
			if (result == null)
				result = EmptySet.INSTANCE;
			calcTable.setResult(commonPredecessors, args, result);
			return result;
		}
		public function commonSuccessors(vertices:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(vertices.toArray())];
			const r:* = calcTable.getResult(commonSuccessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet;
			for each (var v:Object in vertices)
			{
				if (result == null)
					result = successors(v);
				else
					result = result.intersect(successors(v)) as FiniteSet;
				if (result.empty)
					return EmptySet.INSTANCE;
			}
			if (result == null)
				result = EmptySet.INSTANCE;
			calcTable.setResult(commonSuccessors, args, result);
			return result;
		}
		public function directPredecessors(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(directPredecessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
				if (v == arc.getMember(1))
					result.add(arc.getMember(0));
			calcTable.setResult(directPredecessors, args, result);
			return result;
		}
		public function directSuccessors(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(directSuccessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
				if (v == arc.getMember(0))
					result.add(arc.getMember(1));
			calcTable.setResult(directSuccessors, args, result);
			return result;
		}
		public function precedes(u:Object, v:Object):Boolean
		{
			const args:Array = [u, v];
			const r:* = calcTable.getResult(precedes, args);
			if (r is Boolean)
				return r as Boolean;
			const arcsTo:FiniteSet = this.arcsTo(v);
			if (!arcs.empty)
			{
				var arc:FiniteList;
				for each (arc in arcsTo)
					if (arc.getMember(0) == u)
					{
						calcTable.setResult(precedes, args, true);
						calcTable.setResult(precedes, [v, u], false);
						return true;
					}
				for each (arc in arcsTo)
					if (precedes(u, arc.getMember(0)))
					{
						calcTable.setResult(precedes, args, true);
						calcTable.setResult(precedes, [v, u], false);
						return true;
					}
			}
			calcTable.setResult(precedes, args, false);
			return false;
		}
		public function precedesOrEquals(u:Object, v:Object):Boolean
		{
			if (u == v)
				return true;
			return precedes(u, v);
		}
		public function succeeds(u:Object, v:Object):Boolean
		{
			return precedes(v, u);
		}
		public function succeedsOrEquals(u:Object, v:Object):Boolean
		{
			if (u == v)
				return true;
			return succeeds(u, v);
		}
		public function predecessors(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(predecessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = HashSet.createSingleton(v);
			for each (var arc:FiniteList in arcsTo(v))
				result = result.union(predecessors(arc.getMember(0))) as FiniteSet;
			calcTable.setResult(predecessors, args, result);
			return result;
		}
		public function successors(v:Object):FiniteSet
		{
			const args:Array = [v];
			const r:* = calcTable.getResult(successors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = HashSet.createSingleton(v);
			for each (var arc:FiniteList in arcsFrom(v))
				result = result.union(successors(arc.getMember(1))) as FiniteSet;
			calcTable.setResult(successors, args, result);
			return result;
		}
		public function paths(u:Object, v:Object):FiniteSet
		{
			const args:Array = [u, v];
			const r:* = calcTable.getResult(paths, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			if (!precedes(u, v))
				return EmptySet.INSTANCE;
			const paths:MutableSet /* .<Walk> */ = new HashSet();
			for each (var arc:FiniteList in arcsFrom(u))
			{
				var tail:Object = arc.getMember(1);
				if (tail == v)
					paths.add(VectorWalk.createWalkFromArcs(u, [arc]));
				else
				{
					var subpaths:FiniteSet /* .<Walk> */ = this.paths(tail, v);
					for each (var path:Walk in subpaths)
						paths.add(VectorWalk.prependArc(path, arc));
				}
			}
			calcTable.setResult(paths, args, paths);
			return paths;
		}
		
		public function branchAncestor(internalSet:FiniteSet, externalSet:FiniteSet):FiniteSet
		{
			const commonPredecessorsInternal:FiniteSet = commonPredecessors(internalSet);
			if (commonPredecessorsInternal.empty)
				return EmptySet.INSTANCE;
			const allPredecessorsExternal:FiniteSet = allPredecessors(externalSet);
			const exclusivePredecessors:FiniteSet
				= commonPredecessorsInternal.diff(allPredecessorsExternal) as FiniteSet;
			if (exclusivePredecessors.empty)
				return EmptySet.INSTANCE;
			return minimal(exclusivePredecessors);
		}
		public function branchClade(internalSet:FiniteSet, externalSet:FiniteSet):FiniteSet
		{
			const commonPredecessorsInternal:FiniteSet = commonPredecessors(internalSet);
			if (commonPredecessorsInternal.empty)
				return EmptySet.INSTANCE;
			const allPredecessorsExternal:FiniteSet = allPredecessors(externalSet);
			const exclusivePredecessors:FiniteSet
				= commonPredecessorsInternal.diff(allPredecessorsExternal) as FiniteSet;
			if (exclusivePredecessors.empty)
				return EmptySet.INSTANCE;
			return allSuccessors(exclusivePredecessors);
		}
		public function isCladeAncestor(s:FiniteSet):Boolean
		{
			if (s.empty)
				return false;
			if (s.size == 1)
				return true;
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(isCladeAncestor, args);
			if (r is Boolean)
				return r as Boolean;
			var result:Boolean = false
			if (s.equals(minimal(s)))
				for each (var member:Object in _vertices)
					if (!s.has(member))
					{
						result = true;
						for each (var v:Object in s)
							if (!precedes(v, member))
							{
								result = false;
								break;
							}
						if (result)
							break;
					}
			calcTable.setResult(isCladeAncestor, args, result);
			return result;
		}
		public function clade(ancestors:FiniteSet):FiniteSet
		{
			if (isCladeAncestor(ancestors))
				return allSuccessors(ancestors);
			return EmptySet.INSTANCE;
		}
		public function crown(successors:FiniteSet, sufficientlyMaximal:FiniteSet):FiniteSet
		{
			if (successors.empty || sufficientlyMaximal.empty)
				return EmptySet.INSTANCE;
			return nodeClade(sufficientlyMaximal.intersect(nodeClade(successors)) as FiniteSet);
		}
		public function maximal(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(maximal, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var u:Object in s)
			{
				var max:Boolean = true;
				for each (var v:Object in s)
				{
					if (u != v && precedes(u, v))
					{
						max = false;
						break;
					}
				}
				if (max)
					result.add(u);
			}
			calcTable.setResult(maximal, args, result);
			return result;
		}
		public function minimal(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(minimal, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var u:Object in s)
			{
				var min:Boolean = true;
				for each (var v:Object in s)
				{
					if (u != v && precedes(v, u))
					{
						min = false;
						break;
					}
				}
				if (min)
					result.add(u);
			}
			calcTable.setResult(minimal, args, result);
			return result;
		}
		public function nodeAncestor(s:FiniteSet):FiniteSet
		{
			return maximal(commonPredecessors(s));
		}
		public function nodeClade(s:FiniteSet):FiniteSet
		{
			return allSuccessors(nodeAncestor(s));
		}
		public function comemberPredecessors(comembers:FiniteSet, successors:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(comembers.toArray()),
				CalcTable.argumentsToToken(successors.toArray())];
			const r:* = calcTable.getResult(comemberPredecessors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			if (!successors.subsetOf(comembers) || successors.empty)
				return EmptySet.INSTANCE;
			const comemberCommonPredecessors:FiniteSet = comembers.intersect(commonPredecessors(successors)) as FiniteSet;
			if (comemberCommonPredecessors.empty)
				return EmptySet.INSTANCE;
			var result:HashSet = new HashSet();
			for each (var candidate:Object in comemberCommonPredecessors)
			{
				var successorPathsFound:uint = 0;
				for each (var successor:Object in successors)
				{
					if (candidate == successor)
						++successorPathsFound;
					else
					{
						var pathFound:Boolean = false;
						var paths:FiniteSet /* .<Walk> */ = paths(candidate, successor);
						for each (var path:Walk in paths)
						{
							if (HashSet.fromObject(path.vertices).subsetOf(comembers))
							{
								pathFound = true;
								++successorPathsFound;
								break;
							}
						}
						if (!pathFound)
							break;
					}
				}
				if (successorPathsFound == successors.size)
					result.add(candidate);
			}
			calcTable.setResult(comemberPredecessors, args, result);
			return result;
		}
		public function total(s:FiniteSet, sufficientlyMaximal:FiniteSet):FiniteSet
		{
			if (s.empty || sufficientlyMaximal.empty)
				return EmptySet.INSTANCE;
			const nClade:FiniteSet = nodeClade(s);
			if (nClade.empty)
				return EmptySet.INSTANCE;
			const internalSpec:FiniteSet = nClade.intersect(sufficientlyMaximal) as FiniteSet;
			if (internalSpec.empty)
				return EmptySet.INSTANCE;
			const externalSpec:FiniteSet = sufficientlyMaximal.diff(internalSpec) as FiniteSet;
			return branchClade(internalSpec, externalSpec);
		}
		
	}
}
import a3lbmonkeybrain.brainstem.collections.FiniteList;
import a3lbmonkeybrain.brainstem.collections.FiniteSet;
import a3lbmonkeybrain.brainstem.collections.HashSet;
import a3lbmonkeybrain.brainstem.collections.MutableList;
import a3lbmonkeybrain.brainstem.collections.MutableSet;
import a3lbmonkeybrain.brainstem.collections.VectorList;
import a3lbmonkeybrain.calculia.collections.graphs.AbstractDirectedGraphTraverser;
import a3lbmonkeybrain.calculia.collections.graphs.DirectedGraph;
import a3lbmonkeybrain.calculia.collections.graphs.VectorWalk;
import a3lbmonkeybrain.calculia.collections.graphs.Walk;
import flash.errors.IllegalOperationError;

final class ConnectionTraverser extends AbstractDirectedGraphTraverser
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
	override protected function moveFrom(arc:FiniteList, vertex:Object) : void
	{
	}
	override protected function moveTo(arc:FiniteList, vertex:Object) : Boolean
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
final class DistanceTraverser extends AbstractDirectedGraphTraverser
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
	override protected function moveFrom(arc:FiniteList, vertex:Object) : void
	{
		--currentDistance;
	}
	override protected function moveTo(arc:FiniteList, vertex:Object) : Boolean
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
final class WalksTraverser extends AbstractDirectedGraphTraverser
{
	private const _walks:MutableSet = new HashSet();
	private const currentWalk:Vector.<FiniteList> = new Vector.<FiniteList>();
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
	override protected function moveFrom(arc:FiniteList, vertex:Object) : void
	{
		currentWalk.pop();
	}
	override protected function moveTo(arc:FiniteList, vertex:Object) : Boolean
	{
		currentWalk.push(arc);
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
final class WeightedDistanceTraverser extends AbstractDirectedGraphTraverser
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
	override protected function moveFrom(arc:FiniteList, vertex:Object) : void
	{
		const weight:Number = Number(arc.getMember(2));
		currentDistance -= weight;
	}
	override protected function moveTo(arc:FiniteList, vertex:Object) : Boolean
	{
		const weight:Number = Number(arc.getMember(2));
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
