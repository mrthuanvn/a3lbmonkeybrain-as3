package a3lbmonkeybrain.calculia.geom
{
	import flexunit.framework.TestCase;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class AngleTest extends TestCase
	{
		public function testCreateFromDegrees():void
		{
			var a:Angle = Angle.createFromDegrees(180);
			assertEquals(180, a.degrees);
			assertEquals(Math.PI, a.radians);	
		}
		// :TODO: more
	}
}