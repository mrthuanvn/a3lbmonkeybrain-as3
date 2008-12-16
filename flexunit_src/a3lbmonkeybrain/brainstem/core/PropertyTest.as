package a3lbmonkeybrain.brainstem.core
{
	import flexunit.framework.TestCase;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class PropertyTest extends TestCase
	{
		public function testGetSharedPropertyNames():void
		{
			var d1:Date = new Date();
			var d2:Date = new Date();
			assertEquals(Property.findSharedPropertyNames(d1, d2).length, 0);
			assertEquals(Property.findSharedPropertyNames(d2, d1).length, 0);
			var a:Object = {a:1, b:2, c:3};
			var b:Object = {b:2, c:3, d:4};
			var shared:Array = Property.findSharedPropertyNames(a, b);
			assertTrue(shared.indexOf("a") < 0);
			assertTrue(shared.indexOf("b") >= 0);
			assertTrue(shared.indexOf("c") >= 0);
			assertTrue(shared.indexOf("d") < 0);
			assertTrue(shared.indexOf("e") < 0);
		}
	}
}