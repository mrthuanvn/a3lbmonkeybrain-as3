package a3lbmonkeybrain.brainstem.collections
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * The empty set; a set with no members.
	 * <p>
	 * If possible, this class should be used whenever an empty, immutable set is needed. Other implementations may not be as
	 * optimized.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 */
	public final class EmptySet extends AbstractEmptyCollection implements FiniteSet
	{
		/**
		 * An instance of this set. Since all instances are identical, this constant should be used instead of calling the
		 * constructor.
		 */		
		public static const INSTANCE:EmptySet = new EmptySet();
		/**
		 * Creates a new instance. The constant <code>INSTANCE</code> should be used instead of instantiating this class.
		 * 
		 * @see #INSTANCE
		 */
		public function EmptySet()
		{
			super();
		}
		/**
		 * Returns the set difference between this set and another object. Always yields the empty set.
		 *  
		 * @param subtrahend
		 * 		A set or object.
		 * @return 
		 * 		The empty set.
		 */
		public function diff(subtrahend:Object):Set
		{
			return this;
		}
		/**
		 * Checks if this set equals another object.
		 *  
		 * @param value
		 * 		Another object.
		 * @return 
		 * 		Returns <code>true</code> if <code>value</code> is an empty set; <code>false</code> otherwise.
		 */		
		override public function equals(value:Object):Boolean
		{
			return value is Set && Set(value).empty;
		}
		/**
		 * @inheritDoc
		 */
		public function intersect(operand:Object):Set
		{
			return this;
		}
		/**
		 * @inheritDoc
		 */
		public function prSubsetOf(value:Object):Boolean
		{
			if (equals(value))
				return false;
			for each (var member:* in value)
				return true;
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function subsetOf(value:Object):Boolean
		{
			return true;
		}
		/**
		 * A string representation of the empty set.
		 * 
		 * @returns
		 * 		<code>&quot;{}&quot;</code>
		 */
		public function toString():String
		{
			return "{}";
		}
		/**
		 * @inheritDoc
		 */
		public function union(operand:Object):Set
		{
			if (operand is Set)
				return operand as Set;
			return HashSet.fromObject(operand);
		}
	}
}