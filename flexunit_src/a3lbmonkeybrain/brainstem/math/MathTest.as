package a3lbmonkeybrain.brainstem.math
{
	import a3lbmonkeybrain.brainstem.assert.assert;
	import a3lbmonkeybrain.brainstem.assert.assertEqual;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class MathTest extends TestCase
	{
		public function testAcot():void
		{
			for (var n:Number = 0.0; n < Math.PI * 2; n += 0.1)
			{
				assertEqual(n, cot(acot(n)));
			}
		}
		public function testAcsc():void
		{
			for (var n:Number = 0.0; n < Math.PI * 2; n += 0.1)
			{
				assertEqual(n, csc(acsc(n)));
			}
		}
		public function testAsec():void
		{
			for (var n:Number = 0.0; n < Math.PI * 2; n += 0.1)
			{
				assertEqual(n, sec(asec(n)));
			}
		}
		public function testClosestPowerOf2():void
		{
			assertEquals(closestPowerOf2(0), 0);
			assertEquals(closestPowerOf2(1), 1);
			assertEquals(closestPowerOf2(2), 2);
			assertEquals(closestPowerOf2(3), 4);
			assertEquals(closestPowerOf2(4), 4);
			assertEquals(closestPowerOf2(5), 4);
			assertEquals(closestPowerOf2(6), 8);
			assertEquals(closestPowerOf2(7), 8);
			assertEquals(closestPowerOf2(8), 8);
			assertEquals(closestPowerOf2(17), 16);
			assertEquals(closestPowerOf2(200), 256);
			assertEquals(closestPowerOf2(6000), 256);
		}
		public function testCot():void
		{
			
		}
		public function testCsc():void
		{
			
		}
		public function testFactorial():void
		{
			assertEqual(1, factorial(0));
			assertEqual(1, factorial(1));
			assertEqual(2, factorial(2));
			assertEqual(6, factorial(3));
			assertEqual(24, factorial(4));
			assertEqual(120, factorial(5));
			assertEqual(1307674368000, factorial(15));
		}
		public function testImplies():void
		{
			assert(implies(true, false));
			assert(!implies(false, false));
			assert(!implies(false, true));
			assert(!implies(true, true));
		}
		public function testSec():void
		{
			
		}
		public function testXor():void
		{
			assert(xor(true, false));
			assert(xor(false, true));
			assert(!xor(false, false));
			assert(!xor(true, true));
		}
	}
}