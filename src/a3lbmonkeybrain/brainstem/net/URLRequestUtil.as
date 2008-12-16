package a3lbmonkeybrain.brainstem.net
{
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	/**
	 * Static class with utilities for handling <code>URLRequest</code> objects.
	 * 
	 * @author T. Michael Keesey
	 * @see flash.net.URLRequest
	 */
	public final class URLRequestUtil
	{
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function URLRequestUtil()
		{
			throw new TypeError();
		}
		/**
		 * Creates a copy of a <code>URLRequest</code> object.
		 * 
		 * @param value
		 * 		Object to copy.
		 * @return
		 * 		New <code>URLRequest</code> object with the same data as <code>value</code>.
		 * @throws TypeError
		 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code>.
		 */
		public static function clone(value:URLRequest):URLRequest
		{
			assertNotNull(value);
			const clone:URLRequest = new URLRequest(value.url);
			clone.contentType = value.contentType;
			clone.data = URLVariablesUtil.clone(value.data);
			clone.digest = value.digest;
			clone.method = value.method;
			clone.requestHeaders = cloneRequestHeaders(value.requestHeaders);
			return clone;
		}
		/**
		 * @private
		 */
		private static function cloneRequestHeaders(value:Array /* .<URLRequestHeader> */):Array
			/* .<URLRequestHeader> */
		{
			if (value == null || value.length == 0)
				return [];
			const clone:Array = [];
			const n:int = value.length;
			for (var i:int = 0; i < n; ++i)
				clone.push(URLRequestHeaderUtil.clone(value[i] as URLRequestHeader));
			return clone;
		}
		/**
		 * Checks whether two <code>URLRequest</code> objects indicate the same resource.
		 * 
		 * @param a
		 * 		Request to compare.
		 * @param b
		 * 		Request to compare.
		 * @param strict
		 * 		If <code>false</code>, simply checks the URL (<code>URLRequest.url</code>) and the request data
		 * 		(<code>URLRequest.data</code>). If <code>true</code>, checks all fields, including content type
		 * 		(<code>URLRequest.contentType</code>), digest hash (<code>URLRequest.digest</code>), method
		 * 		(<code>URLRequest.method</code>), and request headers (<code>URLRequest.requestheaders</code>).
		 * @return
		 * 		A value of <code>true</code> if both requests indicate the same resource; <code>false</code> otherwise.
		 * @throws ArgumentError
		 * 		If <code>a</code> or <code>b</code> are <code>null</code>
		 * @see flash.net.URLRequest
		 * @see flash.net.URLRequest#contentType
		 * @see flash.net.URLRequest#data
		 * @see flash.net.URLRequest#digest
		 * @see flash.net.URLRequest#method
		 * @see flash.net.URLRequest#requestheaders
		 * @see flash.net.URLRequest#url
		 */
		public static function equal(a:URLRequest, b:URLRequest, strict:Boolean = false):Boolean
		{
			if (a == null || b == null)
				throw new ArgumentError();
			if (a.url != b.url || (strict && (a.contentType != b.contentType || a.digest != b.digest
				|| a.method != b.method || !Equality.arraysEqual(a.requestHeaders, b.requestHeaders, false, false))))
			{
				return false;
			}
			return URLVariablesUtil.equal(a.data, b.data);
		}
	}
}