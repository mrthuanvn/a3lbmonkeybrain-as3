package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	internal class AbstractEmptyCollection extends Proxy implements FiniteCollection
	{
		public function AbstractEmptyCollection()
		{
			super();
		}
		public function equals(value:Object):Boolean
		{
			throw new AbstractMethodError();
		}
		public function get singleMember():Object
		{
			throw new IllegalOperationError("This collection does not have a single member.");
		}
		
		public function get empty():Boolean
		{
			return true;
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
			return true;
		}
		
		public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			return this;
		}
		
		public function forEach(callback:Function, thisObject:*=null):void
		{
			// Do nothing.
		}
		
		public function map(mapper:Function, thisObject:*=null):FiniteCollection
		{
			return this;
		}
		
		public function some(test:Function, thisObject:*=null):Boolean
		{
			return false;
		}
		
		public function toArray():Array
		{
			return [];
		}
		public function toVector():Vector.<Object>
		{
			return new Vector.<Object>(0);
		}
		
		/**
		 * @inheritDoc
		 */
		override flash_proxy function callProperty(name:*, ...args):*
		{
			return undefined;
		}
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			throw new RangeError("Cannot remove members of immutable collection.");
		}
		override flash_proxy function getProperty(name:*):*
		{
			return undefined;
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return false;
		}
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextName(index:int):String
	    {
	    	return null;
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextNameIndex(index:int):int
	    {
			return 0;
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextValue(index:int):*
	    {
	    	return undefined;
	    }
		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new IllegalOperationError("Cannot add members to immutable collection.");
		}
	}
}