package a3lbmonkeybrain.brainstem.net
{
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	
	import flash.net.URLRequestHeader;
	
	/**
	 * Static class with utilities for handling <code>URLRequestHeader</code> objects.
	 * 
	 * @author T. Michael Keesey
	 * @see flash.net.URLRequestHeader
	 */
	public final class URLRequestHeaderUtil
	{
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function URLRequestHeaderUtil()
		{
			throw new TypeError();
		}
		/**
		 * Creates a copy of a <code>URLRequestHeader</code> object.
		 * 
		 * @param value
		 * 		Object to copy.
		 * @return
		 * 		New <code>URLRequestHeader</code> object with the same data as <code>value</code>.
		 * @see flash.net.URLRequestHeader
		 * @throws TypeError
		 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code>.
		 */
		public static function clone(value:URLRequestHeader):URLRequestHeader
		{
			assertNotNull(value);
			return new URLRequestHeader(value.name, value.value);
		}
		/**
		 * Checks if two <code>URLRequestHeader</code> objects contain the same data.
		 *  
		 * @param a
		 * 		<code>URLRequestHeader</code> object to test.
		 * @param b
		 * 		<code>URLRequestHeader</code> object to test.
		 * @return 
		 * 		A value of <code>true</code> if <code>a</code> and <code>b</code> are both <code>null</code>, or if
		 * 		they are <code>URLRequestHeader</code> objects with the same data; <code>false</code> otherwise.
		 */
		public static function equal(a:URLRequestHeader, b:URLRequestHeader):Boolean
		{
			if (a == b)
				return true;
			if (a == null || b == null)
				return false;
			return a.name == b.name && a.value == b.value;
		}
	}
}