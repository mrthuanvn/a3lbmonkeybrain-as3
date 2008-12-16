package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.ArrayList;
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableCollection;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.calculia.core.CalcTable;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	use namespace flash_proxy;
	
	// :TODO: Implement MutableGraph
	public class Network extends Proxy implements FiniteList
	{
		protected const arcs:MutableSet = new HashSet();
		protected const calcTable:CalcTable = new CalcTable();
		protected const vertices:MutableSet = new HashSet();
		public function Network(arcs:Object = null)
		{
			super();
			if (arcs != null)
			{
				for each (var arc:Object in arcs)
				{
					if (arc is FiniteList)
						add(FiniteList(arc).getMember(0), FiniteList(arc).getMember(1), FiniteList(arc).getMember(2));
					else
						add(arc[0], arc[1], arc[2]);
				}
			}
		}
		public function get empty():Boolean
		{
			return false;
		}
		public function get singleMember():Object
		{
			throw new IllegalOperationError("Graphs cannot be singletons.");
		}
		public function get size():int
		{
			return 2;
		}
		public function add(head:Object, tail:Object, weight:* = undefined):void
		{
			const arc:FiniteList = ArcFactory.create(head, tail, weight);
			arcs.add(arc);
			vertices.add(head);
			vertices.add(tail);
		}
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
			{
				const other:FiniteList = other as FiniteList;
				if (other.size != 2)
					return false;
				return vertices.equals(other.getMember(0)) && arcs.equals(other.getMember(1));
			}
			return false;
		}
		public function every(test:Function, thisObject:* = null):Boolean
		{
			return test.apply(thisObject, [vertices]) && test.apply(thisObject, [arcs]);
		}
		public function filter(test:Function, thisObject:* = null):FiniteCollection
		{
			const filtered:MutableCollection = new ArrayList();
			if (test.apply(thisObject, [vertices]))
				filtered.add(vertices);
			if (test.apply(thisObject, [arcs]))
				filtered.add(arcs);
			return filtered;
		}
		public function findAllAncestors(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findAllAncestors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = new HashSet();
			for each (var member:Object in s)
			{
				result = result.union(findAncestors(member)) as FiniteSet;
			}
			calcTable.setResult(findAllAncestors, args, result);
			return result;
		}
		public function findAllDescendants(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findAllDescendants, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = new HashSet();
			for each (var member:Object in s)
			{
				result = result.union(findDescendants(member)) as FiniteSet;
			}
			calcTable.setResult(findAllDescendants, args, result);
			return result;
		}
		public function findAncestors(x:Object):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findAncestors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = HashSet.fromObject([x]);
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(1), x))
					result = result.union(findAncestors(arc.getMember(0))) as FiniteSet;
			}
			calcTable.setResult(findAncestors, args, result);
			return result;
		}
		public function findApomorphyAncestor(charSet:FiniteSet, specifierSet:FiniteSet):FiniteSet
		{
			return findMinimal(findSynapomorphicAncestors(charSet, specifierSet));
		}
		public function findApomorphyClade(charSet:FiniteSet, specifierSet:FiniteSet):FiniteSet
		{
			return findAllDescendants(findSynapomorphicAncestors(charSet, specifierSet));
		}
		public function findBranchAncestor(inSet:FiniteSet, outSet:FiniteSet):FiniteSet
		{
			const comAncIn:FiniteSet = findCommonAncestors(inSet);
			if (comAncIn.empty)
				return comAncIn;
			const allAncOut:FiniteSet = findAllAncestors(outSet);
			const exclusiveAnc:FiniteSet = comAncIn.diff(allAncOut) as FiniteSet;
			if (exclusiveAnc.empty)
				return exclusiveAnc;
			return findMinimal(exclusiveAnc);
		}
		public function findBranchClade(inSet:FiniteSet, outSet:FiniteSet):FiniteSet
		{
			const comAncIn:FiniteSet = findCommonAncestors(inSet);
			if (comAncIn.empty)
				return comAncIn;
			const allAncOut:FiniteSet = findAllAncestors(outSet);
			const exclusiveAnc:FiniteSet = comAncIn.diff(allAncOut) as FiniteSet;
			if (exclusiveAnc.empty)
				return exclusiveAnc;
			return findAllDescendants(exclusiveAnc);
		}
		public function findChildren(x:Object, weight:Number = 1.0):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findChildren, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
			{
				if (arc.size == 3 && arc.getMember(2) == weight && Equality.equal(arc.getMember(0), x))
					result.add(arc.getMember(1));
			}
			calcTable.setResult(findChildren, args, result);
			return result;
		}
		public function findClade(s:FiniteSet):FiniteSet
		{
			if (s.empty)
				return EmptySet.INSTANCE;
			if (s.size == 1)
			{
				for each (var ancestor:Object in s)
				{
					return findDescendants(ancestor);
				}
			}
			if (!s.equals(findMinimal(s)))
				return EmptySet.INSTANCE;
			var commonDescendantFound:Boolean = false;
			for each (var member:Object in vertices)
			{
				if (!s.has(member))
				{
					commonDescendantFound = true;
					for each (ancestor in s)
					{
						if (!precedes(ancestor, member))
						{
							commonDescendantFound = false;
							break;
						}
					}
				}
				if (commonDescendantFound)
					break;
			}
			if (commonDescendantFound)
				return findAllDescendants(s);
			return EmptySet.INSTANCE;
		}
		public function findCommonAncestors(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findCommonAncestors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet;
			for each (var member:Object in s)
			{
				if (result == null)
					result = findAncestors(member);
				else
					result = result.intersect(findAncestors(member)) as FiniteSet;
				if (result.empty)
					return EmptySet.INSTANCE;
			}
			if (result == null)
				result = EmptySet.INSTANCE;
			calcTable.setResult(findCommonAncestors, args, result);
			return result;
		}
		public function findCommonDescendants(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findCommonDescendants, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet;
			for each (var member:Object in s)
			{
				if (result == null)
					result = findDescendants(member);
				else
					result = result.intersect(findDescendants(member)) as FiniteSet;
			}
			if (result == null)
				result = EmptySet.INSTANCE;
			calcTable.setResult(findCommonDescendants, args, result);
			return result;
		}
		public function findCrown(s:FiniteSet, extant:FiniteSet):FiniteSet
		{
			if (s.empty)
				return s;
			if (extant.empty)
				return extant;
			return findNodeClade(extant.intersect(findNodeClade(s)) as FiniteSet);
		}
		public function findDescendants(x:Object):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findDescendants, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			var result:FiniteSet = HashSet.fromObject([x]);
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(0), x))
					result = result.union(findDescendants(arc.getMember(1))) as FiniteSet;
			}
			calcTable.setResult(findDescendants, args, result);
			return result;
		}
		public function findImmediateAncestors(x:Object):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findImmediateAncestors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(1), x))
					result.add(arc.getMember(0));
			}
			calcTable.setResult(findImmediateAncestors, args, result);
			return result;
		}
		public function findImmediateDescendants(x:Object):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findImmediateDescendants, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(0), x))
					result.add(arc.getMember(1));
			}
			calcTable.setResult(findImmediateDescendants, args, result);
			return result;
		}
		public function findMaximal(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findMaximal, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var x:Object in s)
			{
				var max:Boolean = true;
				for each (var y:Object in s)
				{
					if (x != y && precedes(x, y))
					{
						max = false;
						break;
					}
				}
				if (max)
					result.add(x);
			}
			calcTable.setResult(findMaximal, args, result);
			return result;
		}
		public function findMinimal(s:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(s.toArray())];
			const r:* = calcTable.getResult(findMinimal, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var x:Object in s)
			{
				var min:Boolean = true;
				for each (var y:Object in s)
				{
					if (x != y && precedes(y, x))
					{
						min = false;
						break;
					}
				}
				if (min)
					result.add(x);
			}
			calcTable.setResult(findMinimal, args, result);
			return result;
		}
		public function findNodeAncestor(s:FiniteSet):FiniteSet
		{
			return findMaximal(findCommonAncestors(s));
		}
		public function findNodeClade(s:FiniteSet):FiniteSet
		{
			return findAllDescendants(findNodeAncestor(s));
		}
		public function findParents(x:Object):FiniteSet
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(findParents, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			const result:MutableSet = new HashSet();
			for each (var arc:FiniteList in arcs)
			{
				if (arc.getMember(2) == 1 && Equality.equal(arc.getMember(1), x))
					result.add(arc.getMember(0));
			}
			calcTable.setResult(findParents, args, result);
			return result;
		}
		public function findPaths(ancestor:Object, descendant:Object):FiniteSet /* .<FiniteList> */
		{
			const args:Array = [ancestor, descendant];
			const r:* = calcTable.getResult(findPaths, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			if (Equality.equal(ancestor, descendant))
				return EmptySet.INSTANCE;
			const paths:MutableSet /* .<FiniteList> */ = new HashSet();
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(0), ancestor))
				{
					if (Equality.equal(arc.getMember(1), descendant))
					{
						paths.add([arc.getMember(0), arc.getMember(1)]);
					}
					else
					{
						var subpaths:FiniteCollection /* .<FiniteList> */
							= findPaths(arc.getMember(1), descendant);
						for each (var path:Array in subpaths)
						{
							paths.add([arc.getMember(0)].concat(path));
						}
					}
				}
			}
			calcTable.setResult(findPaths, args, paths);
			return paths;
		}
		public function findSynapomorphicAncestors(charSet:FiniteSet, specifierSet:FiniteSet):FiniteSet
		{
			const args:Array = [CalcTable.argumentsToToken(charSet.toArray()),
				CalcTable.argumentsToToken(specifierSet.toArray())];
			const r:* = calcTable.getResult(findSynapomorphicAncestors, args);
			if (r is FiniteSet)
				return r as FiniteSet;
			if (!specifierSet.subsetOf(charSet) || specifierSet.empty)
				return EmptySet.INSTANCE;
			const charCommonAncestors:FiniteSet = charSet.intersect(findCommonAncestors(specifierSet)) as FiniteSet;
			if (charCommonAncestors.empty)
				return EmptySet.INSTANCE;
			var result:HashSet = new HashSet();
			for each (var candidate:Object in charCommonAncestors)
			{
				var specifierPathsFound:uint = 0;
				for each (var specifier:Object in specifierSet)
				{
					if (Equality.equal(candidate, specifier))
					{
						++specifierPathsFound;
					}
					else
					{
						var pathFound:Boolean = false;
						var paths:FiniteSet /* .<Array> */ = findPaths(candidate, specifier);
						for each (var path:Array in paths)
						{
							if (HashSet.fromObject(path).subsetOf(charSet))
							{
								pathFound = true;
								++specifierPathsFound;
								break;
							}
						}
						if (!pathFound)
							break;
					}
				}
				if (specifierPathsFound == specifierSet.size)
					result.add(candidate);
			}
			calcTable.setResult(findSynapomorphicAncestors, args, result);
			return result;
		}
		public function findTotal(s:FiniteSet, extant:FiniteSet):FiniteSet
		{
			if (s.empty || extant.empty)
				return EmptySet.INSTANCE;
			const nodeClade:FiniteSet = findNodeClade(s);
			if (nodeClade.empty)
				return EmptySet.INSTANCE;
			const internalSpec:FiniteSet = nodeClade.intersect(extant) as FiniteSet;
			if (internalSpec.empty)
				return EmptySet.INSTANCE;
			const externalSpec:FiniteSet = extant.diff(internalSpec) as FiniteSet;
			return findBranchClade(internalSpec, externalSpec);
		}
		public function forEach(test:Function, thisObject:* = null):void
		{
			test.apply(thisObject, vertices);
			test.apply(thisObject, arcs);
		}
		override flash_proxy function getDescendants(name:*):*
		{
			if (hasProperty(name))
				return name;
			if (Proxy(vertices).flash_proxy::getDescendants(name) != undefined)
				return name;
			if (Proxy(arcs).flash_proxy::getDescendants(name) != undefined)
				return name;
			return undefined;
		}
		public function getMember(index:int):Object
		{
			if (index == 0)
				return vertices;
			if (index == 1)
				return arcs;
			return undefined;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == 0)
				return vertices;
			if (name == 1)
				return arcs;
			return undefined;
		}
		public function has(element:Object):Boolean
		{
			return vertices.equals(element) || arcs.equals(element);
		}
		public function hasAncestor(x:Object):Boolean
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(hasAncestor, args);
			if (r is Boolean)
				return r as Boolean;
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(1), x))
				{
					calcTable.setResult(hasAncestor, args, true);
					return true;
				}
			}
			calcTable.setResult(hasAncestor, args, false);
			return false;
		}
		public function hasDescendant(x:Object):Boolean
		{
			const args:Array = [x];
			const r:* = calcTable.getResult(hasDescendant, args);
			if (r is Boolean)
				return r as Boolean;
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(0), x))
				{
					calcTable.setResult(hasDescendant, args, true);
					return true;
				}
			}
			calcTable.setResult(hasDescendant, args, false);
			return false;
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return name == 0 || name == 1;
		}
		public function isParentOf(x:Object, y:Object, weight:Number = 1.0):Boolean
		{
			const args:Array = [x, y];
			const r:* = calcTable.getResult(isParentOf, args);
			if (r is Boolean)
				return r as Boolean;
			for each (var arc:FiniteList in arcs)
			{
				if (arc.size == 3 && arc.getMember(2) == weight && Equality.equal(arc.getMember(0), x)
					&& Equality.equal(arc.getMember(1), y))
				{
					calcTable.setResult(hasDescendant, args, true);
					return true;
				}
			}
			calcTable.setResult(isParentOf, args, false);
			return false;
		}
		public function map(mapper:Function, thisObject:* = null):FiniteCollection
		{
			const mapped:MutableCollection = new ArrayList();
			mapped.add(mapper.apply(thisObject, [vertices]));
			mapped.add(mapper.apply(thisObject, [arcs]));
			return mapped;
		}
		override flash_proxy function nextName(index:int):String
		{
	        return (index - 1).toString();
		}
		override flash_proxy function nextNameIndex(index:int):int
		{
	        return index < 2 ? ++index : 0;
		}
		override flash_proxy function nextValue(index:int):*
		{
	        if (index == 2)
	        	return arcs;
	        if (index == 1)
	        	return vertices;
	        return undefined;
		}
		public function precedes(x:Object, y:Object):Boolean
		{
			const args:Array = [x, y];
			const r:* = calcTable.getResult(precedes, args);
			if (r is Boolean)
				return r as Boolean;
			for each (var arc:FiniteList in arcs)
			{
				if (Equality.equal(arc.getMember(1), y) && precedesOrEquals(x, arc.getMember(0)))
				{
					calcTable.setResult(precedes, args, true);
					return true;
				}
			}
			calcTable.setResult(precedes, args, false);
			return false;
		}
		public function precedesOrEquals(x:Object, y:Object):Boolean
		{
			if (Equality.equal(x, y))
				return true;
			return precedes(x, y);
		}
		public function some(test:Function, thisObject:* = null):Boolean
		{
			return test.apply(thisObject, [vertices]) || test.apply(thisObject, [arcs]);
		}
		public function succeeds(x:Object, y:Object):Boolean
		{
			return precedes(y, x);
		}
		public function succeedsOrEquals(x:Object, y:Object):Boolean
		{
			if (Equality.equal(x, y))
				return true;
			return precedes(y, x);
		}
		public function reset():void
		{
			arcs.clear();
			vertices.clear();
			calcTable.reset();
		}
		public function toArray():Array
		{
			return [vertices, arcs];
		}
		public function toString():String
		{
			var s:String = "(" + vertices + ", {";
			var first:Boolean = true;
			for each (var arc:FiniteList in arcs)
			{
				if (first)
					first = false;
				else
					s += ", ";
				s += arc;
			}
			return s + "})";
		}
	}
}