package a3lbmonkeybrain.brainstem.net
{
	import flash.net.URLRequestHeader;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class URLRequestHeaderUtilTest extends TestCase
	{
		public function testClone():void
		{
			var name:String = "foo";
			var value:String = "bar";
			var header:URLRequestHeader = new URLRequestHeader(name, value);
			var header2:URLRequestHeader = URLRequestHeaderUtil.clone(header);
			assertTrue(URLRequestHeaderUtil.equal(header, header2));
			assertEquals(header2.name, name);
			assertEquals(header2.value, value);
		}
		public function testEqual():void
		{
			assertTrue(URLRequestHeaderUtil.equal(null, null));
			var header:URLRequestHeader = new URLRequestHeader("foo", "bar");
			var header2:URLRequestHeader = new URLRequestHeader("foo", "bar");
			assertTrue(URLRequestHeaderUtil.equal(header, header2));
			assertTrue(URLRequestHeaderUtil.equal(header2, header));
			header2.name = "notFoo";
			assertFalse(URLRequestHeaderUtil.equal(header, header2));
			assertFalse(URLRequestHeaderUtil.equal(header, null));
			assertFalse(URLRequestHeaderUtil.equal(null, header2));
		}
	}
}