package a3lbmonkeybrain.brainstem.net
{
	import flash.net.URLVariables;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class URLVariablesUtilTest extends TestCase
	{
		public function testClone():void
		{
			var vars:URLVariables = new URLVariables();
			vars.foo = "bar";
			vars.bar = "foo";
			vars.num = 1.5;
			vars.int = 1;
			var vars2:URLVariables = URLVariablesUtil.clone(vars);
			assertEquals(vars.foo, vars2.foo);
			assertEquals(vars.bar, vars2.bar);
			assertEquals(vars.num, vars2.num);
			assertEquals(vars.int, vars2.int);
			assertTrue(URLVariablesUtil.equal(vars, vars2));
		}
		public function testEqual():void
		{
			var vars:URLVariables = new URLVariables();
			vars.foo = "bar";
			vars.bar = "foo";
			vars.num = 1.5;
			vars.int = 1;
			var vars2:URLVariables = new URLVariables();
			vars2.foo = "bar";
			vars2.bar = "foo";
			vars2.num = 1.5;
			vars2.int = 1;
			assertTrue(URLVariablesUtil.equal(vars, vars2));
			delete vars2.num;
			assertFalse(URLVariablesUtil.equal(vars, vars2));
			vars2.num = 2.5;
			assertFalse(URLVariablesUtil.equal(vars, vars2));
		}
	}
}