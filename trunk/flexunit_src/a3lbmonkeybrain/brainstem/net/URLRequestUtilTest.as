package a3lbmonkeybrain.brainstem.net
{
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class URLRequestUtilTest extends TestCase
	{
		public function testCloneAndEqual():void
		{
			var request:URLRequest = new URLRequest("http://foo.bar/");
			request.contentType = "foo/bar";
			var vars:URLVariables = new URLVariables();
			vars.fooStr = "bar";
			vars.fooNum = 2;
			request.data = vars;
			request.method = URLRequestMethod.GET;
			request.requestHeaders = [new URLRequestHeader("Content-type", "foobar"),
				new URLRequestHeader("X-Test", "test")];
			
			var request2:URLRequest = URLRequestUtil.clone(request);
			assertTrue(URLRequestUtil.equal(request, request2));
			
			request2 = URLRequestUtil.clone(request);
			request2.contentType = "";
			assertTrue(URLRequestUtil.equal(request, request2));
			assertFalse(URLRequestUtil.equal(request, request2, true));
			
			request2.data = new URLVariables();
			assertFalse(URLRequestUtil.equal(request, request2));
			assertFalse(URLRequestUtil.equal(request, request2, true));
			
			request2 = URLRequestUtil.clone(request);
			request2.method = URLRequestMethod.POST;
			assertTrue(URLRequestUtil.equal(request, request2));
			assertFalse(URLRequestUtil.equal(request, request2, true));
			
			request2 = URLRequestUtil.clone(request);
			request2.requestHeaders = [new URLRequestHeader("foo", "bar")];
			assertTrue(URLRequestUtil.equal(request, request2));
			assertFalse(URLRequestUtil.equal(request, request2, true));
			
			request2 = URLRequestUtil.clone(request);
			request2.url = "http://bar.foo/";
			assertFalse(URLRequestUtil.equal(request, request2));
			assertFalse(URLRequestUtil.equal(request, request2, true));
		}
	}
}