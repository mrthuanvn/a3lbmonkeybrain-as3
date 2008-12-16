package a3lbmonkeybrain.brainstem.core
{
	/**
	 * Static class with utilities for object properties.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class Property
	{
		/**
		 * A special array that signifies that properties should be gleaned using <code>getSharedPropertyNames()</code>.
		 * 
		 * @see #findSharedPropertyNames()
		 * @see a3lbmonkeybrain.relate.Equality#equal()
		 * @see a3lbmonkeybrain.relate.Order#findOrder()
		 */
		public static const AUTO_PROPERTIES:Array = [];
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function Property()
		{
			throw new TypeError();
		}
		/**
		 * Finds the names of all properties which are both present in two objects. 
		 * 
		 * @param a
		 * 		Object to check for properties.
		 * @param b
		 * 		Object to check for properties.
		 * @return 
		 * 		An array of strings, each string being the name of properties owned by <code>a</code> and
		 * 		<code>b</code>.
		 * @see Object#hasOwnProperty()
		 */
		public static function findSharedPropertyNames(a:Object, b:Object):Array /* .<String> */
		{
			if (a === null || b === null)
				return [];
			const properties:Array = [];
			for (var p:String in a)
			{
				if (b.hasOwnProperty(p))
					properties.push(p);
			}
			return properties.reverse();
		}
	}
}