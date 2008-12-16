package a3lbmonkeybrain.calculia.collections.sets
{
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public dynamic class AbstractSet extends Proxy implements Set
	{
		public function AbstractSet()
		{
			super();
		}
		public function get empty():Boolean
		{
			throw new AbstractMethodError();
		}
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			return undefined;
		}
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			return false;
		}
		public function diff(subtrahend:Object):Set
		{
			return SetDifference.create(this, subtrahend is Set ? Set(subtrahend) : HashSet.fromObject(subtrahend));
		}
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is Set)
				return subsetOf(value as Set) && Set(value).subsetOf(this);
			return false;
		}
		override flash_proxy function getProperty(name:*):*
		{
			return flash_proxy::hasProperty(name) ? name : undefined;
		}
		public function has(member:Object):Boolean
		{
			return flash_proxy::hasProperty(member);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			throw new AbstractMethodError();
		}
		public function intersect(operand:Object):Set
		{
			return SetIntersection.create(this, operand is Set ? Set(operand) : HashSet.fromObject(operand));
		}
		public function prSubsetOf(value:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		override flash_proxy function setProperty(name:*, value:*):void
		{
		}
		public function subsetOf(value:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		public function union(operand:Object):Set
		{
			return SetUnion.create(this, operand is Set ? Set(operand) : HashSet.fromObject(operand));
		}
	}
}