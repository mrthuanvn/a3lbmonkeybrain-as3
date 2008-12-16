package a3lbmonkeybrain.brainstem.relate
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * Stores a stack of ordered, two-object comparisons. Used to prevent recursion.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class ComparisonStack
	{
		private const array:Array = [];
		/**
		 * Creates a new instance. 
		 */
		public function ComparisonStack()
		{
			super();
		}
		/**
		 * Pushes an ordered comparison onto this stack.
		 *  
		 * @param a
		 * 		First compared object.
		 * @param b
		 * 		Second compared object.
		 */
		public function add(a:Object, b:Object):void
		{
			array.push({a: a, b: b});
		}
		/**
		 * Checks if this stack contains an ordered comparison.
		 * 
		 * @param a
		 * 		First compared object.
		 * @param b
		 * 		Second compared object.
		 * @return
		 * 		A value of <code>true</code> if this stack contains a comparison of <code>a</code> to <code>b</code>
		 * 		(in that order), or <code>false</code> if not.
		 */
		public function contains(a:Object, b:Object):Boolean
		{
			for each (var stacked:Object in array)
			{
				if (stacked.a == a && stacked.b == b)
					return true;
			}
			return false;
		}
		/**
		 * Removes an ordered comparison from this stack.
		 *  
		 * @param a
		 * 		First compared object.
		 * @param b
		 * 		Second compared object.
		 * @throws flash.errors.IllegalOperationError
		 * 		<code>flash.errors.IllegalOperationError</code>: If there is no such comparison in this stack.
		 */
		public function remove(a:Object, b:Object):void
		{
			for (var i:int = array.length - 1; i >= 0; --i)
			{
				var stacked:Object = array[i];
				if (stacked.a == a && stacked.b == b)
				{
					stacked.a = null;
					stacked.b = null;
					array.splice(i, 1);
					return;
				}
			}
			throw new IllegalOperationError();
		}
	}
}