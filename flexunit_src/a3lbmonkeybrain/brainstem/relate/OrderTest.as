package a3lbmonkeybrain.brainstem.relate
{
	import flexunit.framework.TestCase;
	
	import a3lbmonkeybrain.brainstem.core.Property;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class OrderTest extends TestCase
	{
		public function testFindOrder():void
		{
			assertTrue(Order.findOrder(null, null) == 0);
			assertTrue(Order.findOrder(1, null) > 0);
			assertTrue(Order.findOrder(null, 1) < 0);
			var d1:Date = new Date();
			var d2:Date = new Date(d1.time);
			assertTrue(Order.findOrder(d1, d2) == 0);
			assertTrue(Order.findOrder(d2, d1) == 0);
			assertTrue(Order.findOrder(d1, d2) == 0, ["fullYear", "month"]);
			assertTrue(Order.findOrder(d2, d1) == 0, ["fullYear", "month"]);
			d2.fullYear++;
			assertTrue(Order.findOrder(d1, d2) < 0);
			assertTrue(Order.findOrder(d2, d1) > 0);
			assertTrue(Order.findOrder(d1, d2) < 0, ["fullYear", "month"]);
			assertTrue(Order.findOrder(d2, d1) > 0, ["fullYear", "month"]);
			d2.fullYear -= 2;
			assertTrue(Order.findOrder(d1, d2) > 0);
			assertTrue(Order.findOrder(d2, d1) < 0);
			assertTrue(Order.findOrder(d1, d2) > 0, ["fullYear", "month"]);
			assertTrue(Order.findOrder(d2, d1) < 0, ["fullYear", "month"]);
			var orderedA:Ordered = new OrderedImpl(1, 2);
			var orderedB:Ordered = new OrderedImpl(1, 2);
			assertTrue(Order.findOrder(orderedA, orderedB) == 0);
			assertTrue(Order.findOrder(orderedB, orderedA) == 0);
			assertTrue(Order.findOrder(orderedA, orderedB, Property.AUTO_PROPERTIES) == 0);
			assertTrue(Order.findOrder(orderedB, orderedA, Property.AUTO_PROPERTIES) == 0);
			orderedB = new OrderedImpl(2, 2);
			assertTrue(Order.findOrder(orderedA, orderedB) < 0);
			assertTrue(Order.findOrder(orderedB, orderedA) > 0);
			assertTrue(Order.findOrder(orderedA, orderedB, Property.AUTO_PROPERTIES) < 0);
			assertTrue(Order.findOrder(orderedB, orderedA, Property.AUTO_PROPERTIES) > 0);
		}
		public function testFindOrderOfArrays():void
		{
			assertEquals(Order.findOrderOfArrays([], []), 0);
			assertTrue(Order.findOrderOfArrays([], [1]) < 0);
			assertTrue(Order.findOrderOfArrays([1], []) > 0);
			assertTrue(Order.findOrderOfArrays([1], [0]) > 0);
			assertEquals(Order.findOrderOfArrays([1, 2, 3, 4], [1, 2, 3, 4]), 0);
			assertTrue(Order.findOrderOfArrays([1, 2, 3, 3], [1, 2, 3, 4]) < 0);
			assertTrue(Order.findOrderOfArrays([1, 2, 3, 4], [1, 2, 3, 3]) > 0);
			assertTrue(Order.findOrderOfArrays([1, 2, [3, 3]], [1, 2, [3, 4]]) < 0);
			assertTrue(Order.findOrderOfArrays([1, 2, [3, 4]], [1, 2, [3, 3]]) > 0);
		}
	}
}