package a3lbmonkeybrain.brainstem.colors
{
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class ColorsTest extends TestCase
	{
		public function testFindAlpha():void
		{
			assertEquals(findAlpha(0xFFFFFF), 0);
			assertEquals(findAlpha(0xFFFFFFFF), 0xFF);
			assertEquals(findAlpha(0x10203040), 0x10);
		}
		public function testFindBlue():void
		{
			assertEquals(findBlue(0xFFFFFF), 0xFF);
			assertEquals(findBlue(0x10203040), 0x40);
			assertEquals(findBlue(0x102030), 0x30);
			assertEquals(findBlue(0x000077), 0x77);
			assertEquals(findBlue(0), 0);
			assertEquals(findBlue(0xAABBCC), 0xCC);
		}
		public function testFindGreen():void
		{
			assertEquals(findGreen(0xFFFFFF), 0xFF);
			assertEquals(findGreen(0x10203040), 0x30);
			assertEquals(findGreen(0x102030), 0x20);
			assertEquals(findGreen(0x000077), 0);
			assertEquals(findGreen(0), 0);
			assertEquals(findGreen(0xAABBCC), 0xBB);
		}
		public function testFindRed():void
		{
			assertEquals(findRed(0xFFFFFF), 0xFF);
			assertEquals(findRed(0x10203040), 0x20);
			assertEquals(findRed(0x102030), 0x10);
			assertEquals(findRed(0x000077), 0);
			assertEquals(findRed(0), 0);
			assertEquals(findRed(0xAABBCC), 0xAA);
		}
		public function testInterpolateColors():void
		{
			assertEquals(interpolateColors(0xFFFFFF, 0x000000, 0), 0xFFFFFF); 
			assertEquals(interpolateColors(0xFFFFFF, 0x000000, 1), 0x000000);
			assertEquals(interpolateColors(0xFFFFFF, 0x000000, 0.5), 0x7F7F7F);
			assertEquals(interpolateColors(0x000000, 0xFFFFFF, 0), 0x000000); 
			assertEquals(interpolateColors(0x000000, 0xFFFFFF, 1), 0xFFFFFF);
			assertEquals(interpolateColors(0x000000, 0xFFFFFF, 0.5), 0x7F7F7F);
		}
	}
}