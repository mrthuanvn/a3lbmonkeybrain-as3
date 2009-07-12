package a3lbmonkeybrain.brainstem.collections
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * The empty set; a list with no members.
	 * <p>
	 * If possible, this class should be used whenever an empty, immutable list is needed. Other implementations may not be as
	 * optimized.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 */
	public final class EmptyList extends AbstractEmptyCollection implements FiniteList
	{
		/**
		 * An instance of this list. Since all instances are identical, this constant should be used instead of calling the
		 * constructor.
		 */		
		public static const INSTANCE:EmptyList = new EmptyList();
		/**
		 * Creates a new instance. The constant <code>INSTANCE</code> should be used instead of instantiating this class.
		 * 
		 * @see #INSTANCE
		 */
		public function EmptyList()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */
		public function getMember(index:uint):Object
		{
			throw new RangeError("Empty list does not have members.");
		}
		/**
		 * @inheritDoc
		 */
		override public function equals(value:Object):Boolean
		{
			return value is List && List(value).empty;
		}
		/**
		 * A string representation of the empty list.
		 * 
		 * @returns
		 * 		<code>&quot;()&quot;</code>
		 */
		public function toString():String
		{
			return "()";
		}
	}
}