package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.filter.filterType;
	
	/**
	 * Stores a set (that is, a collection with no duplicates) of <code>Locator</code> objects.
	 *  
	 * @author T. Michael Keesey
	 * @see	Locator
	 */
	public final class LocatorSet
	{
		/**
		 * @private 
		 */
		private const _elements:MutableSet = new HashSet();
		/**
		 * Creates a new instance.
		 * 
		 * @param elements	[optional] - Original list of <code>Locator</code> objects to populate this set with.
		 * 					Duplicates and non-<code>Locator</code> objects in this array are discarded.
		 */
		public function LocatorSet(elements:Object /* of Locator */ = null)
		{
			super();
			_elements = HashSet.fromObject(elements).filter(filterType(Locator));
		}
		[ArrayElementType("a3lbmonkeybrain.motorcortex.locators.Locator")]
		/**
		 * This set of elements as an object. Can be an array, a collection, or any object whose
		 * members can be iterated over using a <code>for each..in</code> loop.
		 * <p>
		 * If set to <code>null</code>, clears this set.
		 * </p>
		 */
		public function get source():Object /* of Locator */
		{
			return _elements.toArray();
		}
		/**
		 * @private
		 */
		public function set source(value:Object /* of Locator */):void
		{
			_elements = [];
			if (value != null)
			{
				for (var i:uint = 0; i < value.length; ++i)
				{
					if (value[i] is Locator)
					{
						addElement(value[i] as Locator);
					}
				}
			}
		}
		/**
		 * The number of elements in this set.
		 */
		public function get size():uint
		{
			return _elements.length;
		}
		/**
		 * Adds an element to this set.
		 * 
		 * @param element	<code>Locator</code> object to add. If <code>element</code> is already
		 * 					in this set or <code>null</code>, this method does nothing.
		 */
		public function addElement(element:Locator):void {
			if (element) {
				if (!hasElement(element)) {
					_elements.push(element);
				}
			}
		}		
		/**
		 * Retrieves an element from this set by its (arbitrary) index.
		 * 
		 * @param index
		 * 		Arbitrary index from 0 to <code>size</code> - 1.
		 * @return
		 * 		A <code>Locator</code> object which is an element of this set.
		 * @throws RangeError
		 * 		If <code>index</code> is more than or equal to <code>size</code>.
		 * @see	#elements
		 * @see	#size
		 */
		public function getElement(index:uint):Locator {
			if (index >= _elements.length) {
				throw new RangeError();
			}
			return _elements[index] as Locator;
		}
		/**
		 * Checks if this set has a certain element.
		 * 
		 * @param element
		 * 		<code>Locator</code> object to check for.
		 * @return
		 * 		<code>true</code> if <code>element</code> is in this set; <code>false</code> if not.
		 */
		public function hasElement(element:Locator):Boolean {
			for (each var loc:Locator in _elements) {
				if (loc == element) {
					return true;
				}
			}
			return false;
		}
	}
}