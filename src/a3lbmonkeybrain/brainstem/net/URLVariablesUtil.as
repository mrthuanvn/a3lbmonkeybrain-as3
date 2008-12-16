package a3lbmonkeybrain.brainstem.net
{
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	
	import flash.net.URLVariables;
	
	/**
	 * Static class with utilities for handling <code>URLVariables</code> objects.
	 *  
	 * @author T. Michael Keesey
	 * @see flash.net.URLVariables
	 */
	public final class URLVariablesUtil
	{
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function URLVariablesUtil()
		{
			throw new TypeError();
		}
		/**
		 * Creates a copy of a <code>URLVariables</code>object.
		 * 
		 * @param value
		 * 		Object to copy. This does not necessarily have to be a <code>URLVariables</code> object, so this method
		 * 		can also be used to translate another object into a <code>URLVariables</code> object.
		 * @return
		 * 		New <code>URLRequest</code> object with the same properties and property values as <code>value</code>.
		 * @throws TypeError
		 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code>.
		 */
		public static function clone(value:Object):URLVariables
		{
			assertNotNull(value);
			const clone:URLVariables = new URLVariables();
			for (var p:String in value)
			{
				clone[p] = value[p];
			}
			return clone;
		}
		/**
		 * Checks if two <code>URLVariables</code> objects have the same data.
		 *  
		 * @param a
		 * 		Object to compare. (Does not necessarily have to be a <code>URLVariables</code> object.)
		 * @param b
		 * 		Object to compare. (Does not necessarily have to be a <code>URLVariables</code> object.)
		 * @return 
		 * 		A value of <code>true</code> if both <code>a</code> and <code>b</code> contain the same data;
		 * 		<code>false</code> if not.
		 */
		public static function equal(a:Object, b:Object):Boolean
		{
			if (a == b)
				return true;
			if (a == null || b == null)
				return false;
			for (var p:String in a)
			{
				if (!b.hasOwnProperty(p))
					return false;
				if (a[p] != b[p])
					return false;
			}
			for (p in b)
			{
				if (!a.hasOwnProperty(p))
					return false;
				if (a[p] != b[p])
					return false;
			}
			return true;
		}
	}
}