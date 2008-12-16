package a3lbmonkeybrain.brainstem.relate
{
	import mx.collections.Sort;
	
	public final class OrderSort
	{
		private static var _sort:Sort;
		private static var _uniqueSort:Sort;
		public function OrderSort()
		{
			super();
			throw new TypeError();
		}
		/**
		 * An object which may be used to sort a list of objects.
		 * 
		 * @see #uniqueSort
		 * @see mx.collections.Sort
		 * @see mx.collections.IList#sort
		 */
		public static function get sort():Sort
		{
			if (_sort == null)
			{
				_sort = new Sort();
				_sort.compareFunction = Order.findOrder;
			}
			return _sort;
		}
		/**
		 * An object which may be used to sort a list of objects, where no object is repeated.
		 * 
		 * @see #sort
		 * @see mx.collections.Sort
		 * @see mx.collections.IList#sort
		 */
		public static function get uniqueSort():Sort
		{
			if (_uniqueSort == null)
			{
				_uniqueSort = new Sort();
				_uniqueSort.compareFunction = Order.findOrder;
				_uniqueSort.unique = true;
			}
			return _uniqueSort;
		}
	}
}