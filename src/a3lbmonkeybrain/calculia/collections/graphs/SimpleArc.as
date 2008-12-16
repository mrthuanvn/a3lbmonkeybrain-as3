package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.ArrayList;
	import a3lbmonkeybrain.brainstem.collections.Collection;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableList;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public class SimpleArc extends Proxy implements FiniteList
	{
		protected var _head:Object;
		protected var _tail:Object;
		public function SimpleArc(head:Object, tail:Object)
		{
			super();
			_head = head;
			_tail = tail;
		}
		public function get head():Object
		{
			return _head;
		}
		public function get singleMember():Object
		{
			throw new IllegalOperationError("Arcs cannot be singletons.");
		}
		public function get tail():Object
		{
			return _tail;
		}
		public function get size():int
		{
			return 2;
		}
		public function get empty():Boolean
		{
			return false;
		}
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			throw new IllegalOperationError();
		}
		public function diff(subtrahend:Object):Set
		{
			return HashSet.fromObject(this).diff(subtrahend);
		}
		public function every(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [_head]) && test.apply(thisObject, [_tail]);
		}
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
			{
				const other:FiniteList = value as FiniteList;
				return other.size == 2
					&& Equality.equal(other.getMember(0), _head)
					&& Equality.equal(other.getMember(1), _tail);
			}
			return false;
		}
		public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			const list:MutableList = new ArrayList();
			if (test.apply(thisObject, [_head]))
				list.add(_head);
			if (test.apply(thisObject, [_tail]))
				list.add(_tail);
			return list;
		}
		public function forEach(test:Function, thisObject:*=null):void
		{
			test.apply(thisObject, [_head]);
			test.apply(thisObject, [_tail]);
		}
		public function getMember(index:int):Object
		{
			if (index == 0)
				return _head;
			if (index == 1)
				return _tail;
			throw new RangeError("Index out of range: " + index);
		}
		override flash_proxy function getProperty(name:*):*
		{
			return getMember(name as int);
		}
		public function has(element:Object):Boolean
		{
			return Equality.equal(_head, element) || Equality.equal(_tail, element);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return name == 0 || name == 1;
		}
		public function intersect(operand:Object):Set
		{
			return HashSet.fromObject(this).intersect(operand);
		}
		public function map(mapper:Function, thisObject:* = null):FiniteCollection
		{
			return new SimpleArc(mapper.apply(thisObject, [_head]), mapper.apply(thisObject, [_tail]));
		}
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextName(index:int):String
	    {
	    	return String(index - 1);
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextNameIndex(index:int):int
	    {
			if (index < 2)
            	return index + 1;
            else
            	return 0;
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextValue(index:int):*
	    {
	    	if (index == 1)
	    		return _head;
	    	if (index == 2)
	    		return _tail;
	    	return undefined;
	    }
		public function prSubsetOf(value:Object):Boolean
		{
			return HashSet.fromObject(this).prSubsetOf(value);
		}
		public function some(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [_head]) || test.apply(thisObject, [_tail]);
		}
		public function subsetOf(value:Object):Boolean
		{
			if (value is Collection)
			{
				if (Collection(value).empty)
					return false;
				return Collection(value).has(_head) && Collection(value).has(_tail); 
			}
			return subsetOf(HashSet.fromObject(value));
		}
		public function toArray():Array
		{
			return [_head, _tail];
		}
		public function toString():String 
		{
			return "(" + _head + ", " + _tail + ")";
		}
		public function union(operand:Object):Set
		{
			return HashSet.fromObject(this).union(operand);
		}
	}
}