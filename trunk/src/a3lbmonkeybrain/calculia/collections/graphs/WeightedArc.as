package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.ArrayList;
	import a3lbmonkeybrain.brainstem.collections.Collection;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableList;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class WeightedArc extends SimpleArc
	{
		private var _weight:Number;
		public function WeightedArc(head:Object, tail:Object, weight:Number)
		{
			super(head, tail);
			_weight = weight;
		}
		override public function get size():int
		{
			return 3;
		}
		override public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
			{
				const other:FiniteList = value as FiniteList;
				return other.size == 3
					&& Equality.equal(other.getMember(0), _head)
					&& Equality.equal(other.getMember(1), _tail)
					&& Equality.equal(other.getMember(2), _weight);
			}
			return false;
		}
		override public function every(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [_weight]) || super.every(test, thisObject);
		}
		override public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			const list:MutableList = new ArrayList();
			if (test.apply(thisObject, [_head]))
				list.add(_head);
			if (test.apply(thisObject, [_tail]))
				list.add(_tail);
			if (test.apply(thisObject, [_weight]))
				list.add(_weight);
			return list;
		}
		override public function forEach(test:Function, thisObject:*=null):void
		{
			super.forEach(test, thisObject);
			test.apply(thisObject, [_weight]);
		}
		override public function getMember(index:int):Object
		{
			if (index == 2)
				return _weight;
			return super.getMember(index);
		}
		override public function has(element:Object):Boolean
		{
			return element == _weight || super.has(element);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return name == 0 || name == 1 || name == 2;
		}
		override public function map(mapper:Function, thisObject:* = null):FiniteCollection
		{
			return new WeightedArc(mapper.apply(thisObject, [_head]),
				mapper.apply(thisObject, [_tail]), mapper.apply(thisObject, [_weight]));
		}
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextNameIndex(index:int):int
	    {
			if (index < 3)
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
	    	if (index == 3)
	    		return _weight;
	    	return undefined;
	    }
		override public function some(test:Function, thisObject:*=null):Boolean
		{
			return test.apply(thisObject, [_weight]) || super.some(test, thisObject);
		}
		override public function subsetOf(value:Object):Boolean
		{
			if (value is Collection)
			{
				const other:Collection = value as Collection;
				if (other.empty)
					return false;
				return other.has(_head) && other.has(_tail) && other.has(_weight); 
			}
			return subsetOf(HashSet.fromObject(value));
		}
		override public function toArray():Array
		{
			return [_head, _tail, _weight];
		}
		override public function toString():String 
		{
			return "(" + _head + ", " + _tail + ", " + _weight + ")";
		}
	}
}